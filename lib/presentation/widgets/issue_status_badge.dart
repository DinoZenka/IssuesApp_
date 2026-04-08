import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:issues_app/domain/entities/issue.dart';
import 'package:issues_app/presentation/mappers/issue_display_mapper.dart';
import 'package:issues_app/theme/app_theme.dart';

class IssueStatusBadge extends StatelessWidget {
  final IssueStatus status;
  const IssueStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        SvgPicture.asset(statusIconPath(status), width: 20, height: 20),
        Text(statusLabel(status), style: context.customStyles.bodyRegular),
      ],
    );
  }
}
