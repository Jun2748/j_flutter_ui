import 'package:flutter/material.dart';

import 'app_theme_tokens.dart';
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
    final AppThemeTokens appTokens = AppThemeTokens.fallback(
      brightness: brightness,
    );

    final Color primary = appTokens.primary;
    final Color surface = palette['surface']!;
    final Color card = appTokens.cardBackground;
    final Color inputBackground = appTokens.inputBackground;
    final Color background = palette['background']!;
    final Color textPrimary = palette['textPrimary']!;
    final Color textSecondary = appTokens.mutedText;
    final Color textDisabled = palette['textDisabled']!;
    final Color border = appTokens.cardBorderColor;
    final Color inputBorder = appTokens.inputBorderColor;
    final Color divider = appTokens.dividerColor;
    final Color success = palette['success']!;
    final Color warning = palette['warning']!;
    final Color error = palette['error']!;
    final Color info = appTokens.secondary;

    final ColorScheme baseColorScheme = brightness == Brightness.dark
        ? const ColorScheme.dark()
        : const ColorScheme.light();
    final ColorScheme colorScheme = baseColorScheme.copyWith(
      primary: primary,
      onPrimary: JColors.white,
      secondary: info,
      onSecondary: JColors.white,
      tertiary: success,
      onTertiary: JColors.white,
      error: error,
      onError: JColors.white,
      surface: surface,
      surfaceContainerHighest: card,
      onSurface: textPrimary,
      onSurfaceVariant: textSecondary,
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

    final OutlineInputBorder enabledBorder = _inputBorder(color: inputBorder);
    final OutlineInputBorder focusedBorder = _inputBorder(
      color: primary,
      width: JDimens.dp1_5,
    );
    final OutlineInputBorder errorBorder = _inputBorder(color: error);
    final OutlineInputBorder disabledBorder = _inputBorder(color: divider);
    final ButtonStyle baseButtonStyle = ButtonStyle(
      minimumSize: const WidgetStatePropertyAll<Size>(Size(0, JHeights.button)),
      padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
        JInsets.horizontal16Vertical12,
      ),
      textStyle: const WidgetStatePropertyAll<TextStyle>(JTextStyles.button),
      shape: WidgetStatePropertyAll<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(JDimens.dp12),
        ),
      ),
      elevation: const WidgetStatePropertyAll<double>(0),
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
      dividerTheme: DividerThemeData(
        color: divider,
        space: JDimens.dp1,
        thickness: JDimens.dp1,
      ),
      disabledColor: textDisabled,
      textTheme: textTheme,
      extensions: <ThemeExtension<dynamic>>[
        appTokens,
        JStatusColors(success: success, warning: warning, info: info),
      ],
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: JTextStyles.title2.copyWith(color: textPrimary),
        iconTheme: IconThemeData(size: JIconSizes.lg, color: textPrimary),
      ),
      cardTheme: CardThemeData(
        color: card,
        elevation: 0,
        margin: EdgeInsets.zero,
        shadowColor: JColors.black.withAlpha(12),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(JDimens.dp16),
          side: BorderSide(color: border),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: baseButtonStyle.copyWith(
          shadowColor: const WidgetStatePropertyAll<Color>(Colors.transparent),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(style: baseButtonStyle),
      textButtonTheme: TextButtonThemeData(style: baseButtonStyle),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: inputBackground,
        contentPadding: JInsets.horizontal16Vertical12,
        constraints: const BoxConstraints(minHeight: JHeights.input),
        hintStyle: JTextStyles.body2.copyWith(color: textDisabled),
        labelStyle: JTextStyles.body2.copyWith(color: textSecondary),
        helperStyle: JTextStyles.label.copyWith(color: textSecondary),
        errorStyle: JTextStyles.label.copyWith(color: error),
        enabledBorder: enabledBorder,
        focusedBorder: focusedBorder,
        errorBorder: errorBorder,
        focusedErrorBorder: _inputBorder(color: error, width: JDimens.dp1_5),
        disabledBorder: disabledBorder,
      ),
    );
  }

  static OutlineInputBorder _inputBorder({
    required Color color,
    double width = JDimens.dp1,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(JDimens.dp12),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
