import 'package:flutter/material.dart';
import 'package:yingxin/core/constants/app_colors.dart';

abstract final class AppTextTheme {
  static const TextTheme lightTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.bold,
      letterSpacing: -0.5,
      color: AppColors.primaryTextLight,
    ),
    displayMedium: TextStyle(
      fontSize: 34,
      fontWeight: FontWeight.bold,
      letterSpacing: -0.25,
      color: AppColors.primaryTextLight,
    ),
    displaySmall: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: AppColors.primaryTextLight,
    ),

    headlineLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.secondaryTextLight,
    ),
    headlineMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.secondaryTextLight,
    ),
    headlineSmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.secondaryTextLight,
    ),

    titleLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.secondaryTextLight,
    ),
    titleMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.secondaryTextLight,
    ),
    titleSmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.secondaryTextLight,
    ),

    bodyLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      height: 1.5,
      color: AppColors.secondaryTextLight,
    ),
    bodyMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      height: 1.4,
      color: AppColors.secondaryTextLight,
    ),
    bodySmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.normal,
      height: 1.3,
      color: AppColors.secondaryTextLight,
    ),

    labelLarge: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      color: AppColors.secondaryTextLight,
    ),
    labelMedium: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      color: AppColors.secondaryTextLight,
    ),
    labelSmall: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      color: AppColors.secondaryTextLight,
    ),
  );

  static const TextTheme darkTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.bold,
      letterSpacing: -0.5,
      color: AppColors.primaryTextDark,
    ),
    displayMedium: TextStyle(
      fontSize: 34,
      fontWeight: FontWeight.bold,
      letterSpacing: -0.25,
      color: AppColors.primaryTextDark,
    ),
    displaySmall: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: AppColors.primaryTextDark,
    ),

    headlineLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.secondaryTextDark,
    ),
    headlineMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.secondaryTextDark,
    ),
    headlineSmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.secondaryTextDark,
    ),

    titleLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.secondaryTextDark,
    ),
    titleMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.secondaryTextDark,
    ),
    titleSmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.secondaryTextDark,
    ),

    bodyLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      height: 1.5,
      color: AppColors.secondaryTextDark,
    ),
    bodyMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      height: 1.4,
      color: AppColors.secondaryTextDark,
    ),
    bodySmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.normal,
      height: 1.3,
      color: AppColors.secondaryTextDark,
    ),

    labelLarge: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      color: AppColors.secondaryTextDark,
    ),
    labelMedium: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      color: AppColors.secondaryTextDark,
    ),
    labelSmall: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      color: AppColors.secondaryTextDark,
    ),
  );
}
