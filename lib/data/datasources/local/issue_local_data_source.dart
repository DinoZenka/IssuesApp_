import 'package:drift/drift.dart';
import 'package:issues_app/data/datasources/local/app_database.dart';
import 'package:issues_app/domain/entities/issue.dart';

abstract class IssueLocalDataSource {
  Future<List<Issue>> getAllIssues();
  Future<Issue?> getIssue(String id);
  Future<void> saveIssues(List<Issue> issues);
  Future<void> saveIssue(Issue issue);
  Future<DateTime?> getLastSyncTime();
}

class IssueLocalDataSourceImpl implements IssueLocalDataSource {
  final AppDatabase _db;

  IssueLocalDataSourceImpl(this._db);

  @override
  Future<List<Issue>> getAllIssues() async {
    final results = await _db.select(_db.localIssues).get();
    return results.map((row) => row.toEntity()).toList();
  }

  @override
  Future<Issue?> getIssue(String id) async {
    final result = await (_db.select(
      _db.localIssues,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return result?.toEntity();
  }

  @override
  Future<void> saveIssues(List<Issue> issues) async {
    final syncTime = DateTime.now();

    await _db.batch((batch) {
      batch.deleteAll(_db.localIssues);
      batch.insertAll(
        _db.localIssues,
        issues.map((i) => i.toCompanion(lastSyncedAt: syncTime)).toList(),
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  @override
  Future<void> saveIssue(Issue issue) async {
    final existing = await (_db.select(
      _db.localIssues,
    )..where((t) => t.id.equals(issue.id))).getSingleOrNull();
    final lastSyncedAt =
        existing?.lastSyncedAt ?? await getLastSyncTime() ?? DateTime.now();

    await _db
        .into(_db.localIssues)
        .insertOnConflictUpdate(issue.toCompanion(lastSyncedAt: lastSyncedAt));
  }

  @override
  Future<DateTime?> getLastSyncTime() async {
    final result =
        await (_db.select(_db.localIssues)
              ..orderBy([(t) => OrderingTerm.desc(t.lastSyncedAt)])
              ..limit(1))
            .getSingleOrNull();
    return result?.lastSyncedAt;
  }
}
