import 'package:flutter/material.dart';

import '../../../resources/dimens.dart';
import '../../../resources/styles.dart';
import '../../typography/simple_text.dart';

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
    final List<DropdownMenuItem<T>> resolvedItems =
        items ?? List<DropdownMenuItem<T>>.empty();
    final bool hasMatchingValue = resolvedItems.any(
      (DropdownMenuItem<T> item) => item.value == value,
    );
    final Color border = theme.colorScheme.outline;
    final Color textPrimary =
        theme.textTheme.bodyLarge?.color ?? theme.colorScheme.onSurface;
    final Color textSecondary =
        theme.textTheme.bodyMedium?.color ?? theme.colorScheme.onSurfaceVariant;
    final OutlineInputBorder inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(JDimens.dp12),
      borderSide: BorderSide(color: border, width: JDimens.dp1),
    );

    return DropdownButtonFormField<T>(
      initialValue: hasMatchingValue ? value : null,
      items: resolvedItems,
      onChanged: enabled && resolvedItems.isNotEmpty ? onChanged : null,
      style: JTextStyles.body2.copyWith(color: textPrimary),
      hint: hintText == null
          ? null
          : SimpleText.caption(text: hintText!, color: textSecondary),
      decoration: InputDecoration(
        labelText: labelText,
        helperText: helperText,
        errorText: errorText,
        enabled: enabled,
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder.copyWith(
          borderSide: BorderSide(
            color: theme.colorScheme.primary,
            width: JDimens.dp1_5,
          ),
        ),
      ),
    );
  }
}
