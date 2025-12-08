import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_tokens.dart';

class AppTextStyles {
  static final TextStyle display = GoogleFonts.anton(
    fontSize: AppFont.display,
    fontWeight: FontWeight.w900,
    color: AppColors.black,
    letterSpacing: -2,
  );

  static final TextStyle displaySmall = GoogleFonts.anton(
    fontSize: AppFont.displaySmall,
    fontWeight: FontWeight.w900,
    color: AppColors.black,
    letterSpacing: -2,
  );

  static final TextStyle heading = GoogleFonts.anton(
    fontSize: AppFont.h1,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  static final TextStyle body = GoogleFonts.robotoMono(
    fontSize: AppFont.body,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
    height: 1.2,
  );

  static final TextStyle label = GoogleFonts.robotoMono(
    fontSize: AppFont.label,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
    letterSpacing: 1,
  );
}
