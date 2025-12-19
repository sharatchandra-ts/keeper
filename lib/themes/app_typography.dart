import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keeper/themes/app_tokens.dart';

class AppTextStyles {
  /* ---------------- DISPLAY ---------------- */

  static final displayLarge = GoogleFonts.anton(
    fontSize: AppFont.displayLarge,
    fontWeight: FontWeight.w900,
    letterSpacing: -2,
    color: AppColors.textPrimary,
  );

  static final displayMedium = GoogleFonts.anton(
    fontSize: AppFont.displayMedium,
    fontWeight: FontWeight.w900,
    letterSpacing: -1.5,
    color: AppColors.textPrimary,
  );

  static final displaySmall = GoogleFonts.anton(
    fontSize: AppFont.displaySmall,
    fontWeight: FontWeight.bold,
    letterSpacing: -1,
    color: AppColors.textPrimary,
  );

  /* ---------------- HEADINGS ---------------- */

  static final h1 = GoogleFonts.anton(
    fontSize: AppFont.h1,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static final h2 = GoogleFonts.anton(
    fontSize: AppFont.h2,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static final h3 = GoogleFonts.anton(
    fontSize: AppFont.h3,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  /* ---------------- BODY ---------------- */

  static final bodyLarge = GoogleFonts.robotoMono(
    fontSize: AppFont.bodyLarge,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  static final bodyMedium = GoogleFonts.robotoMono(
    fontSize: AppFont.bodyMedium,
    fontWeight: FontWeight.w400,
    height: 1.3,
    color: AppColors.textSecondary,
  );

  static final bodySmall = GoogleFonts.robotoMono(
    fontSize: AppFont.bodySmall,
    fontWeight: FontWeight.w400,
    height: 1.2,
    color: AppColors.textMuted,
  );

  /* ---------------- TITLES (ListTiles, Cards) ---------------- */

  static final titleLarge = GoogleFonts.robotoMono(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.5,
    color: AppColors.textPrimary,
  );

  static final titleMedium = GoogleFonts.robotoMono(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    color: AppColors.textPrimary,
  );

  static final titleSmall = GoogleFonts.robotoMono(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  /* ---------------- LABELS ---------------- */

  static final labelLarge = GoogleFonts.robotoMono(
    fontSize: AppFont.labelLarge,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
    color: AppColors.textSecondary,
  );

  static final labelMedium = GoogleFonts.robotoMono(
    fontSize: AppFont.labelMedium,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.8,
    color: AppColors.textMuted,
  );

  static final labelSmall = GoogleFonts.robotoMono(
    fontSize: AppFont.labelSmall,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.6,
    color: AppColors.textMuted,
  );
}
