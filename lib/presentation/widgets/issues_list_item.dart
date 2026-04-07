import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:issues_app/assets/app_icons.dart';
import 'package:issues_app/theme/app_theme.dart';

enum IssuePriority { low, medium, high }

enum IssueStatus { open, closed }

class IssueModel {
  final String id;
  final String title;
  final String description;
  final IssuePriority priority;
  final IssueStatus status;
  final String updatedAt;

  const IssueModel({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
    required this.updatedAt,
  });
}

class IssuesListItem extends StatelessWidget {
  final IssueModel item;
  final VoidCallback? onTap;

  const IssuesListItem({super.key, required this.item, this.onTap});

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.all(Radius.circular(16)),
        border: Border.all(color: context.customColors.border!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 8,
            children: [
              SvgPicture.asset(
                statusIconPath(item.status),
                width: 20,
                height: 20,
              ),
              Text(
                statusLabel(item.status),
                style: context.customStyles.bodyRegular,
              ),
              const Spacer(),
              SvgPicture.asset(
                priorityIconPath(item.priority),
                width: 20,
                height: 20,
              ),
              Text(
                priorityLabel(item.priority),
                style: context.customStyles.body2,
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 12),
          Text(item.title, style: context.customStyles.subtitle2),
          const SizedBox(height: 8),
          Text(
            item.description,
            style: context.customStyles.body2,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
