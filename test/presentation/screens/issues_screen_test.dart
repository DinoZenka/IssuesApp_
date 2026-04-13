import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:issues_app/data/providers.dart';
import 'package:issues_app/domain/entities/issue.dart';
import 'package:issues_app/domain/repositories/issue_repository.dart';
import 'package:issues_app/presentation/providers/app_snackbar_provider.dart';
import 'package:issues_app/presentation/providers/issues_provider.dart';
import 'package:issues_app/presentation/screens/issues/issues_screen.dart';
import 'package:issues_app/presentation/screens/issues/widgets/status_control.dart';
import 'package:issues_app/presentation/screens/issues/widgets/list_item.dart';
import 'package:issues_app/theme/app_theme.dart';

class MockIssueRepository extends Mock implements IssueRepository {}

class MockAppSnackbar extends Notifier<List<AppSnackbarEvent>>
    with Mock
    implements AppSnackbar {
  @override
  List<AppSnackbarEvent> build() => [];
}

class MockGoRouter extends Mock implements GoRouter {}

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
  ];

  setUp(() {
    mockRepository = MockIssueRepository();
    mockSnackbar = MockAppSnackbar();

    when(() => mockRepository.getCachedIssues()).thenAnswer(
      (_) async =>
          const IssuesCacheSnapshot(issues: [], isStale: true, isExpired: true),
    );
    when(() => mockRepository.getBootstrapIssues()).thenAnswer((_) async => []);
  });

  Widget createWidget({List<Issue>? initialIssues, GoRouter? router}) {
    final container = ProviderContainer(
      overrides: [
        issueRepositoryProvider.overrideWithValue(mockRepository),
        appSnackbarProvider.overrideWith(() => mockSnackbar),
        if (initialIssues != null)
          issuesProvider.overrideWith(() => IssuesNotifierStub(initialIssues)),
      ],
    );

    final widget = UncontrolledProviderScope(
      container: container,
      child: MaterialApp.router(
        theme: AppTheme.lightTheme,
        routerConfig:
            router ??
            GoRouter(
              routes: [
                GoRoute(
                  path: '/',
                  builder: (context, state) => const IssuesScreen(),
                ),
                GoRoute(
                  path: '/details/:id',
                  builder: (context, state) =>
                      const Scaffold(body: Text('Details')),
                ),
              ],
            ),
      ),
    );

    return widget;
  }

  testWidgets('shows loading (skeleton) state initially', (tester) async {
    // We don't override issuesProvider, so it starts with skeleton
    await tester.pumpWidget(createWidget());

    // Skeletonizer should be enabled. ListItem titles in skeleton are 'Loading issue title'
    expect(find.text('Loading issue title'), findsWidgets);
  });

  testWidgets('shows empty state when no issues', (tester) async {
    await tester.pumpWidget(createWidget(initialIssues: []));
    await tester.pump();

    expect(find.text(emptyListTitle), findsOneWidget);
    expect(find.text(emptyListDescription), findsOneWidget);
  });

  testWidgets('shows list of issues correctly', (tester) async {
    await tester.pumpWidget(createWidget(initialIssues: tIssues));
    await tester.pump();

    expect(find.text('Open Issue'), findsOneWidget);
    expect(find.text('Closed Issue'), findsOneWidget);
    expect(find.byType(ListItem), findsNWidgets(2));
  });

  testWidgets('tapping an issue navigates to details', (tester) async {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(path: '/', builder: (context, state) => const IssuesScreen()),
        GoRoute(
          path: '/details/:id',
          builder: (context, state) =>
              const Scaffold(body: Text('Details Screen')),
        ),
      ],
    );

    await tester.pumpWidget(
      createWidget(initialIssues: tIssues, router: router),
    );
    await tester.pump();

    await tester.tap(find.text('Open Issue'));
    await tester.pumpAndSettle();

    expect(find.text('Details Screen'), findsOneWidget);
    expect(router.state.uri.path, '/details/1');
  });

  testWidgets('search field updates visible list', (tester) async {
    await tester.pumpWidget(createWidget(initialIssues: tIssues));
    await tester.pump();

    expect(find.text('Open Issue'), findsOneWidget);
    expect(find.text('Closed Issue'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Open');
    // Debounce is 300ms
    await tester.pump(const Duration(milliseconds: 350));

    expect(find.text('Open Issue'), findsOneWidget);
    expect(find.text('Closed Issue'), findsNothing);
  });

  testWidgets('status filter changes visible list', (tester) async {
    await tester.pumpWidget(createWidget(initialIssues: tIssues));
    await tester.pump();

    // Find the StatusControl and tap on 'Closed' filter option.
    final closedFilter = find.descendant(
      of: find.byType(StatusControl),
      matching: find.text('Closed'),
    );

    await tester.tap(closedFilter);
    await tester.pumpAndSettle();

    expect(find.text('Open Issue'), findsNothing);
    expect(find.text('Closed Issue'), findsOneWidget);
  });
}

class IssuesNotifierStub extends IssuesNotifier {
  final List<Issue> initialIssues;
  IssuesNotifierStub(this.initialIssues);

  @override
  FutureOr<List<Issue>> build() {
    return initialIssues;
  }
}
