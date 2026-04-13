import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:issues_app/domain/entities/issue.dart';
import 'package:issues_app/presentation/providers/issues_provider.dart';
import 'package:issues_app/presentation/screens/issue_details/widgets/description_section.dart';
import 'package:issues_app/presentation/screens/issue_details/widgets/header.dart';
import 'package:issues_app/presentation/screens/issue_details/widgets/save_bar.dart';
import 'package:issues_app/presentation/screens/issue_details/widgets/top_card.dart';
import 'package:issues_app/presentation/widgets/faded_scroll.dart';
import 'package:issues_app/theme/app_theme.dart';
import 'package:skeletonizer/skeletonizer.dart';

class IssueDetailsScreen extends ConsumerStatefulWidget {
  final String id;
  const IssueDetailsScreen({super.key, required this.id});

  @override
  ConsumerState<IssueDetailsScreen> createState() => _IssueDetailsScreenState();
}

class _IssueDetailsScreenState extends ConsumerState<IssueDetailsScreen> {
  final prioritiesOptions = <IssuePriority>[
    IssuePriority.low,
    IssuePriority.medium,
    IssuePriority.high,
  ];
  IssuePriority activePriority = IssuePriority.low;

  final statusOptions = <IssueStatus>[IssueStatus.open, IssueStatus.closed];
  IssueStatus activeStatus = IssueStatus.open;

  String? _initializedFromIssueId;
  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final insets = MediaQuery.paddingOf(context);
    final issueAsync = ref.watch(issuesProvider);

    final Issue? issue = issueAsync.maybeWhen(
      data: (issues) => _firstWhereOrNull(issues, (i) => i.id == widget.id),
      orElse: () => null,
    );

    if (issue != null && _initializedFromIssueId != issue.id) {
      _initializedFromIssueId = issue.id;
      activePriority = issue.priority;
      activeStatus = issue.status;
    }

    final bool isDirty =
        issue != null &&
        (activePriority != issue.priority || activeStatus != issue.status);

    final showSkeleton = false;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      bottomNavigationBar: DetailsSaveBar(
        onPressed: () {
          _handleSaveChanges(issue);
        },
        isLoading: _isSaving,
        disabled: !isDirty,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(topInset: insets.top, isUpdating: _isSaving),
          Expanded(
            child: FadedScroll(
              stops: [0, 0, 0.95, 1],
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    issueAsync.when(
                      loading: () => const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      error: (err, _) => Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Failed to load issue: $err',
                          style: context.customStyles.bodyRegular,
                        ),
                      ),
                      data: (issues) {
                        if (issue == null) {
                          return Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              'Issue not found',
                              style: context.customStyles.bodyRegular,
                            ),
                          );
                        }

                        final lastUpdatedLabel = DateFormat(
                          'h:mm a, d MMM y',
                        ).format(issue.updatedAt);

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Skeletonizer(
                              enabled: showSkeleton,
                              child: TopCard(
                                title: issue.title,
                                lastUpdatedLabel: lastUpdatedLabel,
                                prioritiesOptions: prioritiesOptions,
                                activePriority: activePriority,
                                onPriorityChanged: (newPriority) {
                                  setState(() => activePriority = newPriority);
                                },
                                statusOptions: statusOptions,
                                activeStatus: activeStatus,
                                onStatusChanged: (newStatus) {
                                  setState(() => activeStatus = newStatus);
                                },
                              ),
                            ),
                            Skeletonizer(
                              enabled: showSkeleton,
                              child: DescriptionSection(
                                bottomInset: insets.bottom,
                                title: 'Description',
                                description: issue.description,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSaveChanges(Issue? issue) async {
    setState(() => _isSaving = true);
    try {
      await ref
          .read(issuesProvider.notifier)
          .updateIssue(
            id: widget.id,
            priority: activePriority,
            status: activeStatus,
          );
    } catch (e) {
      if (issue != null) {
        activePriority = issue.priority;
        activeStatus = issue.status;
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }
}

T? _firstWhereOrNull<T>(Iterable<T> items, bool Function(T) test) {
  for (final item in items) {
    if (test(item)) return item;
  }
  return null;
}
