import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:issues_app/presentation/providers/issues_provider.dart';
import 'package:issues_app/theme/app_theme.dart';

final errorText = 'An error occurred while searching';

class SearchField extends ConsumerWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final bool isListEmpty;
  const SearchField({
    super.key,
    this.controller,
    this.onChanged,
    this.isListEmpty = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final searchQuery = ref.watch(issuesSearchQueryProvider);
    final showError = searchQuery.isNotEmpty && isListEmpty;

    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Search for',
        errorText: showError ? errorText : null,
        hintStyle: context.customStyles.bodyLight,
        contentPadding: const EdgeInsets.only(right: 16),
        prefix: const SizedBox(width: 16),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.colorScheme.primary),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.customColors.border!),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.colorScheme.error),
        ),
        suffixIcon: UnconstrainedBox(
          child: searchQuery.isEmpty
              ? SvgPicture.asset(
                  'lib/assets/icons/search_icon.svg',
                  width: 20,
                  height: 20,
                )
              : IconButton(
                  icon: Icon(Icons.clear_sharp, size: 20),
                  onPressed: () {
                    onChanged?.call('');
                    controller?.clear();
                  },
                ),
        ),
      ),
    );
  }
}
