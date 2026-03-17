import 'package:flutter/material.dart';

import '../../resources/app_theme_tokens.dart';
import '../../resources/dimens.dart';
import '../typography/simple_text.dart';

class FormFieldWrapper extends StatelessWidget {
  const FormFieldWrapper({
    super.key,
    this.label,
    this.labelWidget,
    this.helperText,
    this.helper,
    this.errorText,
    this.required = false,
    required this.child,
    this.margin,
  });

  final String? label;
  final Widget? labelWidget;
  final String? helperText;
  final Widget? helper;
  final String? errorText;
  final bool required;
  final Widget child;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppThemeTokens tokens = AppThemeTokens.resolve(theme);
    final bool hasTextLabel = label != null && label!.trim().isNotEmpty;
    final Widget? resolvedLabel =
        labelWidget ??
        (hasTextLabel
            ? SimpleText.label(text: label!, weight: FontWeight.w600)
            : null);
    final bool hasError = errorText != null && errorText!.trim().isNotEmpty;
    final bool hasHelperWidget = helper != null && !hasError;
    final bool hasHelperText =
        helperText != null && helperText!.trim().isNotEmpty && !hasError;

    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (resolvedLabel != null) ...<Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(child: resolvedLabel),
              if (required) ...<Widget>[
                JGaps.w4,
                SimpleText.label(
                  text: '*',
                  color: theme.colorScheme.error,
                  weight: FontWeight.w700,
                ),
              ],
            ],
          ),
          JGaps.h8,
        ],
        child,
        if (hasHelperWidget) ...<Widget>[
          JGaps.h8,
          helper!,
        ] else if (hasHelperText) ...<Widget>[
          JGaps.h8,
          SimpleText.caption(
            text: helperText!,
            color: tokens.mutedText,
          ),
        ],
        if (hasError) ...<Widget>[
          JGaps.h8,
          SimpleText.caption(text: errorText!, color: theme.colorScheme.error),
        ],
      ],
    );

    if (margin != null) {
      content = Padding(padding: margin!, child: content);
    }

    return content;
  }
}
