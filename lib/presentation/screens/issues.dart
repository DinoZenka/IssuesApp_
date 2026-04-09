import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:issues_app/domain/entities/issue.dart';
import 'package:issues_app/presentation/providers/issues_provider.dart';
import 'package:issues_app/presentation/widgets/faded_scroll.dart';
import 'package:issues_app/presentation/widgets/issues_list_item.dart';
import 'package:issues_app/presentation/widgets/issues_search_field.dart';
import 'package:issues_app/presentation/widgets/issues_status_control.dart';
import 'package:issues_app/presentation/widgets/issues_summary_header.dart';
import 'package:issues_app/theme/app_theme.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Issues extends ConsumerStatefulWidget {
  const Issues({super.key});

  @override
  ConsumerState<Issues> createState() => _IssuesState();
}

class _IssuesState extends ConsumerState<Issues> {
  final List<IssueFilter> _filterOptions = [
    const AllIssuesFilter(),
    ...IssueStatus.values.map((s) => StatusFilter(s)),
  ];
  IssueFilter _selectedFilter = const AllIssuesFilter();

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yMMMMd').format(now);

    final theme = Theme.of(context);
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final issues = ref.watch(filteredIssuesProvider);
    final counts = ref.watch(issuesCountsProvider);

    final showSkeleton = issues.any((i) => i.isMock);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Skeletonizer(
        enabled: showSkeleton,
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              IssuesSummaryHeader(
                title: 'Issues',
                subtitleDate: formattedDate,
                openCount: counts.open,
                closedCount: counts.closed,
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
                            values: _filterOptions,
                            selected: _selectedFilter,
                            onSelect: (value) {
                              setState(() => _selectedFilter = value);
                              _updateIssuesFilter(value);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      IssuesSearchField(
                        onChanged: (value) {
                          ref
                              .read(issuesSearchQueryProvider.notifier)
                              .update(value);
                        },
                      ),
                      Expanded(
                        child: FadedScroll(
                          child: RefreshIndicator.adaptive(
                            onRefresh: () =>
                                ref.read(issuesProvider.notifier).refresh(),
                            child: ListView.separated(
                              itemCount: issues.length,
                              padding: EdgeInsets.only(
                                top: 16,
                                bottom: bottomInset,
                              ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 12),
                              itemBuilder: (BuildContext context, int index) {
                                final issueId = issues[index].id;
                                return IssuesListItem(
                                  key: ValueKey(issueId),
                                  onTap: () {
                                    if (!issues[index].isMock) {
                                      context.go('/details/$issueId');
                                    }
                                  },
                                  item: issues[index],
                                );
                              },
                            ),
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
      ),
    );
  }

  void _updateIssuesFilter(IssueFilter filter) {
    final IssueStatus? status = switch (filter) {
      AllIssuesFilter() => null,
      StatusFilter(status: var s) => s,
    };

    ref.read(issuesStatusFilterProvider.notifier).update(status);
  }
}
