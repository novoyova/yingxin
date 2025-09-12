import 'package:flutter/material.dart';
import 'package:yingxin/core/constants/app_colors.dart';

abstract final class AppSnackbar {
  static void success(
    BuildContext context, {
    required String message,
    Duration? duration,
  }) {
    _show(
      context,
      message: message,
      icon: Icons.check_circle_rounded,
      backgroundColor: AppColors.success,
      duration: duration,
    );
  }

  static void error(
    BuildContext context, {
    required String message,
    Duration? duration,
  }) {
    _show(
      context,
      message: message,
      icon: Icons.error_rounded,
      backgroundColor: AppColors.error,
      duration: duration,
    );
  }

  static void warning(
    BuildContext context, {
    required String message,
    Duration? duration,
  }) {
    _show(
      context,
      message: message,
      icon: Icons.warning_rounded,
      backgroundColor: AppColors.warning,
      duration: duration,
    );
  }

  static void info(
    BuildContext context, {
    required String message,
    Duration? duration,
  }) {
    _show(
      context,
      message: message,
      icon: Icons.info_rounded,
      backgroundColor: AppColors.info,
      duration: duration,
    );
  }

  static void _show(
    BuildContext context, {
    required String message,
    required IconData icon,
    required Color backgroundColor,
    Duration? duration,
  }) {
    final textStyle = Theme.of(context).textTheme;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
        elevation: 0,
        backgroundColor: backgroundColor,
        duration: duration ?? const Duration(seconds: 4),
        showCloseIcon: true,
        closeIconColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [
            Icon(icon, color: AppColors.white),
            Expanded(
              child: Text(
                message,
                style: textStyle.bodyLarge?.copyWith(color: AppColors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
