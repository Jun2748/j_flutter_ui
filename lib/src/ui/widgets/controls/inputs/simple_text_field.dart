import 'package:flutter/material.dart';

import '../../../resources/app_theme_tokens.dart';
import '../../../resources/input_decorations.dart';
import '../../../resources/styles.dart';

class SimpleTextField extends StatelessWidget {
  const SimpleTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.initialValue,
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
  }) : assert(maxLines > 0, 'maxLines must be greater than 0.'),
       assert(
         controller == null || initialValue == null,
         'Either provide a controller or an initialValue, not both.',
       );

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? initialValue;
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
      initialValue: controller == null ? initialValue : null,
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
      decoration: JInputDecorations.textField(
        theme,
        tokens: theme.appThemeTokens,
        labelText: labelText,
        hintText: hintText,
        helperText: helperText,
        errorText: errorText,
        prefix: prefix,
        suffix: suffix,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        fillColor: fillColor,
        borderColor: borderColor,
      ),
    );
  }
}
