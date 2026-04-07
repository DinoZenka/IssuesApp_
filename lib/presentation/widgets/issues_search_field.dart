import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:issues_app/theme/app_theme.dart';

class IssuesSearchField extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  const IssuesSearchField({super.key, this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Search for',
        hintStyle: context.customStyles.bodyLight,
        contentPadding: EdgeInsets.only(left: 16, right: 16),
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
          child: SvgPicture.asset(
            'lib/assets/icons/search_icon.svg',
            width: 20,
            height: 20,
          ),
        ),
      ),
    );
  }
}
