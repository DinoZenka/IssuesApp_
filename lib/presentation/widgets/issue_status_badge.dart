import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:issues_app/domain/entities/issue.dart';
import 'package:issues_app/presentation/extensions/issue_display_extenstions.dart';
import 'package:issues_app/theme/app_theme.dart';

class IssueStatusBadge extends StatelessWidget {
  final IssueStatus status;
  final TextStyle? textStyle;

  const IssueStatusBadge({super.key, required this.status, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 8,
      children: [
        SvgPicture.asset(status.iconPath, width: 20, height: 20),
        Text(
          status.label,
          style: textStyle ?? context.customStyles.bodyRegular,
        ),
      ],
    );
  }
}
