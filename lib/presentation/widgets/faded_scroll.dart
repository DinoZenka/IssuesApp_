import 'package:flutter/material.dart';

const defaultStops = <double>[0, .08, .92, 1];

class FadedScroll extends StatelessWidget {
  final Widget child;
  final List<double>? stops;
  final List<Color>? colors;
  const FadedScroll({
    super.key,
    required this.child,
    this.colors,
    this.stops = defaultStops,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultColors = [
      theme.colorScheme.surfaceContainer.withValues(alpha: 0.0),
      theme.colorScheme.surfaceContainer,
      theme.colorScheme.surfaceContainer,
      theme.colorScheme.surfaceContainer.withValues(alpha: 0.0),
    ];

    return ShaderMask(
      shaderCallback: (Rect rect) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: colors ?? defaultColors,
          stops: [0.0, 0.08, 0.92, 1.0],
        ).createShader(rect);
      },
      blendMode: BlendMode.dstIn,
      child: child,
    );
  }
}
