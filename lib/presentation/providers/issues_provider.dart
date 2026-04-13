import 'dart:async';
import 'dart:developer';
import 'package:issues_app/data/providers.dart';
import 'package:issues_app/domain/entities/issue.dart';
import 'package:issues_app/presentation/providers/app_snackbar_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'issues_provider.g.dart';

// data needed to display skeleton
final _skeletonIssues = List.generate(
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
    return _skeletonIssues;
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

    state = AsyncData(_skeletonIssues);
    final issues = await repo.getBootstrapIssues();
    state = AsyncData(issues);
  }

  Future<void> refresh() async {
    final repo = ref.read(issueRepositoryProvider);
    final snapshot = await repo.getCachedIssues();
    final fallbackIssues = snapshot.hasCachedIssues
        ? snapshot.issues
        : <Issue>[];

    if (!snapshot.hasCachedIssues || snapshot.isExpired) {
      state = AsyncData(_skeletonIssues);
    }

    await _refreshInForeground(fallbackIssues: fallbackIssues);
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

  Future<void> _refreshInForeground({List<Issue>? fallbackIssues}) async {
    final previous = state.value;
    final resolvedFallback = fallbackIssues ?? previous;

    try {
      final issues = await ref.read(issueRepositoryProvider).refreshIssues();
      state = AsyncData(issues);
    } catch (error, stackTrace) {
      _showRequestError(error);

      if (resolvedFallback != null) {
        state = AsyncData(resolvedFallback);
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
    final previousState = state.value ?? [];

    final oldIssue = previousState.firstWhere((i) => i.id == id);
    final optimisticIssue = oldIssue.copyWith(
      priority: priority ?? oldIssue.priority,
      status: status ?? oldIssue.status,
      updatedAt: DateTime.now(),
    );

    _updateLocalIssue(optimisticIssue);

    try {
      final repo = ref.read(issueRepositoryProvider);

      final data = <String, dynamic>{
        if (priority != null) 'priority': priority.name,
        if (status != null) 'status': status.name,
      };

      final updated = await repo.updateIssue(id, data);
      _updateLocalIssue(updated);
      return updated;
    } catch (e, stackTrace) {
      log(
        'Failed to update issue, rolling back',
        error: e,
        stackTrace: stackTrace,
      );
      state = AsyncData(previousState);
      _showRequestError(e);
      rethrow;
    }
  }

  void _showRequestError(Object error) {
    ref
        .read(appSnackbarProvider.notifier)
        .showMessage('Request failed: $error');
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
