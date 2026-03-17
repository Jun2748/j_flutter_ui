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
      primary: palette['primary']!,
      secondary: palette['info']!,
      cardBackground: palette['card']!,
      cardBorderColor: palette['border']!,
      inputBackground: palette['card']!,
      inputBorderColor: palette['border']!,
      dividerColor: palette['divider']!,
      mutedText: palette['textSecondary']!,
    );
  }

  static AppThemeTokens resolve(ThemeData theme) {
    return theme.extension<AppThemeTokens>() ??
        AppThemeTokens.fallback(brightness: theme.brightness);
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
      dividerColor:
          Color.lerp(dividerColor, other.dividerColor, t) ?? dividerColor,
      mutedText: Color.lerp(mutedText, other.mutedText, t) ?? mutedText,
    );
  }
}
