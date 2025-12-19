import 'package:flutter/material.dart';

// COLORS
class AppColors {
  /* ---------------- BRAND ---------------- */

  /// Neutral brand base
  static const primary = Color(0xFFD0D0D0);

  /// Neon yellow (attention / accent)
  static const secondary = Color(0xFFFFFF00);

  /// Neon green (search highlight / success accent)
  static const accent = Color(0xFF8CFF32);

  /* ---------------- NEUTRALS ---------------- */

  static const black = Color(0xFF000000);
  static const white = Color(0xFFFFFFFF);

  static const gray900 = Color(0xFF121212);
  static const gray700 = Color(0xFF3A3A3A);
  static const gray500 = Color(0xFF7A7A7A);
  static const gray300 = Color(0xFFBDBDBD);
  static const gray100 = Color(0xFFEDEDED);

  /* ---------------- SURFACES ---------------- */

  static const background = white;
  static const surface = Color(0xFFF7F7F7);
  static const surfaceVariant = Color(0xFFE0E0E0);

  /* ---------------- TEXT ---------------- */

  static const textPrimary = black;
  static const textSecondary = gray700;
  static const textMuted = gray500;
  static const textOnDark = white;

  /* ---------------- STATES ---------------- */

  static const success = accent;
  static const warning = Color(0xFFFFC107);
  static const error = Color(0xFFFF3B30);
  static const info = Color(0xFF2196F3);

  /* ---------------- BORDERS / DIVIDERS ---------------- */

  static const outline = gray300;
  static const divider = black;
}

// SPACING
class AppSpacing {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
}

// BORDERS
class AppBorders {
  static final hardR = 10.0;
  static final softR = 18.0;
  static final hard = BorderRadius.circular(hardR);
  static final soft = BorderRadius.circular(softR);
  static const thick = BorderSide(width: 2, color: AppColors.divider);
}

// FONT CONFIG
class AppFont {
  // Display
  static const double displayLarge = 64;
  static const double displayMedium = 48;
  static const double displaySmall = 32;

  // Headings
  static const double h1 = 32;
  static const double h2 = 24;
  static const double h3 = 20;

  // Body
  static const double bodyLarge = 16;
  static const double bodyMedium = 14;
  static const double bodySmall = 12;

  // Labels
  static const double labelLarge = 14;
  static const double labelMedium = 12;
  static const double labelSmall = 10;
}
