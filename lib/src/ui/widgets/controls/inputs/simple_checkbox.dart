import 'package:flutter/material.dart';

import '../../../resources/app_theme_tokens.dart';
import '../../../resources/dimens.dart';
import '../../../resources/styles.dart';

class SimpleCheckbox extends StatelessWidget {
  const SimpleCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.label,
    this.labelWidget,
    this.textStyle,
    this.enabled = true,
  });

  final bool? value;
  final ValueChanged<bool?>? onChanged;
  final String? label;
  final Widget? labelWidget;
  final TextStyle? textStyle;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppThemeTokens tokens = theme.appThemeTokens;
    final bool resolvedValue = value ?? false;
    final bool interactive = enabled && onChanged != null;

    final Widget checkbox = Checkbox(
      value: resolvedValue,
      onChanged: interactive ? onChanged : null,
      fillColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return theme.disabledColor.withAlpha(140);
        }
        if (states.contains(WidgetState.selected)) {
          return tokens.primary;
        }
        return Colors.transparent;
      }),
      checkColor: tokens.onPrimaryResolved(theme),
      side: BorderSide(color: tokens.inputBorderColor),
    );

    final bool hasTextLabel = label != null && label!.trim().isNotEmpty;
    final TextStyle baseTextStyle =
        theme.textTheme.bodyMedium ?? JTextStyles.body2;
    final Widget? resolvedLabel =
        labelWidget ??
        (hasTextLabel
            ? Text(
                label!,
                style: baseTextStyle
                    .merge(textStyle)
                    .copyWith(
                      color: enabled
                          ? textStyle?.color ??
                                baseTextStyle.color ??
                                theme.colorScheme.onSurface
                          : theme.disabledColor,
                    ),
              )
            : null);

    if (resolvedLabel == null) {
      return checkbox;
    }

    return InkWell(
      borderRadius: BorderRadius.circular(JDimens.dp8),
      onTap: interactive ? () => onChanged?.call(!resolvedValue) : null,
      child: Padding(
        padding: JInsets.vertical4,
        child: Row(
          children: <Widget>[
            checkbox,
            Expanded(child: resolvedLabel),
          ],
        ),
      ),
    );
  }
}
