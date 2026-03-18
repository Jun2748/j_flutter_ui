import 'package:flutter/material.dart';

import 'app_theme_tokens.dart';
import 'dimens.dart';
import 'styles.dart';

@immutable
class JInputDecorations {
  const JInputDecorations._();

  static InputDecoration textField(
    ThemeData theme, {
    required AppThemeTokens tokens,
    String? labelText,
    String? hintText,
    String? helperText,
    String? errorText,
    Widget? prefix,
    Widget? suffix,
    Widget? prefixIcon,
    Widget? suffixIcon,
    Color? fillColor,
    Color? borderColor,
  }) {
    final InputDecoration themedDecoration = InputDecoration(
      labelText: labelText,
      hintText: hintText,
      helperText: helperText,
      errorText: errorText,
      prefix: prefix,
      suffix: suffix,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
    ).applyDefaults(theme.inputDecorationTheme);

    return _base(
      theme,
      tokens: tokens,
      themedDecoration: themedDecoration,
      fillColor: fillColor,
      borderColor: borderColor,
    );
  }

  static InputDecoration dropdown(
    ThemeData theme, {
    required AppThemeTokens tokens,
    String? labelText,
    String? hintText,
    String? helperText,
    String? errorText,
    required bool enabled,
  }) {
    final InputDecoration themedDecoration = InputDecoration(
      labelText: labelText,
      hintText: hintText,
      helperText: helperText,
      errorText: errorText,
      enabled: enabled,
    ).applyDefaults(theme.inputDecorationTheme);

    return _base(
      theme,
      tokens: tokens,
      themedDecoration: themedDecoration,
      fillColor: null,
      borderColor: null,
    );
  }

  static InputDecoration _base(
    ThemeData theme, {
    required AppThemeTokens tokens,
    required InputDecoration themedDecoration,
    required Color? fillColor,
    required Color? borderColor,
  }) {
    final Color resolvedFillColor = fillColor ?? tokens.inputBackground;
    final Color resolvedBorderColor = borderColor ?? tokens.inputBorderColor;
    final Color mutedTextColor = tokens.mutedText;
    final Color dividerColor = tokens.dividerColor;

    return themedDecoration.copyWith(
      filled: themedDecoration.filled ?? true,
      fillColor: resolvedFillColor,
      contentPadding:
          themedDecoration.contentPadding ?? JInsets.horizontal16Vertical12,
      constraints:
          themedDecoration.constraints ??
          const BoxConstraints(minHeight: JHeights.input),
      border: _resolveOutlineBorder(
        themedDecoration.border,
        color: resolvedBorderColor,
      ),
      enabledBorder: _resolveOutlineBorder(
        themedDecoration.enabledBorder ?? themedDecoration.border,
        color: resolvedBorderColor,
      ),
      focusedBorder: _resolveOutlineBorder(
        themedDecoration.focusedBorder ??
            themedDecoration.enabledBorder ??
            themedDecoration.border,
        color: theme.colorScheme.primary,
        width: JDimens.dp1_5,
      ),
      disabledBorder: _resolveOutlineBorder(
        themedDecoration.disabledBorder ??
            themedDecoration.enabledBorder ??
            themedDecoration.border,
        color: dividerColor,
      ),
      errorBorder: _resolveOutlineBorder(
        themedDecoration.errorBorder ??
            themedDecoration.enabledBorder ??
            themedDecoration.border,
        color: theme.colorScheme.error,
      ),
      focusedErrorBorder: _resolveOutlineBorder(
        themedDecoration.focusedErrorBorder ??
            themedDecoration.errorBorder ??
            themedDecoration.enabledBorder ??
            themedDecoration.border,
        color: theme.colorScheme.error,
        width: JDimens.dp1_5,
      ),
      hintStyle:
          (themedDecoration.hintStyle ??
                  theme.textTheme.bodyMedium ??
                  JTextStyles.body2)
              .copyWith(color: mutedTextColor),
      labelStyle:
          (themedDecoration.labelStyle ??
                  theme.textTheme.bodyMedium ??
                  JTextStyles.body2)
              .copyWith(color: mutedTextColor),
      helperStyle:
          (themedDecoration.helperStyle ??
                  theme.textTheme.labelSmall ??
                  JTextStyles.label)
              .copyWith(color: mutedTextColor),
      errorStyle:
          (themedDecoration.errorStyle ??
                  theme.textTheme.labelSmall ??
                  JTextStyles.label)
              .copyWith(color: theme.colorScheme.error),
    );
  }

  static OutlineInputBorder _resolveOutlineBorder(
    InputBorder? base, {
    required Color color,
    double? width,
  }) {
    final OutlineInputBorder? outlineBase =
        base is OutlineInputBorder ? base : null;

    return OutlineInputBorder(
      borderRadius:
          outlineBase?.borderRadius ??
          BorderRadius.circular(JDimens.dp12),
      borderSide: BorderSide(
        color: color,
        width: width ?? outlineBase?.borderSide.width ?? JDimens.dp1,
      ),
    );
  }
}

