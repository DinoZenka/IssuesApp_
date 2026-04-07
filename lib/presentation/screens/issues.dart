import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:issues_app/presentation/widgets/faded_scroll.dart';
import 'package:issues_app/presentation/widgets/issues_list_item.dart';
import 'package:issues_app/presentation/widgets/issues_search_field.dart';
import 'package:issues_app/presentation/widgets/issues_status_control.dart';
import 'package:issues_app/presentation/widgets/issues_summary_header.dart';
import 'package:issues_app/theme/app_theme.dart';

class Issues extends StatefulWidget {
  const Issues({super.key});

  @override
  State<Issues> createState() => _IssuesState();
}

class _IssuesState extends State<Issues> {
  final List<String> _options = ['All', 'Closed', 'Open'];
  String _currentTab = 'All';

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yMMMMd').format(now);

    final theme = Theme.of(context);
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            IssuesSummaryHeader(
              title: 'Issues',
              subtitleDate: formattedDate,
              openCount: 35,
              closedCount: 60,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 22, left: 16, right: 16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Issue", style: context.customStyles.h2),
                        IssuesStatusControl(
                          values: _options,
                          selected: _currentTab,
                          onSelect: (value) {
                            setState(() => _currentTab = value);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    IssuesSearchField(),
                    Expanded(
                      child: FadedScroll(
                        child: ListView.separated(
                          itemCount: 20,
                          padding: EdgeInsets.only(
                            top: 16,
                            bottom: bottomInset,
                          ),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12),
                          itemBuilder: (BuildContext context, int index) {
                            return IssuesListItem(
                              key: ValueKey(index),
                              item: IssueModel(
                                id: '123',
                                title: 'Enhance Search Functionality',
                                description:
                                    'This task focuses on developing comprehensive API documentation. It should clearly outline the endpoints, request parameters, and response formats to assist developers in integrating with our services.',
                                priority: IssuePriority.high,
                                status: IssueStatus.closed,
                                updatedAt: DateTime.now().toIso8601String(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
