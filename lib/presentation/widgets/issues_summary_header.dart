import 'package:flutter/material.dart';
import 'package:issues_app/presentation/widgets/issue_count_card.dart';
import 'package:issues_app/presentation/widgets/issues_progress_bar.dart';
import 'package:issues_app/theme/app_theme.dart';

class IssuesSummaryHeader extends StatelessWidget {
  final String title;
  final String subtitleDate;
  final int openCount;
  final int closedCount;
  final int totalCount;

  const IssuesSummaryHeader({
    super.key,
    required this.title,
    required this.subtitleDate,
    required this.openCount,
    required this.closedCount,
  }) : totalCount = openCount + closedCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 22, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: context.customStyles.subtitle1),
              Text(subtitleDate, style: context.customStyles.bodyRegular),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            '$totalCount',
            style: context.customStyles.display1,
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 16),
          IssuesProgresslBar(closedCount: closedCount, openCount: openCount),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: IssueCountCard(count: openCount, status: 'open'),
              ),
              Expanded(
                child: IssueCountCard(count: closedCount, status: 'closed'),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
