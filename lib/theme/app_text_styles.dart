import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  /* ---------------- Brand ---------------- */

  /// App wordmark / hero text (Splash, Branding)
  static const brandDisplay = TextStyle(
    fontFamily: 'SpaceGrotesk',
    fontWeight: FontWeight.w500,
    fontSize: 57.01,
    height: 1.0,
    letterSpacing: -5.7,
    color: AppColors.textWhite,
  );

  /// Brand text on light background (Onboarding)
  static const brandDisplayDark = TextStyle(
    fontFamily: 'SpaceGrotesk',
    fontWeight: FontWeight.w500,
    fontSize: 57.01,
    height: 1.0,
    letterSpacing: -5.7,
    color: AppColors.textDark,
  );

  /* ---------------- Primary (Inter Tight) ---------------- */

  /// Large numeric values, balances, emphasis numbers
  static const primaryDisplay = TextStyle(
    fontFamily: 'InterTight',
    fontWeight: FontWeight.w500,
    fontSize: 32,
    height: 1.0,
    letterSpacing: -0.64,
    color: AppColors.brandDark,
  );

  /// Section headers, card titles
  static const primaryTitle = TextStyle(
    fontFamily: 'InterTight',
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 1.0,
    letterSpacing: -0.32,
    color: AppColors.brandDark,
  );

  /// Page titles, auth headers
  static const primaryHeading = TextStyle(
    fontFamily: 'InterTight',
    fontWeight: FontWeight.w700,
    fontSize: 18,
    height: 1.0,
    letterSpacing: -0.36,
    color: AppColors.brandDark,
  );

  /// Standard readable body text
  static const primaryBody = TextStyle(
    fontFamily: 'InterTight',
    fontWeight: FontWeight.w400,
    fontSize: 18,
    height: 1.0,
    color: AppColors.textSecondary,
  );

  /// Interactive text (links, inline actions)
  static const primaryAction = TextStyle(
    fontFamily: 'InterTight',
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1.0,
    color: AppColors.brandDark,
  );

  /// Muted labels / helper text
  static const primaryLabel = TextStyle(
    fontFamily: 'InterTight',
    fontWeight: FontWeight.w500,
    fontSize: 12,
    height: 1.0,
    color: AppColors.textSecondary,
  );

  /* ---------------- System (SF Pro Display) ---------------- */

  /// Form field labels
  static const systemLabel = TextStyle(
    fontFamily: 'SFProDisplay',
    fontWeight: FontWeight.w500,
    fontSize: 12,
    height: 1.0,
    color: AppColors.textSecondary,
  );

  /// Input placeholders
  static const systemPlaceholder = TextStyle(
    fontFamily: 'SFProDisplay',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 1.0,
    color: AppColors.textSecondary,
  );

  /// Secondary actions (forgot password, subtle CTAs)
  static const systemBody = TextStyle(
    fontFamily: 'SFProDisplay',
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1.0,
    color: AppColors.textPrimary,
  );

  /* ---------------- Micro ---------------- */

  /// Very small supporting text (action card subtitles)
  static const micro = TextStyle(
    fontFamily: 'InterDisplay',
    fontWeight: FontWeight.w500,
    fontSize: 10,
    height: 1.0,
    letterSpacing: -0.2,
    color: AppColors.textSecondary,
  );

  /* ---------------- Inverted ---------------- */

  /// Text on dark / primary backgrounds (buttons)
  static const onPrimary = TextStyle(
    fontFamily: 'InterTight',
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1.0,
    color: AppColors.textOnPrimary,
  );
}
