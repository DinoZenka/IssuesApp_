import 'package:issues_app/data/datasources/local/issue_local_data_source.dart';
import 'package:issues_app/data/datasources/remote/issue_remote_data_source.dart';
import 'package:issues_app/domain/entities/issue.dart';
import 'package:issues_app/domain/repositories/issue_repository.dart';

class IssueRepositoryImpl implements IssueRepository {
  final IssueRemoteDataSource _remoteDataSource;
  final IssueLocalDataSource _localDataSource;
  final Duration staleTime;
  final Duration gcTime;

  IssueRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource, {
    this.staleTime = const Duration(minutes: 5),
    this.gcTime = const Duration(minutes: 30),
  });

  @override
  Future<List<Issue>> getBootstrapIssues() async {
    final snapshot = await getCachedIssues();

    if (snapshot.hasCachedIssues && !snapshot.isExpired) {
      return snapshot.issues;
    }

    try {
      return await refreshIssues();
    } catch (_) {
      return <Issue>[];
    }
  }

  @override
  Future<List<Issue>> getIssues() async {
    final snapshot = await getCachedIssues();
    if (snapshot.hasCachedIssues) {
      return snapshot.issues;
    }

    return refreshIssues();
  }

  @override
  Future<IssuesCacheSnapshot> getCachedIssues() async {
    final issues = await _localDataSource.getAllIssues();
    final lastSyncTime = await _localDataSource.getLastSyncTime();

    if (issues.isEmpty || lastSyncTime == null) {
      return const IssuesCacheSnapshot(
        issues: [],
        isStale: true,
        isExpired: true,
      );
    }

    final age = DateTime.now().difference(lastSyncTime);

    return IssuesCacheSnapshot(
      issues: issues,
      isStale: age > staleTime,
      isExpired: age > gcTime,
    );
  }

  @override
  Future<List<Issue>> refreshIssues() async {
    final remoteIssues = await _remoteDataSource.fetchIssues();
    final issues = remoteIssues.map((dto) => dto.toEntity()).toList();
    await _localDataSource.saveIssues(issues);
    return issues;
  }

  @override
  Future<Issue> getIssue(String id) async {
    final localIssue = await _localDataSource.getIssue(id);
    if (localIssue != null) {
      return localIssue;
    }

    final remoteIssue = await _remoteDataSource.getIssue(id);
    final issue = remoteIssue.toEntity();
    await _localDataSource.saveIssue(issue);
    return issue;
  }

  @override
  Future<Issue> updateIssue(String id, Map<String, dynamic> data) async {
    final remoteIssue = await _remoteDataSource.patchIssue(id, data);
    final issue = remoteIssue.toEntity();
    await _localDataSource.saveIssue(issue);
    return issue;
  }
}
