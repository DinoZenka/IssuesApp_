import 'package:issues_app/domain/entities/issue.dart';

abstract interface class IssueRepository {
  Future<List<Issue>> getIssues({IssueStatus? status});
  Future<Issue> getIssue(String id);
}
