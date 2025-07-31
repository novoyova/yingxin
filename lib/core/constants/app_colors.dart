import 'package:flutter/material.dart';

abstract final class AppColors {
  // Main Colors
  // 0xFF008EDB
  // 0xFF8BC21E
  // 0xFF0A913F
  // 0xFF1C4279
  static const Color primary = Color(0xFF0A913F);
  static const Color accent = Color(0xFF8BC21E);
  static const Color success = Color(0xFF388E3C);
  static const Color error = Color(0xFFD32F2F);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);

  // Neutral Shades
  static const Color black = Color(0xFF000000);
  static const Color darkGray = Color(0xFF424242);
  static const Color gray = Color(0xFF757575);
  static const Color lightGray = Color(0xFFBDBDBD);
  static const Color brightGray = Color(0xFFEEEEEE);
  static const Color white = Color(0xFFFFFFFF);

  // Light Theme Colors
  static const Color backgroundLight = Color(0xFFF5F5F5);
  static const Color primaryTextLight = Color(0xFF212121);
  static const Color secondaryTextLight = Color(0xFF424242);
  static const Color primaryButtonLight = Color(0xFFF5AB1A);
  static const Color secondaryButtonLight = Color(0xFFBDBDBD);
  static const Color borderLight = Color(0xFFDDDDDD);

  // Dark Theme Colors
  static const Color backgroundDark = Color(0xFF121212);
  static const Color primaryTextDark = Color(0xFFE0E0E0);
  static const Color secondaryTextDark = Color(0xFFBDBDBD);
  static const Color primaryButtonDark = Color(0xFFF5AB1A);
  static const Color secondaryButtonDark = Color(0xFF616161);
  static const Color borderDark = Color(0xFF333333);
}
