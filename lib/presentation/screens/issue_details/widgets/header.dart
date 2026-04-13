import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:issues_app/assets/app_icons.dart';
import 'package:issues_app/presentation/widgets/details_status_badge.dart';
import 'package:issues_app/theme/app_theme.dart';

class Header extends StatelessWidget {
  final double topInset;
  final bool isUpdating;
  const Header({super.key, required this.topInset, this.isUpdating = false});

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
