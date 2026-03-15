import 'package:flutter/material.dart';

import '../../../resources/colors.dart';
import '../../layout/gap.dart';
import '../../typography/simple_text.dart';

class SimpleSwitch extends StatelessWidget {
  const SimpleSwitch({
    super.key,
    required this.value,
    this.onChanged,
    this.label,
    this.description,
  });

  final bool? value;
  final ValueChanged<bool>? onChanged;
  final String? label;
  final String? description;

  @override
  Widget build(BuildContext context) {
    final bool resolvedValue = value ?? false;
    final bool interactive = onChanged != null;
    final Color primary = JColors.getColor(context, lightKey: 'primary');
    final Color card = JColors.getColor(context, lightKey: 'card');
    final Color border = JColors.getColor(context, lightKey: 'border');
    final Color disabled = JColors.getColor(context, lightKey: 'textDisabled');
    final Color trackOff = JColors.getColor(context, lightKey: 'surface');

    final Widget switchWidget = Switch(
      value: resolvedValue,
      onChanged: onChanged,
      thumbColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return disabled;
        }
        if (states.contains(WidgetState.selected)) {
          return JColors.white;
        }
        return card;
      }),
      trackColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return trackOff.withAlpha(160);
        }
        if (states.contains(WidgetState.selected)) {
          return primary.withAlpha(180);
        }
        return trackOff;
      }),
      trackOutlineColor: WidgetStateProperty.resolveWith((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.disabled)) {
          return disabled.withAlpha(120);
        }
        if (states.contains(WidgetState.selected)) {
          return primary;
        }
        return border;
      }),
      trackOutlineWidth: const WidgetStatePropertyAll<double>(1.2),
    );

    if ((label == null || label!.trim().isEmpty) &&
        (description == null || description!.trim().isEmpty)) {
      return switchWidget;
    }

    return InkWell(
      onTap: interactive ? () => onChanged?.call(!resolvedValue) : null,
      borderRadius: BorderRadius.circular(12),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (label != null && label!.trim().isNotEmpty)
                  SimpleText.body(text: label!),
                if (description != null &&
                    description!.trim().isNotEmpty) ...<Widget>[
                  Gap.h8,
                  SimpleText.caption(
                    text: description!,
                    color: JColors.getColor(context, lightKey: 'textSecondary'),
                  ),
                ],
              ],
            ),
          ),
          Gap.w16,
          switchWidget,
        ],
      ),
    );
  }
}
