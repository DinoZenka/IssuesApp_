import 'package:flutter/material.dart';
import 'package:issues_app/domain/entities/issue.dart';
import 'package:issues_app/presentation/extensions/issue_display_extenstions.dart';
import 'package:issues_app/theme/app_theme.dart';

class IssueCountCard extends StatelessWidget {
  final int count;
  final IssueStatus status;
  const IssueCountCard({super.key, required this.count, required this.status});

  Color _getDotColor(IssueStatus status, BuildContext context) {
    switch (status) {
      case IssueStatus.open:
        return context.customColors.green80!;
      case IssueStatus.closed:
        return context.customColors.purple80!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: theme.canvasColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(status.label, style: context.customStyles.body2),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(count.toString(), style: context.customStyles.subtitle1),
                const SizedBox(width: 8),
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _getDotColor(status, context),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
