import 'package:flutter/material.dart';

import 'colors.dart';
import 'dimens.dart';
import 'styles.dart';

abstract final class JAppTheme {
  const JAppTheme._();

  static ThemeData get lightTheme => _buildTheme(Brightness.light);

  static ThemeData get darkTheme => _buildTheme(Brightness.dark);

  static ThemeData _buildTheme(Brightness brightness) {
    final Map<String, Color> palette = brightness == Brightness.dark
        ? JColors.darkPalette
        : JColors.lightPalette;

    final Color primary = palette['primary']!;
    final Color surface = palette['surface']!;
    final Color card = palette['card']!;
    final Color background = palette['background']!;
    final Color textPrimary = palette['textPrimary']!;
    final Color textSecondary = palette['textSecondary']!;
    final Color textDisabled = palette['textDisabled']!;
    final Color border = palette['border']!;
    final Color divider = palette['divider']!;
    final Color success = palette['success']!;
    final Color error = palette['error']!;
    final Color info = palette['info']!;

    final ColorScheme colorScheme =
        ColorScheme.fromSeed(
          seedColor: primary,
          brightness: brightness,
        ).copyWith(
          primary: primary,
          onPrimary: JColors.white,
          secondary: info,
          onSecondary: JColors.white,
          tertiary: success,
          onTertiary: JColors.white,
          error: error,
          onError: JColors.white,
          surface: surface,
          onSurface: textPrimary,
          outline: border,
          outlineVariant: divider,
          shadow: JColors.black.withAlpha(18),
          scrim: JColors.black.withAlpha(102),
          inverseSurface: brightness == Brightness.dark
              ? JColors.white
              : JColors.neutral900,
          onInverseSurface: brightness == Brightness.dark
              ? JColors.neutral900
              : JColors.white,
        );

    final OutlineInputBorder enabledBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(JDimens.dp12),
      borderSide: BorderSide(color: border),
    );

    final OutlineInputBorder focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(JDimens.dp12),
      borderSide: BorderSide(color: primary, width: 1.4),
    );

    final OutlineInputBorder errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(JDimens.dp12),
      borderSide: BorderSide(color: error),
    );

    final TextTheme textTheme = TextTheme(
      displayLarge: JTextStyles.title1.copyWith(color: textPrimary),
      displayMedium: JTextStyles.title2.copyWith(color: textPrimary),
      headlineLarge: JTextStyles.heading1.copyWith(color: textPrimary),
      bodyLarge: JTextStyles.body1.copyWith(color: textPrimary),
      bodyMedium: JTextStyles.body2.copyWith(color: textSecondary),
      labelSmall: JTextStyles.label.copyWith(color: textSecondary),
      labelLarge: JTextStyles.button.copyWith(color: textPrimary),
      titleLarge: JTextStyles.title2.copyWith(color: textPrimary),
      titleMedium: JTextStyles.heading1.copyWith(color: textPrimary),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
      dividerColor: divider,
      disabledColor: textDisabled,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        surfaceTintColor: const Color(0x00000000),
        titleTextStyle: JTextStyles.title2.copyWith(color: textPrimary),
        iconTheme: const IconThemeData(
          size: JIconSizes.lg,
        ).copyWith(color: textPrimary),
      ),
      cardTheme: CardThemeData(
        color: card,
        elevation: 0,
        margin: EdgeInsets.zero,
        shadowColor: JColors.black.withAlpha(12),
        surfaceTintColor: const Color(0x00000000),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(JDimens.dp16),
          side: BorderSide(color: border),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: card,
        contentPadding: JInsets.horizontal16Vertical12,
        hintStyle: JTextStyles.body2.copyWith(color: textDisabled),
        labelStyle: JTextStyles.body2.copyWith(color: textSecondary),
        helperStyle: JTextStyles.label.copyWith(color: textSecondary),
        errorStyle: JTextStyles.label.copyWith(color: error),
        enabledBorder: enabledBorder,
        focusedBorder: focusedBorder,
        errorBorder: errorBorder,
        focusedErrorBorder: errorBorder.copyWith(
          borderSide: BorderSide(color: error, width: 1.4),
        ),
        disabledBorder: enabledBorder.copyWith(
          borderSide: BorderSide(color: divider),
        ),
      ),
    );
  }
}
