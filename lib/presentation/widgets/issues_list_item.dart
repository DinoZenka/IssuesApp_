import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:issues_app/assets/app_icons.dart';
import 'package:issues_app/domain/entities/issue.dart';
import 'package:issues_app/presentation/widgets/issue_priority_badge.dart';
import 'package:issues_app/presentation/widgets/issue_status_badge.dart';
import 'package:issues_app/theme/app_theme.dart';

class IssuesListItem extends StatelessWidget {
  final Issue item;
  final VoidCallback? onTap;

  const IssuesListItem({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Container(
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
              children: [
                IssueStatusBadge(status: item.status),
                const Spacer(),
                IssuePriorityBadge(priority: item.priority),
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
            const SizedBox(height: 12),
            Row(
              spacing: 8,
              children: [
                SvgPicture.asset(AppIcons.clock, width: 20, height: 20),
                Text(
                  item.updatedAt.toIso8601String(),
                  style: context.customStyles.body2,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
