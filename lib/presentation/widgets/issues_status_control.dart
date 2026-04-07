import 'package:flutter/material.dart';
import 'package:issues_app/presentation/widgets/segmented_control.dart';
import 'package:issues_app/theme/app_theme.dart';

class IssuesStatusControl extends StatelessWidget {
  final List<String> values;
  final String selected;
  final ValueChanged<String> onSelect;
  final double height;

  const IssuesStatusControl({
    super.key,
    required this.values,
    required this.selected,
    required this.onSelect,
    this.height = 40,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: SegmentedControl<String>(
        items: values,
        selectedValue: selected,
        onChange: onSelect,
        itemBuilder: (item, isSelected) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Center(
              child: Text(
                item,
                style: isSelected
                    ? context.customStyles.body2
                    : context.customStyles.bodyTab,
              ),
            ),
          );
        },
      ),
    );
  }
}
