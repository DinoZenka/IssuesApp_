import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:issues_app/domain/entities/issue.dart';
import 'package:issues_app/presentation/mappers/issue_display_mapper.dart';
import 'package:issues_app/theme/app_theme.dart';

class IssuePriorityBadge extends StatelessWidget {
  final IssuePriority priority;
  const IssuePriorityBadge({super.key, required this.priority});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        SvgPicture.asset(priorityIconPath(priority), width: 20, height: 20),
        Text(priorityLabel(priority), style: context.customStyles.body2),
      ],
    );
  }
}
