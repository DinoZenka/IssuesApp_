import 'package:flutter/material.dart';
import 'package:issues_app/theme/app_theme.dart';

class ProgresslBar extends StatelessWidget {
  final int closedCount;
  final int openCount;

  const ProgresslBar({
    super.key,
    required this.closedCount,
    required this.openCount,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasData = (closedCount + openCount) > 0;

    return SizedBox(
      height: 8,
      child: Row(
        children: [
          if (hasData) ...[
            Expanded(
              flex: openCount,
              child: Container(
                decoration: BoxDecoration(
                  color: context.customColors.green80,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),

            const SizedBox(width: 2),
            Expanded(
              flex: closedCount,
              child: Container(
                decoration: BoxDecoration(
                  color: context.customColors.purple80,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ] else
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
