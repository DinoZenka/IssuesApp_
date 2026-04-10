import 'package:dio/dio.dart';
import 'package:issues_app/app_config.dart';
import 'package:issues_app/data/datasources/local/app_database.dart';
import 'package:issues_app/data/datasources/local/issue_local_data_source.dart';
import 'package:issues_app/data/datasources/remote/issue_remote_data_source.dart';
import 'package:issues_app/data/datasources/remote/issue_remote_data_source_mock.dart';
import 'package:issues_app/data/repositories/issue_repository_impl.dart';
import 'package:issues_app/domain/repositories/issue_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
Dio dio(Ref ref) {
  return Dio(
    BaseOptions(
      baseUrl: AppConfig.baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ),
  );
}

@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
}

@Riverpod(keepAlive: true)
IssueLocalDataSource issueLocalDataSource(Ref ref) {
  return IssueLocalDataSourceImpl(ref.watch(appDatabaseProvider));
}

@riverpod
IssueRemoteDataSource issueRemoteDataSource(Ref ref) {
  if (AppConfig.remoteDatasourceMock) {
    return IssueRemoteDataSourceMockImpl();
  }
  return IssueRemoteDataSourceImpl(ref.watch(dioProvider));
}

@Riverpod(keepAlive: true)
IssueRepository issueRepository(Ref ref) {
  return IssueRepositoryImpl(
    ref.watch(issueRemoteDataSourceProvider),
    ref.watch(issueLocalDataSourceProvider),
  );
}
