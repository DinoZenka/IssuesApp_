import 'package:issues_app/assets/app_icons.dart';
import 'package:issues_app/domain/entities/issue.dart';

extension IssueStatusX on IssueStatus {
  String get label => switch (this) {
    IssueStatus.open => 'Open',
    IssueStatus.closed => 'Closed',
  };

  String get iconPath => switch (this) {
    IssueStatus.open => AppIcons.statusOpen,
    IssueStatus.closed => AppIcons.statusClosed,
  };
}

extension IssueFilterX on IssueFilter {
  String get label => switch (this) {
    AllIssuesFilter() => 'All',
    StatusFilter(status: final s) => s.label,
  };
}

extension IssuePriorityX on IssuePriority {
  String get label => switch (this) {
    IssuePriority.low => 'Low',
    IssuePriority.medium => 'Medium',
    IssuePriority.high => 'High',
  };

  String get iconPath => switch (this) {
    IssuePriority.low => AppIcons.priorityLow,
    IssuePriority.medium => AppIcons.priorityMedium,
    IssuePriority.high => AppIcons.priorityHight,
  };
}
