import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  /* ---------------- Brand ---------------- */

  /// App wordmark / hero text (Splash, Branding)
  static TextStyle brandDisplay = GoogleFonts.spaceGrotesk(
    fontWeight: FontWeight.w500,
    fontSize: 57.01,
    height: 1.0,
    letterSpacing: -5.7,
    color: AppColors.textWhite,
  );

  /// Brand text on light background (Onboarding)
  static TextStyle brandDisplayDark = GoogleFonts.spaceGrotesk(
    fontWeight: FontWeight.w500,
    fontSize: 44,
    height: 1.0,
    letterSpacing: -4.4,
    color: AppColors.textDark,
  );

  /* ---------------- Primary (Inter Tight) ---------------- */

  /// Large numeric values, balances, emphasis numbers
  static final TextStyle primaryDisplay = GoogleFonts.interTight(
    fontWeight: FontWeight.w500,
    fontSize: 32,
    height: 1.0,
    letterSpacing: -0.64,
    color: AppColors.brandDark,
  );

  /// Section headers, card titles
  static final TextStyle primaryTitle = GoogleFonts.interTight(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 1.0,
    letterSpacing: -0.32,
    color: AppColors.brandDark,
  );

  /// Page titles, auth headers
  static final TextStyle primaryHeading = GoogleFonts.interTight(
    fontWeight: FontWeight.w700,
    fontSize: 18,
    height: 1.0,
    letterSpacing: -0.36,
    color: AppColors.brandDark,
  );

  /// Standard readable body text
  static final TextStyle primaryBody = GoogleFonts.interTight(
    fontWeight: FontWeight.w400,
    fontSize: 18,
    height: 1.0,
    color: AppColors.textSecondary,
  );

  /// Interactive text (links, inline actions)
  static final TextStyle primaryAction = GoogleFonts.interTight(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1.0,
    color: AppColors.brandDark,
    letterSpacing: -0.3,
  );

  /// Muted labels / helper text
  static final TextStyle primaryLabel = GoogleFonts.interTight(
    fontWeight: FontWeight.w500,
    fontSize: 12,
    height: 1.0,
    color: AppColors.textSecondary,
  );

  /* ---------------- System (SF Pro Display) ---------------- */

  /// Form field labels
  static final TextStyle systemLabel = GoogleFonts.outfit(
    // fontFamily: 'SFProDisplay',
    fontWeight: FontWeight.w500,
    fontSize: 12,
    height: 1.0,
    color: AppColors.textSecondary,
  );

  /// Input placeholders
  static final TextStyle systemPlaceholder = GoogleFonts.outfit(
    // fontFamily: 'SFProDisplay',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 1.0,
    color: AppColors.textSecondary,
  );

  /// Secondary actions (forgot password, subtle CTAs)
  static final TextStyle systemBody = GoogleFonts.outfit(
    // fontFamily: 'SFProDisplay',
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1.0,
    color: AppColors.textPrimary,
  );

  /* ---------------- Micro ---------------- */

  /// Very small supporting text (action card subtitles)
  static final TextStyle micro = GoogleFonts.inter(
    fontWeight: FontWeight.w500,
    fontSize: 10,
    height: 1.0,
    letterSpacing: -0.2,
    color: AppColors.textSecondary,
  );

  /* ---------------- Inverted ---------------- */

  /// Text on dark / primary backgrounds (buttons)
  static final TextStyle onPrimary = GoogleFonts.interTight(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1.0,
    color: AppColors.textOnPrimary,
  );


  static final TextStyle naira = GoogleFonts.libreFranklin(
    fontWeight: FontWeight.w600,
    fontSize: 32,
    height: 1.0,
    letterSpacing: -0.03,
    color: const Color(0xFF020202),
  );
}
