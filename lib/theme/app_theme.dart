import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF4841D2);
  static const Color primary80 = Color(0xFF5850EC);
  static const Color primary60 = Color(0xFF5850EC);
  static const Color primaryVariant = Color(0xFF3700B3);
  static const Color secondary = Color(0xFF03DAC6);
  static const Color black = Color(0xFF313131);
  static const Color gray80 = Color(0xFF6F6F6F);
  static const Color gray60 = Color(0xFFF6F6F6);
  static const Color gray40 = Color(0xFFEAEAEA);
  static const Color orange = Color(0xFFB84100);

  static const Color surface = Color(0xFFF6F6F6);
  static const Color card = Colors.white;
  static const Color error = Color(0xFFFF2929);
  static const Color success = Color(0xFF267B37);
  static const Color success80 = Color(0xFF29AD2C);
  static const Color border = Color(0xFFD1D5DB);

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
        surfaceContainer: AppColors.card,
        error: AppColors.error,
        onPrimary: AppColors.onPrimary,
        onSecondary: AppColors.onSecondary,
        onSurface: AppColors.onSurface,
        onError: AppColors.onError,
      ),
      fontFamily: 'Outfit',
      textTheme: textTheme,
      dividerTheme: DividerThemeData(color: AppColors.gray40),
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
        MyColors(
          green: AppColors.success,
          green80: AppColors.success80,
          purple80: AppColors.primary80,
          purple60: AppColors.primary60,
          gray: AppColors.black,
          gray80: AppColors.gray80,
          gray60: AppColors.gray60,
          gray40: AppColors.gray40,
          orange: AppColors.orange,
          border: AppColors.border,
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

class MyColors extends ThemeExtension<MyColors> {
  final Color? green;
  final Color? green80;
  final Color? purple80;
  final Color? purple60;
  final Color? gray;
  final Color? gray80;
  final Color? gray60;
  final Color? gray40;
  final Color? orange;
  final Color? border;

  MyColors({
    this.green,
    this.green80,
    this.purple80,
    this.purple60,
    this.gray,
    this.gray80,
    this.gray60,
    this.gray40,
    this.orange,
    this.border,
  });

  @override
  MyColors copyWith({
    Color? green,
    Color? green80,
    Color? purple80,
    Color? purple60,
    Color? gray,
    Color? gray80,
    Color? gray60,
    Color? gray40,
    Color? orange,
    Color? border,
  }) {
    return MyColors(
      green: green ?? this.green,
      green80: green80 ?? this.green80,
      purple80: purple80 ?? this.purple80,
      purple60: purple60 ?? this.purple60,
      gray: gray ?? this.gray,
      gray80: gray80 ?? this.gray80,
      gray60: gray60 ?? this.gray60,
      gray40: gray40 ?? this.gray40,
      orange: orange ?? this.orange,
      border: border ?? this.border,
    );
  }

  @override
  MyColors lerp(ThemeExtension<MyColors>? other, double t) {
    if (other is! MyColors) return this;
    return MyColors(
      green: Color.lerp(green, other.green, t),
      green80: Color.lerp(green80, other.green80, t),
      purple80: Color.lerp(purple80, other.purple80, t),
      purple60: Color.lerp(purple60, other.purple60, t),
      gray: Color.lerp(gray, other.gray, t),
      gray80: Color.lerp(gray80, other.gray80, t),
      gray60: Color.lerp(gray60, other.gray60, t),
      gray40: Color.lerp(gray40, other.gray40, t),
      orange: Color.lerp(orange, other.orange, t),
      border: Color.lerp(border, other.border, t),
    );
  }
}

extension AppThemeExtension on BuildContext {
  MyTextStyles get customStyles => Theme.of(this).extension<MyTextStyles>()!;
  MyColors get customColors => Theme.of(this).extension<MyColors>()!;
}
