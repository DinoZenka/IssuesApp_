import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:issues_app/domain/entities/issue.dart';
import 'package:issues_app/presentation/extensions/issue_display_extenstions.dart';
import 'package:issues_app/theme/app_theme.dart';

class IssuePriorityBadge extends StatelessWidget {
  final IssuePriority priority;
  final TextStyle? textStyle;
  const IssuePriorityBadge({super.key, required this.priority, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 8,
      children: [
        SvgPicture.asset(priority.iconPath, width: 20, height: 20),
        Text(priority.label, style: textStyle ?? context.customStyles.body2),
      ],
    );
  }
}
