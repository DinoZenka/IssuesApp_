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

  Issue copyWith({
    String? title,
    String? description,
    IssuePriority? priority,
    IssueStatus? status,
    DateTime? updatedAt,
  }) {
    return Issue(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
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
