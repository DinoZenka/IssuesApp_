import 'dart:math';

enum IssuePriority {
  low,
  medium,
  high;

  static IssuePriority getRandom() {
    final random = Random();
    return values[random.nextInt(values.length)];
  }
}

enum IssueStatus {
  open,
  closed;

  static IssueStatus getRandom() {
    final random = Random();
    return values[random.nextInt(values.length)];
  }
}

class Issue {
  final String id;
  final String title;
  final String description;
  final IssuePriority priority;
  final IssueStatus status;
  final DateTime updatedAt;
  final bool isMock;

  const Issue({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
    required this.updatedAt,
    this.isMock = false,
  });

  Issue copyWith({
    String? title,
    String? description,
    IssuePriority? priority,
    IssueStatus? status,
    DateTime? updatedAt,
    bool? isMock,
  }) {
    return Issue(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      updatedAt: updatedAt ?? this.updatedAt,
      isMock: isMock ?? this.isMock,
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
