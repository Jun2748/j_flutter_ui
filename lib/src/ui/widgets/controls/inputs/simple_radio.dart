import 'package:flutter/material.dart';

import '../../../resources/dimens.dart';
import '../../typography/simple_text.dart';

class SimpleRadio<T> extends StatelessWidget {
  const SimpleRadio({
    super.key,
    required this.value,
    required this.groupValue,
    this.onChanged,
    this.label,
  });

  final T? value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final Widget radio = value == null
        ? const Icon(Icons.radio_button_unchecked)
        : RadioGroup<T>(
            groupValue: groupValue,
            onChanged: onChanged ?? (_) {},
            child: Radio<T>(value: value as T, enabled: onChanged != null),
          );

    if (label == null || label!.trim().isEmpty) {
      return radio;
    }

    return InkWell(
      borderRadius: BorderRadius.circular(JDimens.dp8),
      onTap: onChanged == null || value == null
          ? null
          : () => onChanged?.call(value),
      child: Padding(
        padding: JInsets.vertical4,
        child: Row(
          children: <Widget>[
            radio,
            Expanded(child: SimpleText.body(text: label!)),
          ],
        ),
      ),
    );
  }
}
