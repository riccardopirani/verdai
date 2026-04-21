import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

TextTheme verdantTextTheme = TextTheme(
  displayLarge: GoogleFonts.syne(
    fontSize: 64,
    fontWeight: FontWeight.w700,
    color: kTextPrimary,
    height: 1.1,
  ),
  displayMedium: GoogleFonts.syne(
    fontSize: 48,
    fontWeight: FontWeight.w700,
    color: kTextPrimary,
    height: 1.1,
  ),
  headlineLarge: GoogleFonts.syne(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: kTextPrimary,
  ),
  headlineMedium: GoogleFonts.syne(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: kTextPrimary,
  ),
  titleLarge: GoogleFonts.dmSans(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: kTextPrimary,
  ),
  bodyLarge: GoogleFonts.dmSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: kTextSecondary,
  ),
  bodyMedium: GoogleFonts.dmSans(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: kTextSecondary,
  ),
  labelLarge: GoogleFonts.dmSans(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    color: kTextPrimary,
  ),
);

TextStyle verdantMono(double size, {FontWeight weight = FontWeight.w500}) {
  return GoogleFonts.jetBrainsMono(fontSize: size, fontWeight: weight, color: kTextPrimary);
}
