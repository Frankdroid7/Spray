import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.surfaceBackground,
    appBarTheme: AppBarTheme(
      surfaceTintColor: AppColors.surfaceBackground,
    ),
    textTheme:  TextTheme(
      displayLarge: AppTextStyles.brandDisplay,
      displayMedium: AppTextStyles.brandDisplayDark,
      displaySmall: AppTextStyles.primaryDisplay,
      titleLarge: AppTextStyles.primaryHeading,
      titleMedium: AppTextStyles.primaryTitle,
      bodyMedium: AppTextStyles.primaryBody,
      labelMedium: AppTextStyles.primaryLabel,
      labelSmall: AppTextStyles.primaryAction,
    ),
    colorScheme: ColorScheme.light(
      primary: AppColors.brandPrimary,
      onPrimary: AppColors.textOnPrimary,
      surface: AppColors.surfaceBackground,
    ),
  );
}
