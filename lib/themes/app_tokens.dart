import 'package:flutter/material.dart';

// COLORS
class AppColors {
  static const acidGreen = Color(0xFF39D02F);
  static const black = Color(0xFF000000);
  static const white = Color(0xFFFFFFFF);
  static const error = Color(0xFFFF0000);
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
  static final hard = BorderRadius.circular(6.0);
  static final soft = BorderRadius.circular(18.0);
  static const thick = BorderSide(width: 2, color: AppColors.black);
}

// FONT CONFIG
class AppFont {
  static const double display = 64;
  static const double displaySmall = 32;
  static const double h1 = 32;
  static const double body = 14;
  static const double label = 12;
}
