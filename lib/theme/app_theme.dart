import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF4841D2);
  static const Color primary80 = Color(0xFF5850EC);
  static const Color primary60 = Color(0xFF5850EC);
  static const Color primaryVariant = Color(0xFF3700B3);
  static const Color secondary = Color(0xFF03DAC6);
  static const Color black = Color(0xFF313131);

  static const Color background = Color(0xFF6F6F6F);
  static const Color surface = Colors.white;
  static const Color error = Color(0xFFFF2929);
  static const Color success = Color(0xFF267B37);
  static const Color success80 = Color(0xFF29AD2C);

  static const Color onPrimary = Colors.white;
  static const Color onSecondary = black;
  static const Color onBackground = black;
  static const Color onSurface = black;
  static const Color onError = Colors.white;
  static const Color onSuccess = Colors.white;
}

class AppSpacing {
  static const double xs = 4.0;
  static const double s = 8.0;
  static const double m = 16.0;
  static const double l = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
}

const TextTheme textTheme = TextTheme(
  displayLarge: TextStyle(
    fontSize: 48,
    color: AppColors.onSurface,
    fontWeight: FontWeight.w400,
  ),
  displayMedium: TextStyle(
    fontSize: 32,
    color: AppColors.onSurface,
    fontWeight: FontWeight.w400,
  ),
  displaySmall: TextStyle(
    fontSize: 24,
    color: AppColors.onSurface,
    fontWeight: FontWeight.w400,
  ),
  titleMedium: TextStyle(
    fontSize: 20,
    color: AppColors.onSurface,
    fontWeight: FontWeight.w400,
  ),
  titleSmall: TextStyle(
    fontSize: 16,
    color: AppColors.onSurface,
    fontWeight: FontWeight.w400,
  ),
  bodyLarge: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurface,
    height: 1.4,
  ),
  bodyMedium: TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurface,
    height: 1.4,
  ),
  bodySmall: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: AppColors.onSurface,
    height: 1.4,
  ),
);

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        error: AppColors.error,
        onPrimary: AppColors.onPrimary,
        onSecondary: AppColors.onSecondary,
        onSurface: AppColors.onSurface,
        onError: AppColors.onError,
      ),
      fontFamily: 'Outfit',
      textTheme: textTheme,
      extensions: [
        MyTextStyles(
          display1: textTheme.displayLarge,
          h1: textTheme.displayMedium,
          h2: textTheme.displaySmall,
          subtitle1: textTheme.titleMedium,
          subtitle2: textTheme.titleSmall,
          bodyRegular: textTheme.bodyLarge,
          body2: textTheme.bodyMedium,
          bodyLight: textTheme.bodySmall,
          bodyTab: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w300,
            color: AppColors.onSurface,
          ),
        ),
      ],
    );
  }
}

class MyTextStyles extends ThemeExtension<MyTextStyles> {
  final TextStyle? display1;
  final TextStyle? h1;
  final TextStyle? h2;
  final TextStyle? subtitle1;
  final TextStyle? subtitle2;
  final TextStyle? bodyRegular;
  final TextStyle? body2;
  final TextStyle? bodyLight;
  final TextStyle? bodyTab;

  MyTextStyles({
    this.display1,
    this.h1,
    this.h2,
    this.subtitle1,
    this.subtitle2,
    this.bodyRegular,
    this.body2,
    this.bodyLight,
    this.bodyTab,
  });

  @override
  MyTextStyles copyWith({
    TextStyle? display1,
    TextStyle? h1,
    TextStyle? h2,
    TextStyle? subtitle1,
    TextStyle? subtitle2,
    TextStyle? bodyRegular,
    TextStyle? body2,
    TextStyle? bodyLight,
    TextStyle? bodyTab,
  }) {
    return MyTextStyles(
      display1: display1 ?? this.display1,
      h1: h1 ?? this.h1,
      h2: h2 ?? this.h2,
      subtitle1: subtitle1 ?? this.subtitle1,
      subtitle2: subtitle2 ?? this.subtitle2,
      bodyRegular: bodyRegular ?? this.bodyRegular,
      body2: body2 ?? this.body2,
      bodyLight: bodyLight ?? this.bodyLight,
      bodyTab: bodyTab ?? this.bodyTab,
    );
  }

  @override
  MyTextStyles lerp(ThemeExtension<MyTextStyles>? other, double t) {
    if (other is! MyTextStyles) return this;
    return MyTextStyles(
      display1: TextStyle.lerp(display1, other.display1, t),
      h1: TextStyle.lerp(h1, other.h1, t),
      h2: TextStyle.lerp(h2, other.h2, t),
      subtitle1: TextStyle.lerp(subtitle1, other.subtitle1, t),
      subtitle2: TextStyle.lerp(subtitle2, other.subtitle2, t),
      bodyRegular: TextStyle.lerp(bodyRegular, other.bodyRegular, t),
      body2: TextStyle.lerp(body2, other.body2, t),
      bodyLight: TextStyle.lerp(bodyLight, other.bodyLight, t),
      bodyTab: TextStyle.lerp(bodyTab, other.bodyTab, t),
    );
  }
}

extension AppThemeExtension on BuildContext {
  MyTextStyles get customStyles => Theme.of(this).extension<MyTextStyles>()!;
}
