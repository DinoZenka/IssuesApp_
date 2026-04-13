import 'package:flutter/material.dart';
import 'package:issues_app/assets/app_icons.dart';
import 'package:issues_app/domain/entities/issue.dart';
import 'package:issues_app/presentation/screens/issue_details/widgets/last_update_row.dart';
import 'package:issues_app/presentation/screens/issue_details/widgets/labeled_segmented_control.dart';
import 'package:issues_app/presentation/widgets/issue_priority_badge.dart';
import 'package:issues_app/presentation/widgets/issue_status_badge.dart';
import 'package:issues_app/theme/app_theme.dart';

class TopCard extends StatelessWidget {
  final String title;
  final String lastUpdatedLabel;

  final List<IssuePriority> prioritiesOptions;
  final IssuePriority activePriority;
  final ValueChanged<IssuePriority> onPriorityChanged;

  final List<IssueStatus> statusOptions;
  final IssueStatus activeStatus;
  final ValueChanged<IssueStatus> onStatusChanged;

  const TopCard({
    super.key,
    required this.title,
    required this.lastUpdatedLabel,
    required this.prioritiesOptions,
    required this.activePriority,
    required this.onPriorityChanged,
    required this.statusOptions,
    required this.activeStatus,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainer,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: context.customStyles.h1),
          const SizedBox(height: 12),
          DetailsLastUpdatedRow(valueLabel: lastUpdatedLabel),
          const SizedBox(height: 20),
          const Divider(height: 1),
          const SizedBox(height: 16),
          LabeledSegmentedControl<IssuePriority>(
            values: prioritiesOptions,
            activeValue: activePriority,
            onChange: onPriorityChanged,
            iconPath: AppIcons.sparks,
            label: 'Priority',
            itemBuilder: (item, _, textStyle) {
              return IssuePriorityBadge(priority: item, textStyle: textStyle);
            },
          ),
          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 16),
          LabeledSegmentedControl<IssueStatus>(
            values: statusOptions,
            activeValue: activeStatus,
            onChange: onStatusChanged,
            iconPath: AppIcons.taskList,
            label: 'Status',
            itemBuilder: (item, _, textStyle) {
              return IssueStatusBadge(status: item, textStyle: textStyle);
            },
          ),
        ],
      ),
    );
  }
}
