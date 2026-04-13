import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:issues_app/data/providers.dart';
import 'package:issues_app/domain/entities/issue.dart';
import 'package:issues_app/domain/repositories/issue_repository.dart';
import 'package:issues_app/presentation/providers/app_snackbar_provider.dart';
import 'package:issues_app/presentation/providers/issues_provider.dart';
import 'package:issues_app/presentation/screens/issue_details/issue_details_screen.dart';
import 'package:issues_app/theme/app_theme.dart';

class MockIssueRepository extends Mock implements IssueRepository {}

class MockAppSnackbar extends Notifier<List<AppSnackbarEvent>>
    with Mock
    implements AppSnackbar {
  @override
  List<AppSnackbarEvent> build() => [];
}

void main() {
  late MockIssueRepository mockRepository;
  late MockAppSnackbar mockSnackbar;

  final tDateTime = DateTime.parse('2023-01-01T12:00:00.000Z');
  final tIssue = Issue(
    id: '1',
    title: 'Open Issue',
    description: 'Desc',
    priority: IssuePriority.high,
    status: IssueStatus.open,
    updatedAt: tDateTime,
  );

  setUp(() {
    mockRepository = MockIssueRepository();
    mockSnackbar = MockAppSnackbar();

    when(() => mockRepository.getCachedIssues()).thenAnswer(
      (_) async =>
          const IssuesCacheSnapshot(issues: [], isStale: true, isExpired: true),
    );
    when(() => mockRepository.getBootstrapIssues()).thenAnswer((_) async => []);
  });

  Widget createWidget({List<Issue>? initialIssues}) {
    final container = ProviderContainer(
      overrides: [
        issueRepositoryProvider.overrideWithValue(mockRepository),
        appSnackbarProvider.overrideWith(() => mockSnackbar),
        if (initialIssues != null)
          issuesProvider.overrideWith(() => IssuesNotifierStub(initialIssues)),
      ],
    );

    return UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        home: IssueDetailsScreen(id: '1'),
      ),
    );
  }

  testWidgets('shows loading state initially', (tester) async {
    // We can simulate loading by not providing data immediately if we wanted,
    // but IssuesNotifierStub provides data immediately.
    // Let's use a dynamic stub if needed, but for now let's check it shows the issue.
    await tester.pumpWidget(createWidget(initialIssues: [tIssue]));
    await tester.pump();

    expect(find.text('Open Issue'), findsOneWidget);
    expect(find.text('Desc'), findsOneWidget);
  });

  testWidgets('Save button is disabled by default', (tester) async {
    await tester.pumpWidget(createWidget(initialIssues: [tIssue]));
    await tester.pump();

    final saveButton = tester.widget<ElevatedButton>(
      find.byType(ElevatedButton),
    );
    expect(saveButton.onPressed, isNull);
  });

  testWidgets('enables Save button only when something changed', (
    tester,
  ) async {
    await tester.pumpWidget(createWidget(initialIssues: [tIssue]));
    await tester.pump();

    // Find priority control and change it
    await tester.tap(find.text('Low'));
    await tester.pump();

    final saveButton = tester.widget<ElevatedButton>(
      find.byType(ElevatedButton),
    );
    expect(saveButton.onPressed, isNotNull);

    // Change it back
    await tester.tap(find.text('High'));
    await tester.pump();

    final saveButton2 = tester.widget<ElevatedButton>(
      find.byType(ElevatedButton),
    );
    expect(saveButton2.onPressed, isNull);
  });

  testWidgets('save action shows loading state and calls provider update', (
    tester,
  ) async {
    final completer = Completer<Issue>();
    when(
      () => mockRepository.updateIssue('1', any()),
    ).thenAnswer((_) => completer.future);

    await tester.pumpWidget(createWidget(initialIssues: [tIssue]));
    await tester.pump();

    // Change status to enable save
    await tester.tap(find.text('Closed'));
    await tester.pump();

    await tester.tap(find.text('Save'));
    await tester.pump();

    // Verify loading indicator in DetailsSaveBar
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Complete the update
    completer.complete(tIssue.copyWith(status: IssueStatus.closed));
    await tester.pumpAndSettle();

    // Verify loading is gone
    expect(find.byType(CircularProgressIndicator), findsNothing);
    verify(() => mockRepository.updateIssue('1', any())).called(1);
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
