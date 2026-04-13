import 'package:flutter/material.dart';
import 'package:issues_app/theme/app_theme.dart';

class DescriptionSection extends StatelessWidget {
  final double bottomInset;
  final String title;
  final String description;

  const DescriptionSection({
    super.key,
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
