import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:issues_app/data/repositories/mock_issue_repository.dart';
import 'package:issues_app/domain/entities/issue.dart';
import 'package:issues_app/domain/repositories/issue_repository.dart';

part 'issues_provider.g.dart';

@riverpod
Dio dio(Ref ref) {
  return Dio();
}

@riverpod
IssueRepository issueRepository(Ref ref) {
  return MockIssueRepository();
}

@riverpod
class IssuesNotifier extends _$IssuesNotifier {
  @override
  FutureOr<List<Issue>> build() {
    return ref.read(issueRepositoryProvider).getIssues();
  }

  Future<void> fetchByStatus(IssueStatus? status) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() {
      return ref.read(issueRepositoryProvider).getIssues(status: status);
    });
  }
}

@riverpod
FutureOr<({int open, int closed, int total})> issuesCounts(Ref ref) async {
  final issues = await ref.watch(issueRepositoryProvider).getIssues();
  final open = issues.where((i) => i.status == IssueStatus.open).length;
  final closed = issues.where((i) => i.status == IssueStatus.closed).length;
  return (open: open, closed: closed, total: issues.length);
}
