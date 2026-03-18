import 'package:flutter/material.dart';

import 'colors.dart';

@immutable
class AppThemeTokens extends ThemeExtension<AppThemeTokens> {
  const AppThemeTokens({
    required this.primary,
    this.onPrimary,
    required this.secondary,
    this.onSecondary,
    required this.cardBackground,
    this.onCard,
    required this.cardBorderColor,
    required this.inputBackground,
    this.onInput,
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
      onPrimary: brightness == Brightness.dark ? JColors.black : JColors.white,
      secondary: palette[PaletteConst.info] ?? JColors.infoBase,
      onSecondary: null,
      cardBackground: palette[PaletteConst.card] ?? JColors.white,
      onCard: null,
      cardBorderColor: palette[PaletteConst.border] ?? JColors.neutral200,
      inputBackground: palette[PaletteConst.card] ?? JColors.white,
      onInput: null,
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
      onPrimary: theme.colorScheme.onPrimary,
      secondary: theme.colorScheme.secondary,
      onSecondary: theme.colorScheme.onSecondary,
      cardBackground:
          theme.cardTheme.color ?? theme.colorScheme.surfaceContainerHighest,
      onCard: theme.colorScheme.onSurface,
      cardBorderColor:
          _shapeBorderColor(theme.cardTheme.shape) ?? theme.colorScheme.outline,
      inputBackground:
          theme.inputDecorationTheme.fillColor ??
          theme.cardTheme.color ??
          theme.colorScheme.surface,
      onInput: theme.colorScheme.onSurface,
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
  final Color? onPrimary;
  final Color secondary;
  final Color? onSecondary;
  final Color cardBackground;
  final Color? onCard;
  final Color cardBorderColor;
  final Color inputBackground;
  final Color? onInput;
  final Color inputBorderColor;
  final Color dividerColor;
  final Color mutedText;

  Color onPrimaryResolved(ThemeData theme) {
    return onPrimary ?? _onColorForBackground(primary);
  }

  Color onSecondaryResolved(ThemeData theme) {
    return onSecondary ?? _onColorForBackground(secondary);
  }

  Color onCardResolved(ThemeData theme) {
    return onCard ?? theme.colorScheme.onSurface;
  }

  Color onInputResolved(ThemeData theme) {
    return onInput ?? theme.colorScheme.onSurface;
  }

  Color _onColorForBackground(Color background) {
    final Brightness b = ThemeData.estimateBrightnessForColor(background);
    return b == Brightness.dark ? Colors.white : Colors.black;
  }

  @override
  AppThemeTokens copyWith({
    Color? primary,
    Color? onPrimary,
    Color? secondary,
    Color? onSecondary,
    Color? cardBackground,
    Color? onCard,
    Color? cardBorderColor,
    Color? inputBackground,
    Color? onInput,
    Color? inputBorderColor,
    Color? dividerColor,
    Color? mutedText,
  }) {
    return AppThemeTokens(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      cardBackground: cardBackground ?? this.cardBackground,
      onCard: onCard ?? this.onCard,
      cardBorderColor: cardBorderColor ?? this.cardBorderColor,
      inputBackground: inputBackground ?? this.inputBackground,
      onInput: onInput ?? this.onInput,
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
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t) ?? onPrimary,
      secondary: Color.lerp(secondary, other.secondary, t) ?? secondary,
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t) ?? onSecondary,
      cardBackground:
          Color.lerp(cardBackground, other.cardBackground, t) ?? cardBackground,
      onCard: Color.lerp(onCard, other.onCard, t) ?? onCard,
      cardBorderColor:
          Color.lerp(cardBorderColor, other.cardBorderColor, t) ??
          cardBorderColor,
      inputBackground:
          Color.lerp(inputBackground, other.inputBackground, t) ??
          inputBackground,
      onInput: Color.lerp(onInput, other.onInput, t) ?? onInput,
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
