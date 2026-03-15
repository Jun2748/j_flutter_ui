import 'package:flutter/material.dart';

abstract final class JColors {
  const JColors._();

  // Base neutrals
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  static const Color neutral50 = Color(0xFFF9FAFB);
  static const Color neutral100 = Color(0xFFF3F4F6);
  static const Color neutral200 = Color(0xFFE5E7EB);
  static const Color neutral300 = Color(0xFFD1D5DB);
  static const Color neutral400 = Color(0xFF9CA3AF);
  static const Color neutral500 = Color(0xFF6B7280);
  static const Color neutral600 = Color(0xFF4B5563);
  static const Color neutral700 = Color(0xFF374151);
  static const Color neutral800 = Color(0xFF1F2937);
  static const Color neutral900 = Color(0xFF111827);

  // Base brand and feedback colors
  static const Color primaryBase = Color(0xFF2563EB);
  static const Color successBase = Color(0xFF16A34A);
  static const Color warningBase = Color(0xFFF59E0B);
  static const Color errorBase = Color(0xFFDC2626);
  static const Color infoBase = Color(0xFF0EA5E9);

  // Semantic aliases
  static const Color primary = primaryBase;
  static const Color success = successBase;
  static const Color warning = warningBase;
  static const Color error = errorBase;
  static const Color info = infoBase;

  static const Map<String, Color> lightPalette = <String, Color>{
    'background': white,
    'surface': neutral50,
    'card': white,
    'textPrimary': neutral900,
    'textSecondary': neutral600,
    'textDisabled': neutral400,
    'border': neutral200,
    'divider': neutral200,
    'primary': primaryBase,
    'success': successBase,
    'warning': warningBase,
    'error': errorBase,
    'info': infoBase,
  };

  static const Map<String, Color> darkPalette = <String, Color>{
    'background': Color(0xFF0F172A),
    'surface': Color(0xFF111827),
    'card': Color(0xFF1E293B),
    'textPrimary': Color(0xFFF8FAFC),
    'textSecondary': Color(0xFFCBD5E1),
    'textDisabled': Color(0xFF64748B),
    'border': Color(0xFF334155),
    'divider': Color(0xFF1F2937),
    'primary': Color(0xFF60A5FA),
    'success': Color(0xFF4ADE80),
    'warning': Color(0xFFFBBF24),
    'error': Color(0xFFF87171),
    'info': Color(0xFF38BDF8),
  };

  static bool isDarkTheme(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Color getColor(
    BuildContext context, {
    required String lightKey,
    String? darkKey,
  }) {
    final bool isDark = isDarkTheme(context);
    final Map<String, Color> activePalette = isDark
        ? darkPalette
        : lightPalette;
    final String resolvedKey = isDark ? (darkKey ?? lightKey) : lightKey;

    final Color? resolvedColor = activePalette[resolvedKey];
    if (resolvedColor != null) {
      return resolvedColor;
    }

    final Color? fallbackColor = lightPalette[lightKey];
    if (fallbackColor != null) {
      return fallbackColor;
    }

    throw ArgumentError.value(
      lightKey,
      'lightKey',
      'Unknown semantic color key.',
    );
  }
}
