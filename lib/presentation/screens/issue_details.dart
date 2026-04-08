import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:issues_app/assets/app_icons.dart';
import 'package:issues_app/domain/entities/issue.dart';
import 'package:issues_app/presentation/widgets/details_segmented_control.dart';
import 'package:issues_app/presentation/widgets/details_status_badge.dart';
import 'package:issues_app/presentation/widgets/faded_scroll.dart';
import 'package:issues_app/presentation/widgets/issue_priority_badge.dart';
import 'package:issues_app/presentation/widgets/issue_status_badge.dart';
import 'package:issues_app/theme/app_theme.dart';

class IssueDetails extends StatefulWidget {
  final String id;
  const IssueDetails({super.key, required this.id});

  @override
  State<IssueDetails> createState() => _IssueDetailsState();
}

class _IssueDetailsState extends State<IssueDetails> {
  final prioritiesOptions = <IssuePriority>[
    IssuePriority.low,
    IssuePriority.medium,
    IssuePriority.high,
  ];
  IssuePriority activePriority = IssuePriority.low;

  final statusOptions = <IssueStatus>[IssueStatus.open, IssueStatus.closed];
  IssueStatus activeStatus = IssueStatus.open;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final insets = MediaQuery.paddingOf(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      bottomNavigationBar: _SaveBar(onPressed: () {}),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DetailsHeader(topInset: insets.top),
          Expanded(
            child: FadedScroll(
              stops: [0, 0, 0.95, 1],
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _DetailsTopCard(
                      title: 'Title',
                      lastUpdatedLabel: '11:45 AM, 22 Jan 2026',
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
                      description: 'Desctiption body',
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
}

class _SaveBar extends StatelessWidget {
  final VoidCallback? onPressed;
  const _SaveBar({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 48),
            backgroundColor: theme.colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Save',
            style: context.customStyles.subtitle2!.copyWith(
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

class _DetailsHeader extends StatelessWidget {
  final double topInset;
  const _DetailsHeader({required this.topInset});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.only(
        top: topInset + 24,
        left: 16,
        right: 16,
        bottom: 12,
      ),
      color: theme.colorScheme.surfaceContainer,
      child: Row(
        spacing: 8,
        children: [
          SvgPicture.asset(AppIcons.arrowLeft, width: 20, height: 20),
          Text(
            'Go Back',
            style: context.customStyles.bodyRegular!.copyWith(
              color: context.customColors.purple60,
            ),
          ),
          const Spacer(),
          const DetailsStatusBadge(),
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
