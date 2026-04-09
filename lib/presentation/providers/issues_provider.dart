import 'dart:async';
import 'package:dio/dio.dart';
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

  Future<Issue> getIssue({required String id}) async {
    final repo = ref.read(issueRepositoryProvider);
    final response = await repo.getIssue(id);
    _updateLocalIssue(response);
    return response;
  }

  Future<Issue> updateIssue({
    required String id,
    IssuePriority? priority,
    IssueStatus? status,
  }) async {
    final repo = ref.read(issueRepositoryProvider);

    final data = <String, dynamic>{'priority': priority, 'status': status}
      ..removeWhere((_, value) => value == null);

    final updated = await repo.updateIssue(id, data);
    _updateLocalIssue(updated);

    return updated;
  }

  void _updateLocalIssue(Issue updated) {
    state = state.whenData(
      (issues) => [
        for (final issue in issues)
          if (issue.id == updated.id) updated else issue,
      ],
    );
  }
}

@riverpod
class SearchQuery extends _$SearchQuery {
  Timer? _debounce;

  @override
  String build() {
    ref.onDispose(() => _debounce?.cancel());
    return '';
  }

  void update(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      state = query;
    });
  }
}

@riverpod
FutureOr<List<Issue>> filteredIssues(Ref ref) async {
  final issuesAsync = ref.watch(issuesProvider);
  final query = ref.watch(searchQueryProvider).toLowerCase();

  final issues = issuesAsync.value ?? [];

  if (query.isEmpty) return issues;

  return issues
      .where((issue) => issue.title.toLowerCase().contains(query))
      .toList();
}

@riverpod
FutureOr<({int open, int closed, int total})> issuesCounts(Ref ref) async {
  final issues = await ref.watch(issueRepositoryProvider).getIssues();
  final open = issues.where((i) => i.status == IssueStatus.open).length;
  final closed = issues.where((i) => i.status == IssueStatus.closed).length;
  return (open: open, closed: closed, total: issues.length);
}
