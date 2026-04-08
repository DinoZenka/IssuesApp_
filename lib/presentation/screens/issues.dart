import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:issues_app/domain/entities/issue.dart';
import 'package:issues_app/presentation/providers/issues_provider.dart';
import 'package:issues_app/presentation/widgets/faded_scroll.dart';
import 'package:issues_app/presentation/widgets/issues_list_item.dart';
import 'package:issues_app/presentation/widgets/issues_search_field.dart';
import 'package:issues_app/presentation/widgets/issues_status_control.dart';
import 'package:issues_app/presentation/widgets/issues_summary_header.dart';
import 'package:issues_app/theme/app_theme.dart';

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
    final issuesAsync = ref.watch(filteredIssuesProvider);
    final countsAsync = ref.watch(issuesCountsProvider);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            countsAsync.when(
              data: (counts) => IssuesSummaryHeader(
                title: 'Issues',
                subtitleDate: formattedDate,
                openCount: counts.open,
                closedCount: counts.closed,
              ),
              loading: () => const SizedBox(
                height: 180,
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, s) => Text('Error loading counts: $e'),
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
                            _fetchIssuesByStatus(value);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    IssuesSearchField(
                      onChanged: (value) {
                        ref.read(searchQueryProvider.notifier).update(value);
                      },
                    ),
                    Expanded(
                      child: FadedScroll(
                        child: issuesAsync.when(
                          data: (issues) => RefreshIndicator.adaptive(
                            onRefresh: () async {
                              _fetchIssuesByStatus(_selectedFilter);
                            },
                            child: ListView.separated(
                              itemCount: issues.length,
                              padding: EdgeInsets.only(
                                top: 16,
                                bottom: bottomInset,
                              ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 12),
                              itemBuilder: (BuildContext context, int index) {
                                return IssuesListItem(
                                  key: ValueKey(issues[index].id),
                                  item: issues[index],
                                );
                              },
                            ),
                          ),
                          loading: () =>
                              const Center(child: CircularProgressIndicator()),
                          error: (error, stack) =>
                              Center(child: Text('Error: $error')),
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

  void _fetchIssuesByStatus(IssueFilter filter) {
    final IssueStatus? status = switch (filter) {
      AllIssuesFilter() => null,
      StatusFilter(status: var s) => s,
    };

    ref.read(issuesProvider.notifier).fetchByStatus(status);
  }
}
