import 'package:issues_app/domain/entities/issue.dart';

class IssuesCacheSnapshot {
  final List<Issue> issues;
  final bool isStale;
  final bool isExpired;

  const IssuesCacheSnapshot({
    required this.issues,
    required this.isStale,
    required this.isExpired,
  });

  bool get hasCachedIssues => issues.isNotEmpty;
}

abstract interface class IssueRepository {
  Future<List<Issue>> getIssues({IssueStatus? status});
  Future<IssuesCacheSnapshot> getCachedIssues();
  Future<List<Issue>> refreshIssues();
  Future<Issue> getIssue(String id);
  Future<Issue> updateIssue(String id, Map<String, dynamic> data);
}
