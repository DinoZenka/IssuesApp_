import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fake_async/fake_async.dart';
import 'package:issues_app/data/providers.dart';
import 'package:issues_app/domain/entities/issue.dart';
import 'package:issues_app/domain/repositories/issue_repository.dart';
import 'package:issues_app/presentation/providers/app_snackbar_provider.dart';
import 'package:issues_app/presentation/providers/issues_provider.dart';

class MockIssueRepository extends Mock implements IssueRepository {}

class MockAppSnackbar extends Notifier<List<AppSnackbarEvent>>
    with Mock
    implements AppSnackbar {
  @override
  List<AppSnackbarEvent> build() => [];
}

class TestIssuesNotifier extends IssuesNotifier {
  TestIssuesNotifier(this._initialState);
  final List<Issue>? _initialState;

  @override
  FutureOr<List<Issue>> build() {
    if (_initialState != null) return _initialState;
    return super.build();
  }
}

void main() {
  late MockIssueRepository mockRepository;
  late MockAppSnackbar mockSnackbar;

  final tDateTime = DateTime.parse('2023-01-01T12:00:00.000Z');
  final tIssues = [
    Issue(
      id: '1',
      title: 'Open Issue',
      description: 'Desc',
      priority: IssuePriority.high,
      status: IssueStatus.open,
      updatedAt: tDateTime,
    ),
    Issue(
      id: '2',
      title: 'Closed Issue',
      description: 'Desc',
      priority: IssuePriority.low,
      status: IssueStatus.closed,
      updatedAt: tDateTime,
    ),
    Issue(
      id: '3',
      title: 'Another Open',
      description: 'Desc',
      priority: IssuePriority.medium,
      status: IssueStatus.open,
      updatedAt: tDateTime,
    ),
  ];

  setUpAll(() {
    registerFallbackValue(AsyncData<List<Issue>>([]));
  });

  setUp(() {
    mockRepository = MockIssueRepository();
    mockSnackbar = MockAppSnackbar();

    when(() => mockRepository.getCachedIssues()).thenAnswer(
      (_) async =>
          const IssuesCacheSnapshot(issues: [], isStale: true, isExpired: true),
    );
    when(() => mockRepository.getBootstrapIssues()).thenAnswer((_) async => []);
  });

  ProviderContainer createContainer({List<Issue>? initialIssues}) {
    final container = ProviderContainer(
      overrides: [
        issueRepositoryProvider.overrideWithValue(mockRepository),
        appSnackbarProvider.overrideWith(() => mockSnackbar),
        if (initialIssues != null)
          issuesProvider.overrideWith(() => TestIssuesNotifier(initialIssues)),
      ],
    );
    container.listen(issuesProvider, (_, _) {});
    return container;
  }

  group('filteredIssuesProvider', () {
    test('filters by status', () {
      final container = createContainer(initialIssues: tIssues);

      container
          .read(issuesStatusFilterProvider.notifier)
          .update(IssueStatus.open);
      expect(container.read(filteredIssuesProvider).length, 2);

      container
          .read(issuesStatusFilterProvider.notifier)
          .update(IssueStatus.closed);
      expect(container.read(filteredIssuesProvider).length, 1);
    });

    test('filters by search query', () {
      final container = createContainer(initialIssues: tIssues);

      container.read(issuesSearchQueryProvider.notifier).state = 'another';
      expect(container.read(filteredIssuesProvider).length, 1);
    });

    test('mock/skeleton issues bypass filtering as intended', () {
      final mockIssues = [
        Issue(
          id: 'm1',
          title: 'Skeleton',
          description: '',
          priority: IssuePriority.low,
          status: IssueStatus.open,
          updatedAt: tDateTime,
          isMock: true,
        ),
      ];
      final container = createContainer(initialIssues: mockIssues);

      container
          .read(issuesStatusFilterProvider.notifier)
          .update(IssueStatus.closed);
      container.read(issuesSearchQueryProvider.notifier).state = 'non-existent';

      expect(container.read(filteredIssuesProvider), mockIssues);
    });
    group('issuesCountsProvider', () {
      test('returns correct open/closed/total counts', () {
        final container = createContainer(initialIssues: tIssues);
        final counts = container.read(issuesCountsProvider);
        expect(counts.open, 2);
        expect(counts.closed, 1);
        expect(counts.total, 3);
      });
    });
  });

  group('IssuesSearchQuery', () {
    test('debounce behavior', () {
      fakeAsync((async) {
        final container = createContainer();
        container.listen(issuesSearchQueryProvider, (_, _) {});

        container.read(issuesSearchQueryProvider.notifier).update('abc');
        expect(container.read(issuesSearchQueryProvider), '');

        async.elapse(const Duration(milliseconds: 350));
        expect(container.read(issuesSearchQueryProvider), 'abc');
      });
    });
  });

  group('IssuesNotifier.refresh', () {
    test('successful refresh updates state', () async {
      final container = createContainer(initialIssues: tIssues);
      final newIssues = [tIssues[0].copyWith(title: 'New Title')];

      when(() => mockRepository.getCachedIssues()).thenAnswer(
        (_) async => IssuesCacheSnapshot(
          issues: tIssues,
          isStale: true,
          isExpired: false,
        ),
      );
      when(() => mockRepository.refreshIssues()).thenAnswer(
        (_) async => newIssues,
      );

      await container.read(issuesProvider.notifier).refresh();

      expect(container.read(issuesProvider).value, newIssues);
    });

    test('keeps fallback data on failure', () async {
      final container = createContainer(initialIssues: tIssues);

      when(() => mockRepository.getCachedIssues()).thenAnswer(
        (_) async => IssuesCacheSnapshot(
          issues: tIssues,
          isStale: true,
          isExpired: false,
        ),
      );
      when(
        () => mockRepository.refreshIssues(),
      ).thenThrow(Exception('Refresh failed'));
      when(() => mockSnackbar.showMessage(any())).thenReturn(null);

      await container.read(issuesProvider.notifier).refresh();

      expect(container.read(issuesProvider).value, tIssues);
      verify(() => mockSnackbar.showMessage(any())).called(1);
    });
  });

  group('IssuesNotifier methods', () {
    test('updateIssue: successful update', () async {
      final container = createContainer(initialIssues: tIssues);
      final issueToUpdate = tIssues[0];
      final updatedIssue = issueToUpdate.copyWith(status: IssueStatus.closed);

      when(() => mockRepository.updateIssue(any(), any())).thenAnswer(
        (_) async => updatedIssue,
      );

      final notifier = container.read(issuesProvider.notifier);
      final result = await notifier.updateIssue(
        id: issueToUpdate.id,
        status: IssueStatus.closed,
      );

      expect(result, updatedIssue);
      expect(
        container
            .read(issuesProvider)
            .value!
            .firstWhere((i) => i.id == issueToUpdate.id),
        updatedIssue,
      );
    });

    test('updateIssue: does optimistic update and rollback on failure',
        () async {
      final container = createContainer(initialIssues: tIssues);
      final issueToUpdate = tIssues[0];

      when(() => mockRepository.updateIssue(any(), any())).thenAnswer((
        _,
      ) async {
        await Future.delayed(const Duration(milliseconds: 100));
        throw Exception('Update failed');
      });
      when(() => mockSnackbar.showMessage(any())).thenReturn(null);

      final notifier = container.read(issuesProvider.notifier);
      final future = notifier.updateIssue(
        id: issueToUpdate.id,
        status: IssueStatus.closed,
      );

      expect(
        container
            .read(issuesProvider)
            .value!
            .firstWhere((i) => i.id == issueToUpdate.id)
            .status,
        IssueStatus.closed,
      );

      try {
        await future;
      } catch (_) {}

      expect(
        container
            .read(issuesProvider)
            .value!
            .firstWhere((i) => i.id == issueToUpdate.id)
            .status,
        IssueStatus.open,
      );

      await Future.delayed(Duration.zero);
      verify(() => mockSnackbar.showMessage(any())).called(1);
    });

    test('getIssue: successful get updates state', () async {
      final container = createContainer(initialIssues: tIssues);
      final issueToGet = tIssues[0];
      final refreshedIssue = issueToGet.copyWith(title: 'Refreshed Title');

      when(() => mockRepository.getIssue(issueToGet.id)).thenAnswer(
        (_) async => refreshedIssue,
      );

      final notifier = container.read(issuesProvider.notifier);
      final result = await notifier.getIssue(id: issueToGet.id);

      expect(result, refreshedIssue);
      expect(
        container
            .read(issuesProvider)
            .value!
            .firstWhere((i) => i.id == issueToGet.id),
        refreshedIssue,
      );
    });
  });

  group('IssuesNotifier initialization (_bootstrap)', () {
    test('loads from cache when valid and not stale', () async {
      when(() => mockRepository.getCachedIssues()).thenAnswer(
        (_) async => IssuesCacheSnapshot(
          issues: tIssues,
          isStale: false,
          isExpired: false,
        ),
      );

      final container = createContainer();

      await Future.delayed(Duration.zero);

      expect(container.read(issuesProvider).value, tIssues);
      verifyNever(() => mockRepository.refreshIssues());
      verifyNever(() => mockRepository.getBootstrapIssues());
    });

    test('loads from cache and refreshes in background when stale', () async {
      when(() => mockRepository.getCachedIssues()).thenAnswer(
        (_) async => IssuesCacheSnapshot(
          issues: tIssues,
          isStale: true,
          isExpired: false,
        ),
      );
      when(() => mockRepository.refreshIssues())
          .thenAnswer((_) async => tIssues);

      final container = createContainer();

      await Future.delayed(Duration.zero);

      expect(container.read(issuesProvider).value, tIssues);
      verify(() => mockRepository.refreshIssues()).called(1);
    });

    test('loads from bootstrap when no cache', () async {
      when(() => mockRepository.getCachedIssues()).thenAnswer(
        (_) async => const IssuesCacheSnapshot(
          issues: [],
          isStale: true,
          isExpired: true,
        ),
      );
      when(() => mockRepository.getBootstrapIssues())
          .thenAnswer((_) async => tIssues);

      final container = createContainer();

      await Future.delayed(Duration.zero);

      expect(container.read(issuesProvider).value, tIssues);
    });
  });
}
