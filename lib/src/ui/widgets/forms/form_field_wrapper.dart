import 'package:flutter/material.dart';

import '../../resources/colors.dart';
import '../../resources/dimens.dart';
import '../layout/gap.dart';
import '../typography/simple_text.dart';

class FormFieldWrapper extends StatelessWidget {
  const FormFieldWrapper({
    super.key,
    this.label,
    this.helperText,
    this.errorText,
    this.required = false,
    required this.child,
    this.margin,
  });

  final String? label;
  final String? helperText;
  final String? errorText;
  final bool required;
  final Widget child;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    final bool hasLabel = label != null && label!.trim().isNotEmpty;
    final bool hasError = errorText != null && errorText!.trim().isNotEmpty;
    final bool hasHelper =
        helperText != null && helperText!.trim().isNotEmpty && !hasError;

    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (hasLabel) ...<Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                child: SimpleText.label(text: label!, weight: FontWeight.w600),
              ),
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
        if (hasHelper) ...<Widget>[
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
