import 'package:flutter/material.dart';

import '../../resources/styles.dart';

enum _SimpleTextVariant { title, heading, body, caption, label }

class SimpleText extends StatelessWidget {
  const SimpleText._({
    super.key,
    required this.text,
    required _SimpleTextVariant variant,
    this.color,
    this.align,
    this.style,
    this.weight,
    this.maxLines,
  }) : _variant = variant;

  const SimpleText.title({
    Key? key,
    required String? text,
    Color? color,
    TextAlign? align,
    TextStyle? style,
    FontWeight? weight,
    int? maxLines,
  }) : this._(
         key: key,
         text: text,
         variant: _SimpleTextVariant.title,
         color: color,
         align: align,
         style: style,
         weight: weight,
         maxLines: maxLines,
       );

  const SimpleText.heading({
    Key? key,
    required String? text,
    Color? color,
    TextAlign? align,
    TextStyle? style,
    FontWeight? weight,
    int? maxLines,
  }) : this._(
         key: key,
         text: text,
         variant: _SimpleTextVariant.heading,
         color: color,
         align: align,
         style: style,
         weight: weight,
         maxLines: maxLines,
       );

  const SimpleText.body({
    Key? key,
    required String? text,
    Color? color,
    TextAlign? align,
    TextStyle? style,
    FontWeight? weight,
    int? maxLines,
  }) : this._(
         key: key,
         text: text,
         variant: _SimpleTextVariant.body,
         color: color,
         align: align,
         style: style,
         weight: weight,
         maxLines: maxLines,
       );

  const SimpleText.caption({
    Key? key,
    required String? text,
    Color? color,
    TextAlign? align,
    TextStyle? style,
    FontWeight? weight,
    int? maxLines,
  }) : this._(
         key: key,
         text: text,
         variant: _SimpleTextVariant.caption,
         color: color,
         align: align,
         style: style,
         weight: weight,
         maxLines: maxLines,
       );

  const SimpleText.label({
    Key? key,
    required String? text,
    Color? color,
    TextAlign? align,
    TextStyle? style,
    FontWeight? weight,
    int? maxLines,
  }) : this._(
         key: key,
         text: text,
         variant: _SimpleTextVariant.label,
         color: color,
         align: align,
         style: style,
         weight: weight,
         maxLines: maxLines,
       );

  final String? text;
  final Color? color;
  final TextAlign? align;
  final TextStyle? style;
  final FontWeight? weight;
  final int? maxLines;
  final _SimpleTextVariant _variant;

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      textAlign: align,
      maxLines: maxLines,
      overflow: maxLines == null ? null : TextOverflow.ellipsis,
      style: _resolveStyle(
        context,
      ).merge(style).copyWith(color: color, fontWeight: weight),
    );
  }

  TextStyle _resolveStyle(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color primaryTextColor = theme.colorScheme.onSurface;
    final Color secondaryTextColor = theme.colorScheme.onSurfaceVariant;

    switch (_variant) {
      case _SimpleTextVariant.title:
        return _withFallbackColor(
          theme.textTheme.displayLarge ?? JTextStyles.title1,
          primaryTextColor,
        );
      case _SimpleTextVariant.heading:
        return _withFallbackColor(
          theme.textTheme.headlineLarge ?? JTextStyles.heading1,
          primaryTextColor,
        );
      case _SimpleTextVariant.body:
        return _withFallbackColor(
          theme.textTheme.bodyLarge ?? JTextStyles.body1,
          primaryTextColor,
        );
      case _SimpleTextVariant.caption:
        return _withFallbackColor(
          theme.textTheme.bodyMedium ?? JTextStyles.body2,
          secondaryTextColor,
        );
      case _SimpleTextVariant.label:
        return _withFallbackColor(
          theme.textTheme.labelSmall ?? JTextStyles.label,
          secondaryTextColor,
        );
    }
  }

  TextStyle _withFallbackColor(TextStyle style, Color fallbackColor) {
    return style.color == null ? style.copyWith(color: fallbackColor) : style;
  }
}
