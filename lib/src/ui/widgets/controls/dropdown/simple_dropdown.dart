import 'package:flutter/material.dart';

import '../../../resources/app_theme_tokens.dart';
import '../../../resources/dimens.dart';
import '../../../resources/styles.dart';

class SimpleDropdown<T> extends StatelessWidget {
  const SimpleDropdown({
    super.key,
    this.value,
    this.items,
    this.onChanged,
    this.hintText,
    this.labelText,
    this.helperText,
    this.errorText,
    this.enabled = true,
  });

  final T? value;
  final List<DropdownMenuItem<T>>? items;
  final ValueChanged<T?>? onChanged;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final String? errorText;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppThemeTokens tokens = AppThemeTokens.resolve(theme);
    final List<DropdownMenuItem<T>> resolvedItems =
        items ?? List<DropdownMenuItem<T>>.empty();
    final bool hasMatchingValue = resolvedItems.any(
      (DropdownMenuItem<T> item) => item.value == value,
    );
    final TextStyle resolvedTextStyle =
        theme.textTheme.bodyLarge ??
        JTextStyles.body1.copyWith(color: theme.colorScheme.onSurface);

    return DropdownButtonFormField<T>(
      initialValue: hasMatchingValue ? value : null,
      items: resolvedItems,
      onChanged: enabled && resolvedItems.isNotEmpty ? onChanged : null,
      style: resolvedTextStyle,
      iconEnabledColor: tokens.mutedText,
      iconDisabledColor: theme.disabledColor,
      decoration: _buildDecoration(theme, tokens),
    );
  }

  InputDecoration _buildDecoration(ThemeData theme, AppThemeTokens tokens) {
    final InputDecoration themedDecoration = InputDecoration(
      labelText: labelText,
      hintText: hintText,
      helperText: helperText,
      errorText: errorText,
      enabled: enabled,
    ).applyDefaults(theme.inputDecorationTheme);

    return themedDecoration.copyWith(
      filled: themedDecoration.filled ?? true,
      fillColor: tokens.inputBackground,
      contentPadding:
          themedDecoration.contentPadding ?? JInsets.horizontal16Vertical12,
      constraints:
          themedDecoration.constraints ??
          const BoxConstraints(minHeight: JHeights.input),
      border: _buildBorder(color: tokens.inputBorderColor),
      enabledBorder: _buildBorder(color: tokens.inputBorderColor),
      focusedBorder: _buildBorder(
        color: theme.colorScheme.primary,
        width: JDimens.dp1_5,
      ),
      disabledBorder: _buildBorder(color: tokens.dividerColor),
      errorBorder: _buildBorder(color: theme.colorScheme.error),
      focusedErrorBorder: _buildBorder(
        color: theme.colorScheme.error,
        width: JDimens.dp1_5,
      ),
      hintStyle:
          (themedDecoration.hintStyle ??
                  theme.textTheme.bodyMedium ??
                  JTextStyles.body2)
              .copyWith(color: tokens.mutedText),
      labelStyle:
          (themedDecoration.labelStyle ??
                  theme.textTheme.bodyMedium ??
                  JTextStyles.body2)
              .copyWith(color: tokens.mutedText),
      helperStyle:
          (themedDecoration.helperStyle ??
                  theme.textTheme.labelSmall ??
                  JTextStyles.label)
              .copyWith(color: tokens.mutedText),
      errorStyle:
          (themedDecoration.errorStyle ??
                  theme.textTheme.labelSmall ??
                  JTextStyles.label)
              .copyWith(color: theme.colorScheme.error),
    );
  }

  OutlineInputBorder _buildBorder({
    required Color color,
    double width = JDimens.dp1,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(JDimens.dp12),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
