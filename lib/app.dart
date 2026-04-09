import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:issues_app/navigation/navigation.dart';
import 'package:issues_app/theme/app_theme.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: SkeletonizerConfig(
        data: SkeletonizerConfigData(
          textBorderRadius: TextBoneBorderRadius(
            BorderRadiusGeometry.all(Radius.circular(4)),
          ),
        ),
        child: MaterialApp.router(
          routerConfig: router,
          title: 'Issues App',
          theme: AppTheme.lightTheme,
        ),
      ),
    );
  }
}
