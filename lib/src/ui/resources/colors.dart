import 'package:flutter/material.dart';

abstract final class PaletteConst {
  const PaletteConst._();

  static const String background = 'background';
  static const String surface = 'surface';
  static const String card = 'card';
  static const String textPrimary = 'textPrimary';
  static const String textSecondary = 'textSecondary';
  static const String textDisabled = 'textDisabled';
  static const String border = 'border';
  static const String divider = 'divider';
  static const String primary = 'primary';
  static const String success = 'success';
  static const String warning = 'warning';
  static const String error = 'error';
  static const String info = 'info';
}

@immutable
class JStatusColors extends ThemeExtension<JStatusColors> {
  const JStatusColors({
    required this.success,
    required this.warning,
    required this.info,
  });

  factory JStatusColors.fallback({required Brightness brightness}) {
    return brightness == Brightness.dark
        ? const JStatusColors(
            success: Color(0xFF4ADE80),
            warning: Color(0xFFFBBF24),
            info: Color(0xFF38BDF8),
          )
        : const JStatusColors(
            success: Color(0xFF16A34A),
            warning: Color(0xFFF59E0B),
            info: Color(0xFF0EA5E9),
          );
  }

  final Color success;
  final Color warning;
  final Color info;

  @override
  JStatusColors copyWith({Color? success, Color? warning, Color? info}) {
    return JStatusColors(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
    );
  }

  @override
  JStatusColors lerp(ThemeExtension<JStatusColors>? other, double t) {
    if (other is! JStatusColors) {
      return this;
    }

    return JStatusColors(
      success: Color.lerp(success, other.success, t) ?? success,
      warning: Color.lerp(warning, other.warning, t) ?? warning,
      info: Color.lerp(info, other.info, t) ?? info,
    );
  }
}

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
    PaletteConst.background: white,
    PaletteConst.surface: neutral50,
    PaletteConst.card: white,
    PaletteConst.textPrimary: neutral900,
    PaletteConst.textSecondary: neutral600,
    PaletteConst.textDisabled: neutral400,
    PaletteConst.border: neutral200,
    PaletteConst.divider: neutral200,
    PaletteConst.primary: primaryBase,
    PaletteConst.success: successBase,
    PaletteConst.warning: warningBase,
    PaletteConst.error: errorBase,
    PaletteConst.info: infoBase,
  };

  static const Map<String, Color> darkPalette = <String, Color>{
    PaletteConst.background: Color(0xFF0F172A),
    PaletteConst.surface: Color(0xFF111827),
    PaletteConst.card: Color(0xFF1E293B),
    PaletteConst.textPrimary: Color(0xFFF8FAFC),
    PaletteConst.textSecondary: Color(0xFFCBD5E1),
    PaletteConst.textDisabled: Color(0xFF64748B),
    PaletteConst.border: Color(0xFF334155),
    PaletteConst.divider: Color(0xFF1F2937),
    PaletteConst.primary: Color(0xFF60A5FA),
    PaletteConst.success: Color(0xFF4ADE80),
    PaletteConst.warning: Color(0xFFFBBF24),
    PaletteConst.error: Color(0xFFF87171),
    PaletteConst.info: Color(0xFF38BDF8),
  };

  static bool isDarkTheme(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Color getColor(
    BuildContext context, {
    required String lightKey,
    String? darkKey,
  }) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = isDarkTheme(context);
    final String resolvedKey = isDark ? (darkKey ?? lightKey) : lightKey;

    switch (resolvedKey) {
      case PaletteConst.background:
        return theme.scaffoldBackgroundColor;
      case PaletteConst.surface:
        return theme.colorScheme.surface;
      case PaletteConst.card:
        return theme.cardTheme.color ?? theme.colorScheme.surface;
      case PaletteConst.textPrimary:
        return theme.textTheme.bodyLarge?.color ?? theme.colorScheme.onSurface;
      case PaletteConst.textSecondary:
        return theme.textTheme.bodyMedium?.color ??
            theme.textTheme.labelSmall?.color ??
            theme.colorScheme.onSurfaceVariant;
      case PaletteConst.textDisabled:
        return theme.disabledColor;
      case PaletteConst.border:
        return theme.colorScheme.outline;
      case PaletteConst.divider:
        return DividerTheme.of(context).color ??
            theme.colorScheme.outlineVariant;
      case PaletteConst.primary:
        return theme.colorScheme.primary;
      case PaletteConst.success:
        return theme.extension<JStatusColors>()?.success ??
            _fallbackColor(isDark, resolvedKey);
      case PaletteConst.warning:
        return theme.extension<JStatusColors>()?.warning ??
            _fallbackColor(isDark, resolvedKey);
      case PaletteConst.error:
        return theme.colorScheme.error;
      case PaletteConst.info:
        return theme.extension<JStatusColors>()?.info ??
            _fallbackColor(isDark, resolvedKey);
    }

    final Color? fallbackColor =
        _activePalette(isDark)[resolvedKey] ?? lightPalette[lightKey];
    if (fallbackColor != null) {
      return fallbackColor;
    }

    throw ArgumentError.value(
      lightKey,
      'lightKey',
      'Unknown semantic color key.',
    );
  }

  static Map<String, Color> _activePalette(bool isDark) {
    return isDark ? darkPalette : lightPalette;
  }

  static Color _fallbackColor(bool isDark, String key) {
    return _activePalette(isDark)[key] ?? lightPalette[key]!;
  }
}
