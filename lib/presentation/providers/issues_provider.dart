import 'dart:async';
import 'dart:developer';
import 'package:issues_app/data/providers.dart';
import 'package:issues_app/domain/entities/issue.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'issues_provider.g.dart';

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
    unawaited(_bootstrap());
    return _mockIssues;
  }

  Future<void> _bootstrap() async {
    final repo = ref.read(issueRepositoryProvider);
    final snapshot = await repo.getCachedIssues();

    if (snapshot.hasCachedIssues && !snapshot.isExpired) {
      state = AsyncData(snapshot.issues);

      if (snapshot.isStale) {
        unawaited(_refreshInBackground());
      }
      return;
    }

    state = AsyncData(_mockIssues);
    await _refreshInForeground();
  }

  Future<void> refresh() async {
    final repo = ref.read(issueRepositoryProvider);
    final snapshot = await repo.getCachedIssues();

    if (!snapshot.hasCachedIssues || snapshot.isExpired) {
      state = AsyncData(_mockIssues);
    }

    await _refreshInForeground();
  }

  Future<void> _refreshInBackground() async {
    try {
      final issues = await ref.read(issueRepositoryProvider).refreshIssues();
      state = AsyncData(issues);
    } catch (error, stackTrace) {
      log(
        'Failed to refresh issues cache in background',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> _refreshInForeground() async {
    final previous = state.value;

    try {
      final issues = await ref.read(issueRepositoryProvider).refreshIssues();
      state = AsyncData(issues);
    } catch (error, stackTrace) {
      if (previous != null) {
        state = AsyncData(previous);
        return;
      }

      state = AsyncError(error, stackTrace);
    }
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

  if (issues.any((issue) => issue.isMock)) {
    return issues;
  }

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
