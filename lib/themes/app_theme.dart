import 'package:flutter/material.dart';
import 'app_tokens.dart';
import 'app_typography.dart';

final ThemeData brutalistTheme = ThemeData(
  useMaterial3: true,

  scaffoldBackgroundColor: AppColors.primary,

  colorScheme: const .new(
    brightness: Brightness.light,

    // Brand
    primary: AppColors.primary,
    onPrimary: AppColors.black,

    secondary: AppColors.secondary,
    onSecondary: AppColors.black,

    tertiary: AppColors.accent,
    onTertiary: AppColors.black,

    // Surfaces
    surface: AppColors.surface,
    onSurface: AppColors.textPrimary,

    // States
    error: AppColors.error,
    onError: AppColors.white,

    // Containers (required)
    primaryContainer: AppColors.gray100,
    onPrimaryContainer: AppColors.textPrimary,

    secondaryContainer: AppColors.gray300,
    onSecondaryContainer: AppColors.textPrimary,

    tertiaryContainer: AppColors.accent,
    onTertiaryContainer: AppColors.black,

    errorContainer: AppColors.error,
    onErrorContainer: AppColors.white,
  ),

  textTheme: TextTheme(
    // DISPLAY
    displayLarge: AppTextStyles.displayLarge,
    displayMedium: AppTextStyles.displayMedium,
    displaySmall: AppTextStyles.displaySmall,

    // HEADLINES
    headlineLarge: AppTextStyles.h1,
    headlineMedium: AppTextStyles.h2,
    headlineSmall: AppTextStyles.h3,

    // TITLES
    titleLarge: AppTextStyles.titleLarge,
    titleMedium: AppTextStyles.titleMedium,
    titleSmall: AppTextStyles.titleSmall,

    // BODY
    bodyLarge: AppTextStyles.bodyLarge,
    bodyMedium: AppTextStyles.bodyMedium,
    bodySmall: AppTextStyles.bodySmall,

    // LABELS
    labelLarge: AppTextStyles.labelLarge,
    labelMedium: AppTextStyles.labelMedium,
    labelSmall: AppTextStyles.labelSmall,
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.white,
    foregroundColor: AppColors.black,
    elevation: 0,
    centerTitle: false,
    titleTextStyle: AppTextStyles.displayLarge,
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
    labelStyle: AppTextStyles.labelLarge,
    border: OutlineInputBorder(
      borderRadius: AppBorders.hard,
      borderSide: AppBorders.thick,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: AppBorders.hard,
      borderSide: .new(color: AppColors.black, width: 3),
    ),
  ),

  listTileTheme: .new(
    tileColor: AppColors.white,
    titleTextStyle: AppTextStyles.titleMedium,
    subtitleTextStyle: AppTextStyles.bodyMedium,
  ),

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
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      elevation: .all(0),
      backgroundColor: const WidgetStatePropertyAll(AppColors.black),
      foregroundColor: const WidgetStatePropertyAll(AppColors.white),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: AppBorders.hard),
      ),
    ),
  ),
  outlinedButtonTheme: .new(
    style: .new(
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: AppBorders.hard),
      ),
    ),
  ),
  textButtonTheme: .new(
    style: .new(
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: AppBorders.hard),
      ),
    ),
  ),

  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.black,
    foregroundColor: AppColors.white,
    elevation: 2.0,
  ),

  bottomSheetTheme: .new(
    backgroundColor: AppColors.white,
    shape: RoundedRectangleBorder(
      side: AppBorders.thick,
      borderRadius: AppBorders.soft,
    ),
    elevation: 0.0,
  ),

  dialogTheme: .new(
    contentTextStyle: AppTextStyles.bodyLarge,
    titleTextStyle: AppTextStyles.titleLarge,
    backgroundColor: AppColors.white,
    shape: RoundedRectangleBorder(
      side: AppBorders.thick,
      borderRadius: AppBorders.soft,
    ),
    barrierColor: AppColors.primary.withAlpha((255 * 0.8).round()),
  ),

  switchTheme: .new(),

  navigationBarTheme: .new(labelTextStyle: .all(AppTextStyles.labelMedium)),
);
