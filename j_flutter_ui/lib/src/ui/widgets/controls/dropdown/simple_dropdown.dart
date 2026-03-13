import 'package:flutter/material.dart';

import '../../../resources/colors.dart';
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
    this.enabled = true,
  });

  final T? value;
  final List<DropdownMenuItem<T>>? items;
  final ValueChanged<T?>? onChanged;
  final String? hintText;
  final String? labelText;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuItem<T>> resolvedItems =
        items ?? List<DropdownMenuItem<T>>.empty();
    final bool hasMatchingValue = resolvedItems.any(
      (DropdownMenuItem<T> item) => item.value == value,
    );
    final Color border = JColors.getColor(context, lightKey: 'border');
    final Color textPrimary = JColors.getColor(
      context,
      lightKey: 'textPrimary',
    );
    final Color textSecondary = JColors.getColor(
      context,
      lightKey: 'textSecondary',
    );
    final OutlineInputBorder inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(JDimens.dp12),
      borderSide: BorderSide(color: border),
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
        enabled: enabled,
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder.copyWith(
          borderSide: BorderSide(
            color: JColors.getColor(context, lightKey: 'primary'),
            width: 1.4,
          ),
        ),
      ),
    );
  }
}
