import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.surfaceBackground,

    textTheme: const TextTheme(
      displayLarge: AppTextStyles.brandDisplay,
      titleLarge: AppTextStyles.primaryHeading,
      titleMedium: AppTextStyles.primaryTitle,
      bodyMedium: AppTextStyles.primaryBody,
      labelMedium: AppTextStyles.primaryLabel,
    ),

    colorScheme: ColorScheme.light(
      primary: AppColors.brandPrimary,
      onPrimary: AppColors.textOnPrimary,
      background: AppColors.surfaceBackground,
    ),
  );
}
