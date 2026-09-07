import 'package:flutter/material.dart';

class AppColors {
  // Brand Oceanic Palette
  static const Color primary = Color(0xFF00253B);
  static const Color primaryContainer = Color(0xFF003B5C);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onPrimaryContainer = Color(0xFF7AA5CC);

  static const Color secondary = Color(0xFF006398);
  static const Color secondaryContainer = Color(0xFF7CC2FD);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onSecondaryContainer = Color(0xFF004F7A);

  static const Color tertiary = Color(0xFF002634);
  static const Color tertiaryContainer = Color(0xFF003D51);
  static const Color onTertiary = Color(0xFFFFFFFF);

  // Surfaces & Backgrounds
  static const Color background = Color(0xFFFAF8FF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF2F3FF);
  static const Color surfaceContainer = Color(0xFFEAEDFF);
  static const Color surfaceContainerHigh = Color(0xFFE2E7FF);
  static const Color surfaceContainerHighest = Color(0xFFDAE2FD);

  // Text & Content
  static const Color onSurface = Color(0xFF131B2E);
  static const Color onSurfaceVariant = Color(0xFF42474E);
  static const Color onBackground = Color(0xFF131B2E);

  // Borders & Outlines
  static const Color outline = Color(0xFF72787E);
  static const Color outlineVariant = Color(0xFFE2E8F0);
  static const Color divider = Color(0xFFE2E8F0);

  // Status & Semantics
  static const Color success = Color(0xFF10B981);
  static const Color successContainer = Color(0xFFD1FAE5);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningContainer = Color(0xFFFEF3C7);
  static const Color error = Color(0xFFBA1A1A);
  static const Color errorContainer = Color(0xFFFFDAD6);

  // Elevation Shadows
  static const BoxShadow cardShadow = BoxShadow(
    color: Color.fromRGBO(0, 59, 92, 0.07),
    blurRadius: 16,
    offset: Offset(0, 4),
  );

  static const BoxShadow floatingShadow = BoxShadow(
    color: Color.fromRGBO(0, 59, 92, 0.12),
    blurRadius: 28,
    offset: Offset(0, 8),
  );
}
