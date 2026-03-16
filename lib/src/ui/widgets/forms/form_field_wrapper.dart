import 'package:flutter/material.dart';

import '../../resources/colors.dart';
import '../../resources/dimens.dart';
import '../layout/gap.dart';
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
                const SizedBox(width: JDimens.dp4),
                SimpleText.label(
                  text: '*',
                  color: JColors.getColor(context, lightKey: 'error'),
                  weight: FontWeight.w700,
                ),
              ],
            ],
          ),
          Gap.h8,
        ],
        child,
        if (hasHelperWidget) ...<Widget>[
          Gap.h8,
          helper!,
        ] else if (hasHelperText) ...<Widget>[
          Gap.h8,
          SimpleText.caption(
            text: helperText!,
            color: JColors.getColor(context, lightKey: 'textSecondary'),
          ),
        ],
        if (hasError) ...<Widget>[
          Gap.h8,
          SimpleText.caption(
            text: errorText!,
            color: JColors.getColor(context, lightKey: 'error'),
          ),
        ],
      ],
    );

    if (margin != null) {
      content = Padding(padding: margin!, child: content);
    }

    return content;
  }
}
