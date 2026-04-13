import 'package:flutter/material.dart';
import 'package:issues_app/domain/entities/issue.dart';
import 'package:issues_app/presentation/screens/issues/widgets/count_card.dart';
import 'package:issues_app/presentation/screens/issues/widgets/progress_bar.dart';
import 'package:issues_app/theme/app_theme.dart';

class SummaryHeader extends StatelessWidget {
  final String title;
  final String subtitleDate;
  final int openCount;
  final int closedCount;
  final int totalCount;

  const SummaryHeader({
    super.key,
    required this.title,
    required this.subtitleDate,
    required this.openCount,
    required this.closedCount,
  }) : totalCount = openCount + closedCount;

  @override
  Widget build(BuildContext context) {
    final totalLabel = totalCount == 0 ? 'N/A' : totalCount;
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
            '$totalLabel',
            style: context.customStyles.display1,
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 16),
          ProgresslBar(closedCount: closedCount, openCount: openCount),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: CountCard(count: openCount, status: IssueStatus.open),
              ),
              Expanded(
                child: CountCard(
                  count: closedCount,
                  status: IssueStatus.closed,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
