import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:issues_app/data/datasources/local/issue_local_data_source.dart';
import 'package:issues_app/data/datasources/remote/issue_remote_data_source.dart';
import 'package:issues_app/data/models/issue_dto.dart';
import 'package:issues_app/data/repositories/issue_repository_impl.dart';
import 'package:issues_app/domain/entities/issue.dart';

class MockIssueRemoteDataSource extends Mock implements IssueRemoteDataSource {}

class MockIssueLocalDataSource extends Mock implements IssueLocalDataSource {}

class FakeIssue extends Fake implements Issue {}

void main() {
  late IssueRepositoryImpl repository;
  late MockIssueRemoteDataSource mockRemoteDataSource;
  late MockIssueLocalDataSource mockLocalDataSource;

  setUpAll(() {
    registerFallbackValue(FakeIssue());
    registerFallbackValue(<Issue>[]);
  });

  setUp(() {
    mockRemoteDataSource = MockIssueRemoteDataSource();
    mockLocalDataSource = MockIssueLocalDataSource();
    repository = IssueRepositoryImpl(
      mockRemoteDataSource,
      mockLocalDataSource,
      staleTime: const Duration(minutes: 5),
      gcTime: const Duration(minutes: 30),
    );
  });

  // Using a fixed DateTime to avoid precision issues during string conversion
  final tDateTime = DateTime.parse('2023-01-01T12:00:00.000Z');

  final tIssue = Issue(
    id: '1',
    title: 'Test Issue',
    description: 'Test Description',
    priority: IssuePriority.high,
    status: IssueStatus.open,
    updatedAt: tDateTime,
  );

  final tIssueDto = IssueDto(
    id: '1',
    title: 'Test Issue',
    description: 'Test Description',
    priority: 'high',
    status: 'open',
    updatedAt: tDateTime.toIso8601String(),
  );

  group('getBootstrapIssues', () {
    test('returns cached issues when cache is fresh', () async {
      final freshTime = DateTime.now();
      when(
        () => mockLocalDataSource.getAllIssues(),
      ).thenAnswer((_) async => [tIssue]);
      when(
        () => mockLocalDataSource.getLastSyncTime(),
      ).thenAnswer((_) async => freshTime);

      final result = await repository.getBootstrapIssues();

      expect(result, [tIssue]);
      verify(() => mockLocalDataSource.getAllIssues()).called(1);
      verify(() => mockLocalDataSource.getLastSyncTime()).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('refreshes from remote when cache is expired', () async {
      final expiredTime = DateTime.now().subtract(const Duration(hours: 1));
      when(
        () => mockLocalDataSource.getAllIssues(),
      ).thenAnswer((_) async => [tIssue]);
      when(
        () => mockLocalDataSource.getLastSyncTime(),
      ).thenAnswer((_) async => expiredTime);
      when(
        () => mockRemoteDataSource.fetchIssues(),
      ).thenAnswer((_) async => [tIssueDto]);
      when(
        () => mockLocalDataSource.saveIssues(any()),
      ).thenAnswer((_) async => {});

      final result = await repository.getBootstrapIssues();

      expect(result, [tIssue]);
      verify(() => mockRemoteDataSource.fetchIssues()).called(1);
      verify(() => mockLocalDataSource.saveIssues(any())).called(1);
    });

    test('refreshes from remote when cache is empty', () async {
      when(
        () => mockLocalDataSource.getAllIssues(),
      ).thenAnswer((_) async => []);
      when(
        () => mockLocalDataSource.getLastSyncTime(),
      ).thenAnswer((_) async => null);
      when(
        () => mockRemoteDataSource.fetchIssues(),
      ).thenAnswer((_) async => [tIssueDto]);
      when(
        () => mockLocalDataSource.saveIssues(any()),
      ).thenAnswer((_) async => {});

      final result = await repository.getBootstrapIssues();

      expect(result, [tIssue]);
      verify(() => mockRemoteDataSource.fetchIssues()).called(1);
    });

    test('falls back to [] when refresh fails', () async {
      when(
        () => mockLocalDataSource.getAllIssues(),
      ).thenAnswer((_) async => []);
      when(
        () => mockLocalDataSource.getLastSyncTime(),
      ).thenAnswer((_) async => null);
      when(
        () => mockRemoteDataSource.fetchIssues(),
      ).thenThrow(Exception('Remote failed'));

      final result = await repository.getBootstrapIssues();

      expect(result, []);
    });
  });

  group('refreshIssues', () {
    test('saves remote results into local storage on refresh', () async {
      when(
        () => mockRemoteDataSource.fetchIssues(),
      ).thenAnswer((_) async => [tIssueDto]);
      when(
        () => mockLocalDataSource.saveIssues(any()),
      ).thenAnswer((_) async => {});

      final result = await repository.refreshIssues();

      expect(result, [tIssue]);
      verify(() => mockRemoteDataSource.fetchIssues()).called(1);
      verify(() => mockLocalDataSource.saveIssues([tIssue])).called(1);
    });
  });

  group('getIssue', () {
    test('returns local issue first if available', () async {
      when(
        () => mockLocalDataSource.getIssue('1'),
      ).thenAnswer((_) async => tIssue);

      final result = await repository.getIssue('1');

      expect(result, tIssue);
      verify(() => mockLocalDataSource.getIssue('1')).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('fetches from remote and saves locally if not in cache', () async {
      when(
        () => mockLocalDataSource.getIssue('1'),
      ).thenAnswer((_) async => null);
      when(
        () => mockRemoteDataSource.getIssue('1'),
      ).thenAnswer((_) async => tIssueDto);
      when(
        () => mockLocalDataSource.saveIssue(any()),
      ).thenAnswer((_) async => {});

      final result = await repository.getIssue('1');

      expect(result, tIssue);
      verify(() => mockRemoteDataSource.getIssue('1')).called(1);
      verify(() => mockLocalDataSource.saveIssue(tIssue)).called(1);
    });
  });

  group('updateIssue', () {
    test('updates local cache after updateIssue', () async {
      final updateData = {'status': 'closed'};
      final updatedIssueDto = IssueDto(
        id: '1',
        title: 'Test Issue',
        description: 'Test Description',
        priority: 'high',
        status: 'closed',
        updatedAt: tDateTime.toIso8601String(),
      );
      final updatedIssue = updatedIssueDto.toEntity();

      when(
        () => mockRemoteDataSource.patchIssue('1', updateData),
      ).thenAnswer((_) async => updatedIssueDto);
      when(
        () => mockLocalDataSource.saveIssue(any()),
      ).thenAnswer((_) async => {});

      final result = await repository.updateIssue('1', updateData);

      expect(result, updatedIssue);
      verify(() => mockRemoteDataSource.patchIssue('1', updateData)).called(1);
      verify(() => mockLocalDataSource.saveIssue(updatedIssue)).called(1);
    });
  });
}
