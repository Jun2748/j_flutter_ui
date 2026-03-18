import 'package:flutter/material.dart';

import 'colors.dart';

@immutable
class AppThemeTokens extends ThemeExtension<AppThemeTokens> {
  const AppThemeTokens({
    required this.primary,
    required this.secondary,
    required this.cardBackground,
    required this.cardBorderColor,
    required this.inputBackground,
    required this.inputBorderColor,
    required this.dividerColor,
    required this.mutedText,
  });

  factory AppThemeTokens.fallback({required Brightness brightness}) {
    final Map<String, Color> palette = brightness == Brightness.dark
        ? JColors.darkPalette
        : JColors.lightPalette;

    return AppThemeTokens(
      primary: palette[PaletteConst.primary] ?? JColors.primaryBase,
      secondary: palette[PaletteConst.info] ?? JColors.infoBase,
      cardBackground: palette[PaletteConst.card] ?? JColors.white,
      cardBorderColor: palette[PaletteConst.border] ?? JColors.neutral200,
      inputBackground: palette[PaletteConst.card] ?? JColors.white,
      inputBorderColor: palette[PaletteConst.border] ?? JColors.neutral200,
      dividerColor: palette[PaletteConst.divider] ?? JColors.neutral200,
      mutedText: palette[PaletteConst.textSecondary] ?? JColors.neutral600,
    );
  }

  factory AppThemeTokens.resolve(ThemeData theme) {
    final AppThemeTokens? extension = theme.extension<AppThemeTokens>();
    if (extension != null) {
      return extension;
    }

    return AppThemeTokens(
      primary: theme.colorScheme.primary,
      secondary: theme.colorScheme.secondary,
      cardBackground:
          theme.cardTheme.color ?? theme.colorScheme.surfaceContainerHighest,
      cardBorderColor:
          _shapeBorderColor(theme.cardTheme.shape) ?? theme.colorScheme.outline,
      inputBackground:
          theme.inputDecorationTheme.fillColor ??
          theme.cardTheme.color ??
          theme.colorScheme.surface,
      inputBorderColor:
          _inputBorderColor(theme.inputDecorationTheme.enabledBorder) ??
          _inputBorderColor(theme.inputDecorationTheme.border) ??
          theme.colorScheme.outline,
      dividerColor: theme.dividerTheme.color ?? theme.dividerColor,
      mutedText:
          theme.textTheme.bodyMedium?.color ??
          theme.textTheme.labelSmall?.color ??
          theme.colorScheme.onSurfaceVariant,
    );
  }

  final Color primary;
  final Color secondary;
  final Color cardBackground;
  final Color cardBorderColor;
  final Color inputBackground;
  final Color inputBorderColor;
  final Color dividerColor;
  final Color mutedText;

  @override
  AppThemeTokens copyWith({
    Color? primary,
    Color? secondary,
    Color? cardBackground,
    Color? cardBorderColor,
    Color? inputBackground,
    Color? inputBorderColor,
    Color? dividerColor,
    Color? mutedText,
  }) {
    return AppThemeTokens(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      cardBackground: cardBackground ?? this.cardBackground,
      cardBorderColor: cardBorderColor ?? this.cardBorderColor,
      inputBackground: inputBackground ?? this.inputBackground,
      inputBorderColor: inputBorderColor ?? this.inputBorderColor,
      dividerColor: dividerColor ?? this.dividerColor,
      mutedText: mutedText ?? this.mutedText,
    );
  }

  @override
  AppThemeTokens lerp(ThemeExtension<AppThemeTokens>? other, double t) {
    if (other is! AppThemeTokens) {
      return this;
    }

    return AppThemeTokens(
      primary: Color.lerp(primary, other.primary, t) ?? primary,
      secondary: Color.lerp(secondary, other.secondary, t) ?? secondary,
      cardBackground:
          Color.lerp(cardBackground, other.cardBackground, t) ?? cardBackground,
      cardBorderColor:
          Color.lerp(cardBorderColor, other.cardBorderColor, t) ??
          cardBorderColor,
      inputBackground:
          Color.lerp(inputBackground, other.inputBackground, t) ??
          inputBackground,
      inputBorderColor:
          Color.lerp(inputBorderColor, other.inputBorderColor, t) ??
          inputBorderColor,
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t) ?? dividerColor,
      mutedText: Color.lerp(mutedText, other.mutedText, t) ?? mutedText,
    );
  }

  static Color? _shapeBorderColor(ShapeBorder? shape) {
    if (shape is OutlinedBorder && shape.side.style != BorderStyle.none) {
      return shape.side.color;
    }
    return null;
  }

  static Color? _inputBorderColor(InputBorder? border) {
    if (border == null || border.borderSide.style == BorderStyle.none) {
      return null;
    }
    return border.borderSide.color;
  }
}

extension AppThemeTokensThemeDataX on ThemeData {
  AppThemeTokens get appThemeTokens => AppThemeTokens.resolve(this);
}
