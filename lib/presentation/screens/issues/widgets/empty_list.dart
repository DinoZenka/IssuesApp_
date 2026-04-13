import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:issues_app/assets/app_icons.dart';
import 'package:issues_app/presentation/providers/issues_provider.dart';
import 'package:issues_app/presentation/screens/issues/issues_screen.dart';
import 'package:issues_app/theme/app_theme.dart';

class EmptyList extends ConsumerWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(issuesSearchQueryProvider);
    final title = searchQuery.isEmpty ? emptyListTitle : errorListTitle;

    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppIcons.pageSearch, width: 48, height: 48),
                const SizedBox(height: 12),
                Text(title, style: context.customStyles.subtitle1),
                const SizedBox(height: 4),
                Text(
                  emptyListDescription,
                  textAlign: .center,
                  style: context.customStyles.body2!.copyWith(
                    color: context.customColors.gray80,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
