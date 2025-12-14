import 'package:flutter/material.dart';

// COLORS
class AppColors {
  static const primary = Color(0xFF39D02F); // acid green
  static const secondary = Color(0xFFFFFF00); // neon yellow
  static const dark = Color(0xFF000000);
  static const light = Color(0xFFFFFFFF);
  static const onDark = light;
  static const onLight = dark;
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
  static final hardR = 10.0;
  static final softR = 18.0;
  static final hard = BorderRadius.circular(hardR);
  static final soft = BorderRadius.circular(softR);
  static const thick = BorderSide(width: 2, color: AppColors.dark);
}

// FONT CONFIG
class AppFont {
  static const double display = 64;
  static const double displaySmall = 32;
  static const double h1 = 32;
  static const double body = 14;
  static const double label = 12;
}
