import 'package:flutter/material.dart';
import 'app_tokens.dart';
import 'app_typography.dart';

final ThemeData brutalistTheme = ThemeData(
  useMaterial3: true,

  scaffoldBackgroundColor: AppColors.acidGreen,

  colorScheme: const ColorScheme.light(
    primary: AppColors.black,
    onPrimary: AppColors.white,
    secondary: AppColors.black,
    onSecondary: AppColors.white,
    surface: AppColors.white,
    onSurface: AppColors.black,
    error: AppColors.error,
    onError: AppColors.white,
  ),

  textTheme: TextTheme(
    displayLarge: AppTextStyles.display,
    headlineLarge: AppTextStyles.heading,
    bodyLarge: AppTextStyles.body,
    labelLarge: AppTextStyles.label,
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.white,
    foregroundColor: AppColors.black,
    elevation: 0,
    centerTitle: false,
    titleTextStyle: AppTextStyles.display,
  ),

  cardTheme: .new(
    color: AppColors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: AppBorders.hard,
      side: AppBorders.thick,
    ),
  ),

  dividerTheme: const .new(color: AppColors.black, thickness: 1, space: 0),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.white,
    border: OutlineInputBorder(
      borderRadius: AppBorders.hard,
      borderSide: AppBorders.thick,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: AppBorders.hard,
      borderSide: .new(color: AppColors.black, width: 3),
    ),
  ),

  listTileTheme: .new(tileColor: AppColors.white),

  progressIndicatorTheme: const .new(
    color: AppColors.black,
    linearTrackColor: Colors.transparent,
    circularTrackColor: Colors.transparent,
  ),

  popupMenuTheme: .new(
    color: AppColors.white,
    shape: RoundedRectangleBorder(
      borderRadius: (AppBorders.hard),
      side: AppBorders.thick,
    ),
    elevation: 2.0,
    menuPadding: .all(0),
  ),

  elevatedButtonTheme: .new(
    style: .new(
      elevation: .all(0),
      backgroundColor: const WidgetStatePropertyAll(AppColors.black),
      foregroundColor: const WidgetStatePropertyAll(AppColors.white),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: AppBorders.hard),
      ),
      textStyle: WidgetStatePropertyAll(AppTextStyles.label),
    ),
  ),
  outlinedButtonTheme: .new(
    style: .new(
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: AppBorders.hard),
      ),
      textStyle: WidgetStatePropertyAll(AppTextStyles.label),
    ),
  ),
  textButtonTheme: .new(
    style: .new(
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: AppBorders.hard),
      ),
      textStyle: WidgetStatePropertyAll(AppTextStyles.label),
    ),
  ),

  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.black,
    foregroundColor: AppColors.white,
    elevation: 2.0,
  ),

  dialogTheme: .new(
    contentTextStyle: AppTextStyles.body,
    titleTextStyle: AppTextStyles.heading,
    backgroundColor: AppColors.white,
    shape: RoundedRectangleBorder(
      side: AppBorders.thick,
      borderRadius: AppBorders.soft,
    ),
    barrierColor: AppColors.acidGreen.withAlpha((255 * 0.8).round()),
  ),
);
