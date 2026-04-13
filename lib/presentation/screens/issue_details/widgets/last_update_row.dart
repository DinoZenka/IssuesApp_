import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:issues_app/assets/app_icons.dart';
import 'package:issues_app/theme/app_theme.dart';

class DetailsLastUpdatedRow extends StatelessWidget {
  final String valueLabel;
  const DetailsLastUpdatedRow({super.key, required this.valueLabel});

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
