import 'package:flutter/material.dart';

import '../../../resources/app_theme_tokens.dart';
import '../../../resources/input_decorations.dart';
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
    final AppThemeTokens tokens = theme.appThemeTokens;
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
      decoration: JInputDecorations.dropdown(
        theme,
        tokens: tokens,
        labelText: labelText,
        hintText: hintText,
        helperText: helperText,
        errorText: errorText,
        enabled: enabled,
      ),
    );
  }
}
