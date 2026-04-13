import 'package:flutter/material.dart';
import 'package:issues_app/theme/app_theme.dart';

class DetailsSaveBar extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool disabled;

  const DetailsSaveBar({
    super.key,
    required this.onPressed,
    this.isLoading = false,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isEnabled = !isLoading && !disabled;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
        child: ElevatedButton(
          onPressed: isEnabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 48),
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Text(
                  'Save',
                  style: context.customStyles.subtitle2?.copyWith(
                    color: theme.colorScheme.surfaceContainer,
                  ),
                ),
        ),
      ),
    );
  }
}
