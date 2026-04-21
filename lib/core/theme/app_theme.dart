import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';
import 'typography.dart';

class AppTheme {
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: kSurface,
        colorScheme: const ColorScheme.dark(
          primary: kPrimaryGreen,
          secondary: kLeafAccent,
          surface: kSurface,
          error: kError,
          onPrimary: kDeepForest,
          onSurface: kTextPrimary,
        ),
        textTheme: verdantTextTheme,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: false,
          backgroundColor: Colors.transparent,
          foregroundColor: kTextPrimary,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        dividerColor: kBorderSubtle,
        cardTheme: CardThemeData(
          color: kSurfaceCard,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: kBorderSubtle),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: kSurfaceCard,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: kBorderSubtle),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: kBorderSubtle),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: kPrimaryGreen, width: 1.5),
          ),
          labelStyle: verdantTextTheme.bodyMedium,
          hintStyle: verdantTextTheme.bodyMedium?.copyWith(color: kTextMuted),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: kSurfaceCard,
          contentTextStyle: verdantTextTheme.bodyLarge,
          behavior: SnackBarBehavior.floating,
        ),
      );
}
