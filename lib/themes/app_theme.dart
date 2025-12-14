import 'package:flutter/material.dart';
import 'app_tokens.dart';
import 'app_typography.dart';

final ThemeData brutalistTheme = ThemeData(
  useMaterial3: true,

  scaffoldBackgroundColor: AppColors.primary,

  colorScheme: const ColorScheme.light(
    primary: AppColors.dark,
    onPrimary: AppColors.light,
    secondary: AppColors.dark,
    onSecondary: AppColors.light,
    surface: AppColors.light,
    onSurface: AppColors.dark,
    error: AppColors.error,
    onError: AppColors.light,
  ),

  textTheme: TextTheme(
    displayLarge: AppTextStyles.display,
    headlineLarge: AppTextStyles.heading,
    bodyLarge: AppTextStyles.body,
    labelLarge: AppTextStyles.label,
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.light,
    foregroundColor: AppColors.dark,
    elevation: 0,
    centerTitle: false,
    titleTextStyle: AppTextStyles.display,
  ),

  cardTheme: .new(
    color: AppColors.light,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: AppBorders.hard,
      side: AppBorders.thick,
    ),
  ),

  dividerTheme: const .new(color: AppColors.dark, thickness: 1, space: 0),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.light,
    border: OutlineInputBorder(
      borderRadius: AppBorders.hard,
      borderSide: AppBorders.thick,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: AppBorders.hard,
      borderSide: .new(color: AppColors.dark, width: 3),
    ),
  ),

  listTileTheme: .new(tileColor: AppColors.light),

  progressIndicatorTheme: const .new(
    color: AppColors.dark,
    linearTrackColor: Colors.transparent,
    circularTrackColor: Colors.transparent,
  ),

  popupMenuTheme: .new(
    color: AppColors.light,
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
      backgroundColor: const WidgetStatePropertyAll(AppColors.dark),
      foregroundColor: const WidgetStatePropertyAll(AppColors.light),
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
    backgroundColor: AppColors.dark,
    foregroundColor: AppColors.light,
    elevation: 2.0,
  ),

  bottomSheetTheme: .new(
    backgroundColor: AppColors.light,
    shape: RoundedRectangleBorder(
      side: AppBorders.thick,
      borderRadius: AppBorders.soft,
    ),
    elevation: 0.0,
  ),

  dialogTheme: .new(
    contentTextStyle: AppTextStyles.body,
    titleTextStyle: AppTextStyles.heading,
    backgroundColor: AppColors.light,
    shape: RoundedRectangleBorder(
      side: AppBorders.thick,
      borderRadius: AppBorders.soft,
    ),
    barrierColor: AppColors.primary.withAlpha((255 * 0.8).round()),
  ),

  switchTheme: .new(),

  navigationBarTheme: .new(labelTextStyle: .all(AppTextStyles.label)),
);
