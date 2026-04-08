import 'package:issues_app/assets/app_icons.dart';
import 'package:issues_app/domain/entities/issue.dart';

String statusLabel(IssueStatus status) {
  switch (status) {
    case IssueStatus.open:
      return 'Open';
    case IssueStatus.closed:
      return 'Closed';
  }
}

String statusIconPath(IssueStatus status) {
  switch (status) {
    case IssueStatus.open:
      return AppIcons.statusOpen;
    case IssueStatus.closed:
      return AppIcons.statusClosed;
  }
}

String priorityLabel(IssuePriority priority) {
  switch (priority) {
    case IssuePriority.low:
      return 'Low';
    case IssuePriority.medium:
      return 'Medium';
    case IssuePriority.high:
      return 'High';
  }
}

String priorityIconPath(IssuePriority priority) {
  switch (priority) {
    case IssuePriority.low:
      return AppIcons.priorityLow;
    case IssuePriority.medium:
      return AppIcons.priorityMedium;
    case IssuePriority.high:
      return AppIcons.priorityHight;
  }
}
