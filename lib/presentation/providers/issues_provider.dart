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

final _mockIssues = List.generate(
  8,
  (index) => Issue(
    id: index.toString(),
    title: 'Loading issue title',
    description: 'Loading issue description',
    priority: IssuePriority.getRandom(),
    status: IssueStatus.getRandom(),
    updatedAt: DateTime.now(),
    isMock: true,
  ),
);

@riverpod
class IssuesNotifier extends _$IssuesNotifier {
  @override
  FutureOr<List<Issue>> build() {
    _fetchInitial();
    return _mockIssues;
  }

  Future<void> _fetchInitial() async {
    state = const AsyncLoading<List<Issue>>().copyWithPrevious(
      AsyncData(_mockIssues),
    );
    final issues = await ref.read(issueRepositoryProvider).getIssues();

    state = AsyncData(issues);
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
class IssuesStatusFilter extends _$IssuesStatusFilter {
  @override
  IssueStatus? build() => null; // null means 'All'

  void update(IssueStatus? status) => state = status;
}

@riverpod
class IssuesSearchQuery extends _$IssuesSearchQuery {
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
List<Issue> filteredIssues(Ref ref) {
  final issuesAsync = ref.watch(issuesProvider);
  final issues = issuesAsync.value ?? [];

  final searchQuery = ref.watch(issuesSearchQueryProvider).toLowerCase();
  final statusFilter = ref.watch(issuesStatusFilterProvider);

  return issues.where((issue) {
    final matchesStatus = statusFilter == null || issue.status == statusFilter;
    final matchesSearch = issue.title.toLowerCase().contains(searchQuery);
    return matchesStatus && matchesSearch;
  }).toList();
}

@riverpod
({int open, int closed, int total}) issuesCounts(Ref ref) {
  final issuesAsync = ref.watch(issuesProvider);
  final issues = issuesAsync.value ?? [];

  final open = issues.where((i) => i.status == IssueStatus.open).length;
  final closed = issues.where((i) => i.status == IssueStatus.closed).length;

  return (open: open, closed: closed, total: issues.length);
}
