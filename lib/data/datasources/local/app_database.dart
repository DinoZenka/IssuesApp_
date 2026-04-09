import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:issues_app/domain/entities/issue.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class LocalIssues extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  IntColumn get priority => integer()(); // Store enum index
  IntColumn get status => integer()(); // Store enum index
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get lastSyncedAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [LocalIssues])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

extension LocalIssueDataX on LocalIssue {
  Issue toEntity() {
    return Issue(
      id: id,
      title: title,
      description: description,
      priority: IssuePriority.values[priority],
      status: IssueStatus.values[status],
      updatedAt: updatedAt,
    );
  }
}

extension IssueCompanionX on Issue {
  LocalIssuesCompanion toCompanion({DateTime? lastSyncedAt}) {
    return LocalIssuesCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      priority: Value(priority.index),
      status: Value(status.index),
      updatedAt: Value(updatedAt),
      lastSyncedAt: Value(lastSyncedAt ?? DateTime.now()),
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
