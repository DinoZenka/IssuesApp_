enum IssuePriority { low, medium, high }

enum IssueStatus { open, closed }

class Issue {
  final String id;
  final String title;
  final String description;
  final IssuePriority priority;
  final IssueStatus status;
  final DateTime updatedAt;

  const Issue({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
    required this.updatedAt,
  });
}

sealed class IssueFilter {
  const IssueFilter();
}

class AllIssuesFilter extends IssueFilter {
  const AllIssuesFilter();
  @override
  String toString() => 'all';
}

class StatusFilter extends IssueFilter {
  final IssueStatus status;
  const StatusFilter(this.status);

  @override
  String toString() => status.name;
}
