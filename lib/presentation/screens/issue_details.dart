import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:issues_app/assets/app_icons.dart';
import 'package:issues_app/domain/entities/issue.dart';
import 'package:issues_app/presentation/providers/issues_provider.dart';
import 'package:issues_app/presentation/widgets/details_segmented_control.dart';
import 'package:issues_app/presentation/widgets/details_status_badge.dart';
import 'package:issues_app/presentation/widgets/faded_scroll.dart';
import 'package:issues_app/presentation/widgets/issue_priority_badge.dart';
import 'package:issues_app/presentation/widgets/issue_status_badge.dart';
import 'package:issues_app/theme/app_theme.dart';

class IssueDetails extends ConsumerStatefulWidget {
  final String id;
  const IssueDetails({super.key, required this.id});

  @override
  ConsumerState<IssueDetails> createState() => _IssueDetailsState();
}

class _IssueDetailsState extends ConsumerState<IssueDetails> {
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

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      bottomNavigationBar: _SaveBar(
        onPressed: _handleSaveChanges,
        isLoading: _isSaving,
        disabled: !isDirty,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DetailsHeader(topInset: insets.top, isUpdating: _isSaving),
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
                            _DetailsTopCard(
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
                            _DescriptionSection(
                              bottomInset: insets.bottom,
                              title: 'Description',
                              description: issue.description,
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

  Future<void> _handleSaveChanges() async {
    setState(() => _isSaving = true);
    try {
      await ref
          .read(issuesProvider.notifier)
          .updateIssue(
            id: widget.id,
            priority: activePriority,
            status: activeStatus,
          );
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

class _SaveBar extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool disabled;

  const _SaveBar({
    required this.onPressed,
    this.isLoading = false,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isEnabled = !isLoading && !disabled;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
        child: ElevatedButton(
          onPressed: isEnabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 48),
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Text(
                  'Save',
                  style: context.customStyles.subtitle2?.copyWith(
                    color: theme.colorScheme.surfaceContainer,
                  ),
                ),
        ),
      ),
    );
  }
}

class _DetailsHeader extends StatelessWidget {
  final double topInset;
  final bool isUpdating;
  const _DetailsHeader({required this.topInset, this.isUpdating = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.only(top: topInset + 12, left: 16, right: 16),
      color: theme.colorScheme.surfaceContainer,
      child: Row(
        children: [
          TextButton.icon(
            icon: SvgPicture.asset(AppIcons.arrowLeft, width: 20, height: 20),
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              }
            },
            label: Text(
              'Go Back',
              style: context.customStyles.bodyRegular!.copyWith(
                color: context.customColors.purple60,
              ),
            ),
          ),
          const Spacer(),
          DetailsStatusBadge(isUpdating: isUpdating),
        ],
      ),
    );
  }
}

class _DetailsTopCard extends StatelessWidget {
  final String title;
  final String lastUpdatedLabel;

  final List<IssuePriority> prioritiesOptions;
  final IssuePriority activePriority;
  final ValueChanged<IssuePriority> onPriorityChanged;

  final List<IssueStatus> statusOptions;
  final IssueStatus activeStatus;
  final ValueChanged<IssueStatus> onStatusChanged;

  const _DetailsTopCard({
    required this.title,
    required this.lastUpdatedLabel,
    required this.prioritiesOptions,
    required this.activePriority,
    required this.onPriorityChanged,
    required this.statusOptions,
    required this.activeStatus,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainer,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: context.customStyles.h1),
          const SizedBox(height: 12),
          _LastUpdatedRow(valueLabel: lastUpdatedLabel),
          const SizedBox(height: 20),
          const Divider(height: 1),
          const SizedBox(height: 16),
          DetailsSegmentedControl<IssuePriority>(
            values: prioritiesOptions,
            activeValue: activePriority,
            onChange: onPriorityChanged,
            iconPath: AppIcons.sparks,
            label: 'Priority',
            itemBuilder: (item, _, textStyle) {
              return IssuePriorityBadge(priority: item, textStyle: textStyle);
            },
          ),
          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 16),
          DetailsSegmentedControl<IssueStatus>(
            values: statusOptions,
            activeValue: activeStatus,
            onChange: onStatusChanged,
            iconPath: AppIcons.taskList,
            label: 'Status',
            itemBuilder: (item, _, textStyle) {
              return IssueStatusBadge(status: item, textStyle: textStyle);
            },
          ),
        ],
      ),
    );
  }
}

class _LastUpdatedRow extends StatelessWidget {
  final String valueLabel;
  const _LastUpdatedRow({required this.valueLabel});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        SvgPicture.asset(AppIcons.clock, width: 20, height: 20),
        Text(
          'Last updated:',
          style: context.customStyles.bodyRegular!.copyWith(
            color: context.customColors.gray80,
          ),
        ),
        Text(valueLabel, style: context.customStyles.bodyRegular),
      ],
    );
  }
}

class _DescriptionSection extends StatelessWidget {
  final double bottomInset;
  final String title;
  final String description;

  const _DescriptionSection({
    required this.bottomInset,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 24,
        left: 16,
        right: 16,
        bottom: bottomInset + 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: context.customStyles.subtitle1),
          const SizedBox(height: 16),
          Text(
            description,
            style: context.customStyles.bodyLight!.copyWith(
              color: context.customColors.gray80,
            ),
          ),
        ],
      ),
    );
  }
}
