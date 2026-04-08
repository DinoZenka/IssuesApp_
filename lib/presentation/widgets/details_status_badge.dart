import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:issues_app/presentation/providers/internet_reachability_provider.dart';
import 'package:issues_app/theme/app_theme.dart';

enum BadgeStatus { pedning, offline, synchronized }

class BadgeData {
  final String label;
  final Color bgColor;
  final Color textColor;

  const BadgeData({
    required this.label,
    required this.bgColor,
    required this.textColor,
  });
}

class BaseStatusBadge extends StatelessWidget {
  final BadgeData badgeData;
  const BaseStatusBadge({super.key, required this.badgeData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        color: badgeData.bgColor,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Text(
        badgeData.label,
        style: context.customStyles.bodyRegular!.copyWith(
          color: badgeData.textColor,
        ),
      ),
    );
  }
}

class SyncStatusBadge extends StatelessWidget {
  const SyncStatusBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final badgeData = BadgeData(
      label: 'Synchronized',
      bgColor: context.customColors.green80!.withValues(alpha: 0.12),
      textColor: context.customColors.green!,
    );
    return BaseStatusBadge(badgeData: badgeData);
  }
}

class PendingStatusBadge extends StatelessWidget {
  const PendingStatusBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final badgeData = BadgeData(
      label: 'Pending Sync',
      bgColor: context.customColors.orange!.withValues(alpha: 0.08),
      textColor: context.customColors.orange!,
    );
    return BaseStatusBadge(badgeData: badgeData);
  }
}

class OfflineStatusBadge extends StatelessWidget {
  const OfflineStatusBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final badgeData = BadgeData(
      label: 'Offline Mode',
      bgColor: context.customColors.gray60!,
      textColor: context.customColors.gray!,
    );
    return BaseStatusBadge(badgeData: badgeData);
  }
}

class DetailsStatusBadge extends StatelessWidget {
  const DetailsStatusBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ReachabilityDrivenStatusBadge();
  }
}

class _ReachabilityDrivenStatusBadge extends ConsumerWidget {
  const _ReachabilityDrivenStatusBadge();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasInternet = ref.watch(hasInternetProvider);

    return hasInternet.when(
      data: (ok) => ok ? const SyncStatusBadge() : const OfflineStatusBadge(),
      loading: () => const SyncStatusBadge(),
      error: (_, _) => const SyncStatusBadge(),
    );
  }
}
