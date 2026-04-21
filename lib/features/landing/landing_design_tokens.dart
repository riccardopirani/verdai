import 'package:flutter/material.dart';

/// Banani export palette — CSRD landing (light mode).
abstract final class LandingDesign {
  static const Color background = Color(0xFFFFFFFF);
  static const Color foreground = Color(0xFF0F172A);
  static const Color border = Color(0xFFE2E8F0);
  static const Color primary = Color(0xFF1A4731);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color secondary = Color(0xFFF59E0B);
  static const Color onSecondary = Color(0xFFFFFFFF);

  /// CTA: amber background with dark green label (matches export).
  static const Color ctaOnSecondary = primary;
  static const Color muted = Color(0xFFF1F5F9);
  static const Color mutedForeground = Color(0xFF64748B);
  static const Color destructive = Color(0xFFEF4444);
  static const Color onPrimaryMuted = Color(0xB3FFFFFF); // ~70% white

  static Color destructiveSurface(double opacity) =>
      destructive.withValues(alpha: opacity);

  /// Verdai [TextTheme] sets explicit light-green colours; `apply()` does not
  /// reliably override them. Force readable contrast on light backgrounds.
  static TextTheme lightTextTheme(TextTheme source) {
    /// After `ThemeData.localize`, Material merges [englishLike] geometry with
    /// this theme via [TextStyle.merge]. Geometry uses `inherit: false` with no
    /// color; if our styles stay `inherit: true` (e.g. Google Fonts), merge can
    /// keep a light-on-light color. Forcing `inherit: false` makes merge prefer
    /// our full style (including [color]) for readable text on white.
    TextStyle? paint(TextStyle? style, Color color) {
      if (style == null) {
        return TextStyle(
          color: color,
          fontSize: 14,
          height: 1.4,
          inherit: false,
        );
      }
      return style.copyWith(color: color, inherit: false);
    }

    return TextTheme(
      displayLarge: paint(source.displayLarge, foreground),
      displayMedium: paint(source.displayMedium, foreground),
      displaySmall: paint(source.displaySmall, foreground),
      headlineLarge: paint(source.headlineLarge, foreground),
      headlineMedium: paint(source.headlineMedium, foreground),
      headlineSmall: paint(source.headlineSmall, foreground),
      titleLarge: paint(source.titleLarge, foreground),
      titleMedium: paint(source.titleMedium, foreground),
      titleSmall: paint(source.titleSmall, foreground),
      bodyLarge: paint(source.bodyLarge, foreground),
      bodyMedium: paint(source.bodyMedium, mutedForeground),
      bodySmall: paint(source.bodySmall, mutedForeground),
      labelLarge: paint(source.labelLarge, foreground),
      labelMedium: paint(source.labelMedium, foreground),
      labelSmall: paint(source.labelSmall, mutedForeground),
    );
  }

  static ThemeData themeOverlay(BuildContext context) {
    final base = Theme.of(context);
    final text = lightTextTheme(base.textTheme);
    return base.copyWith(
      brightness: Brightness.light,
      scaffoldBackgroundColor: background,
      canvasColor: background,
      colorScheme: const ColorScheme.light(
        primary: primary,
        onPrimary: onPrimary,
        secondary: secondary,
        onSecondary: onSecondary,
        surface: background,
        onSurface: foreground,
        onSurfaceVariant: mutedForeground,
        error: destructive,
        outline: border,
        surfaceContainerHighest: muted,
      ),
      dividerColor: border,
      textTheme: text,
      primaryTextTheme: lightTextTheme(base.primaryTextTheme),
      iconTheme: const IconThemeData(color: foreground),
      dividerTheme: const DividerThemeData(color: border),
      dropdownMenuTheme: const DropdownMenuThemeData(
        menuStyle: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(background),
        ),
        textStyle: TextStyle(
          color: foreground,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: background.withValues(alpha: 0.96),
        foregroundColor: foreground,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        iconTheme: const IconThemeData(color: foreground),
        titleTextStyle: text.titleLarge?.copyWith(
          color: foreground,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// Login / register: full field styling on white.
  static ThemeData authShellTheme(BuildContext context) {
    final base = themeOverlay(context);
    final borderRadius = BorderRadius.circular(10);
    return base.copyWith(
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: background,
        hintStyle: base.textTheme.bodyMedium?.copyWith(
          color: mutedForeground,
        ),
        labelStyle: base.textTheme.labelLarge?.copyWith(color: foreground),
        floatingLabelStyle: WidgetStateTextStyle.resolveWith((states) {
          if (states.contains(WidgetState.error)) {
            return TextStyle(color: base.colorScheme.error);
          }
          if (states.contains(WidgetState.focused)) {
            return TextStyle(color: base.colorScheme.primary);
          }
          return const TextStyle(color: mutedForeground);
        }),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: base.colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: base.colorScheme.error, width: 1.5),
        ),
      ),
    );
  }
}
