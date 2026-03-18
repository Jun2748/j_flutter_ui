import 'package:flutter/material.dart';

import '../../../resources/app_theme_tokens.dart';
import '../../../resources/dimens.dart';
import '../../../resources/styles.dart';

class SimpleTextField extends StatelessWidget {
  const SimpleTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.labelText,
    this.hintText,
    this.helperText,
    this.errorText,
    this.prefix,
    this.suffix,
    this.prefixIcon,
    this.suffixIcon,
    this.fillColor,
    this.borderColor,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
  }) : assert(maxLines > 0, 'maxLines must be greater than 0.');

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? fillColor;
  final Color? borderColor;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle baseTextStyle =
        theme.textTheme.bodyLarge ??
        JTextStyles.body1.copyWith(color: theme.colorScheme.onSurface);
    final TextStyle resolvedTextStyle = enabled
        ? baseTextStyle
        : baseTextStyle.copyWith(color: theme.disabledColor);

    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      autofillHints: autofillHints,
      obscureText: obscureText,
      enabled: enabled,
      readOnly: readOnly,
      showCursor: enabled && !readOnly,
      maxLines: obscureText ? 1 : maxLines,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
      style: resolvedTextStyle,
      decoration: _buildDecoration(theme),
    );
  }

  InputDecoration _buildDecoration(ThemeData theme) {
    final AppThemeTokens tokens = theme.appThemeTokens;
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
      border: _resolveBorder(themedDecoration.border, color: resolvedBorderColor),
      enabledBorder: _resolveBorder(
        themedDecoration.enabledBorder ?? themedDecoration.border,
        color: resolvedBorderColor,
      ),
      focusedBorder: _resolveBorder(
        themedDecoration.focusedBorder ??
            themedDecoration.enabledBorder ??
            themedDecoration.border,
        color: theme.colorScheme.primary,
        width: JDimens.dp1_5,
      ),
      disabledBorder: _resolveBorder(
        themedDecoration.disabledBorder ??
            themedDecoration.enabledBorder ??
            themedDecoration.border,
        color: dividerColor,
      ),
      errorBorder: _resolveBorder(
        themedDecoration.errorBorder ??
            themedDecoration.enabledBorder ??
            themedDecoration.border,
        color: theme.colorScheme.error,
      ),
      focusedErrorBorder: _resolveBorder(
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

  OutlineInputBorder _resolveBorder(
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
