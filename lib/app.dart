import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:yuanrung/core/constants/app_colors.dart';
import 'package:yuanrung/core/constants/app_strings.dart';
import 'package:yuanrung/core/router/app_router.dart';
import 'package:yuanrung/core/themes/app_text_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: AppColors.primary,
        dividerColor: AppColors.borderLight,
        scaffoldBackgroundColor: AppColors.backgroundLight,
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: AppColors.backgroundLight,
        ),
        textTheme: AppTextTheme.lightTextTheme,
        buttonTheme: ButtonThemeData(buttonColor: AppColors.primaryButtonLight),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColors.primary,
          selectionColor: AppColors.accent,
          selectionHandleColor: AppColors.primary,
        ),
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: AppColors.primary,
          centerTitle: true,
          titleTextStyle: AppTextTheme.lightTextTheme.headlineLarge?.copyWith(
            color: AppColors.primaryTextLight,
          ),
        ),
      ),
      onGenerateRoute: AppRouter.onGenerateRoute,
      navigatorObservers: [AppRouter.navigatorObserver],
      builder:
          kDebugMode
              ? DevicePreview.appBuilder
              : (context, child) => MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(textScaler: TextScaler.linear(1)),
                child: child!,
              ),
    );
  }
}
