import 'package:flutter/material.dart';

import '../../../resources/app_theme_tokens.dart';
import '../../../resources/dimens.dart';
import '../../typography/simple_text.dart';

class SimpleSwitch extends StatelessWidget {
  const SimpleSwitch({
    super.key,
    required this.value,
    this.onChanged,
    this.label,
    this.labelWidget,
    this.description,
  });

  final bool? value;
  final ValueChanged<bool>? onChanged;
  final String? label;
  final Widget? labelWidget;
  final String? description;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppThemeTokens tokens = AppThemeTokens.resolve(theme);
    final bool resolvedValue = value ?? false;
    final bool interactive = onChanged != null;
    final Color primary = tokens.primary;
    final Color thumbOff = tokens.cardBackground;
    final Color border = tokens.inputBorderColor;
    final Color disabled = theme.disabledColor;
    final Color trackOff = tokens.inputBackground;

    final Widget switchWidget = Switch(
      value: resolvedValue,
      onChanged: onChanged,
      thumbColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return disabled;
        }
        if (states.contains(WidgetState.selected)) {
          return theme.colorScheme.onPrimary;
        }
        return thumbOff;
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

    if (labelWidget == null &&
        (label == null || label!.trim().isEmpty) &&
        (description == null || description!.trim().isEmpty)) {
      return switchWidget;
    }

    return InkWell(
      onTap: interactive ? () => onChanged?.call(!resolvedValue) : null,
      borderRadius: BorderRadius.circular(JDimens.dp12),
      child: Row(
        children: <Widget>[
          Expanded(child: labelWidget ?? _buildTextContent(context)),
          JGaps.w16,
          switchWidget,
        ],
      ),
    );
  }

  Widget _buildTextContent(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppThemeTokens tokens = AppThemeTokens.resolve(theme);
    final Color descriptionColor = tokens.mutedText;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (label != null && label!.trim().isNotEmpty)
          SimpleText.body(text: label!),
        if (description != null && description!.trim().isNotEmpty) ...<Widget>[
          JGaps.h8,
          SimpleText.caption(text: description!, color: descriptionColor),
        ],
      ],
    );
  }
}
