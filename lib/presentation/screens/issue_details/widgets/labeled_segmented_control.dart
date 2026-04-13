import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:issues_app/presentation/widgets/segmented_control.dart';
import 'package:issues_app/theme/app_theme.dart';

class LabeledSegmentedControl<T> extends StatelessWidget {
  final String iconPath;
  final String label;
  final List<T> values;
  final T activeValue;
  final Function(T) onChange;
  final Widget Function(T, bool isSelected, TextStyle textStyle) itemBuilder;

  const LabeledSegmentedControl({
    super.key,
    required this.iconPath,
    required this.label,
    required this.values,
    required this.activeValue,
    required this.onChange,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          spacing: 8,
          children: [
            SvgPicture.asset(iconPath, width: 20, height: 20),
            Text(
              label,
              style: context.customStyles.bodyRegular!.copyWith(
                color: context.customColors.gray80,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 40,
          child: SegmentedControl<T>(
            isFullWidth: true,
            items: values,
            selectedValue: activeValue,
            onChange: onChange,
            itemBuilder: (item, isSelected) {
              final textStyle = isSelected
                  ? context.customStyles.bodyRegular!
                  : context.customStyles.bodyTab!.copyWith(
                      color: context.customColors.gray80,
                    );
              return itemBuilder(item, isSelected, textStyle);
            },
          ),
        ),
      ],
    );
  }
}
