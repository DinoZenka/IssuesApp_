import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:issues_app/presentation/extensions/constants.dart';
import 'package:issues_app/presentation/providers/app_snackbar_provider.dart';

class AppSnackbar extends ConsumerStatefulWidget {
  final Widget child;
  const AppSnackbar({super.key, required this.child});

  @override
  ConsumerState<AppSnackbar> createState() => _AppSnackbarState();
}

class _AppSnackbarState extends ConsumerState<AppSnackbar> {
  bool _isShowing = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomMargin = MediaQuery.paddingOf(context).bottom + 16;

    ref.listen(appSnackbarProvider, (previous, next) {
      if (_isShowing || next.isEmpty) {
        return;
      }

      final event = next.first;
      final state = rootScaffoldMessengerKey.currentState;
      if (state == null) {
        return;
      }

      _isShowing = true;
      state.hideCurrentSnackBar();
      final controller = state.showSnackBar(
        SnackBar(
          content: Text(
            event.message,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: theme.colorScheme.error,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(bottom: bottomMargin, left: 16, right: 16),
          duration: const Duration(seconds: 4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );

      controller.closed.then((_) {
        if (!mounted) {
          return;
        }

        _isShowing = false;
        ref.read(appSnackbarProvider.notifier).remove(event.id);
      });
    });

    return widget.child;
  }
}
