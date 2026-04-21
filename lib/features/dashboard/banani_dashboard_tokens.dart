import 'package:flutter/material.dart';

/// Banani export palette — logged-in dashboard shell & home (dark theme).
abstract final class BananiDash {
  static const Color background = Color(0xFF0B110F);
  static const Color foreground = Color(0xFFF3F4F6);
  static const Color surface = Color(0xFF131A18);
  static const Color border = Color(0xFF23312C);
  static const Color input = Color(0xFF1C2623);
  static const Color primary = Color(0xFF22C55E);
  static const Color onPrimary = Color(0xFF022C22);
  static const Color secondary = Color(0xFF164E63);
  static const Color muted = Color(0xFF1C2623);
  static const Color mutedForeground = Color(0xFF9CA3AF);
  static const Color warning = Color(0xFFEAB308);
  static const Color onWarning = Color(0xFF422006);
  static const Color danger = Color(0xFFEF4444);
  static const Color onDanger = Color(0xFF450A0A);

  static const double radiusSm = 6;
  static const double radiusMd = 10;
  static const double radiusLg = 16;

  static const double sidebarWidth = 256;

  static Color primaryMuted(double opacity) =>
      primary.withValues(alpha: opacity);

  static Color secondaryMuted(double opacity) =>
      secondary.withValues(alpha: opacity);

  static Color warningMuted(double opacity) =>
      warning.withValues(alpha: opacity);

  static List<BoxShadow> primaryBarGlow = [
    BoxShadow(
      color: primary.withValues(alpha: 0.3),
      blurRadius: 10,
      spreadRadius: 0,
    ),
  ];
}
