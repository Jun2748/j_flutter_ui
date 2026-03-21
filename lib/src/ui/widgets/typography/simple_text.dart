import 'package:flutter/material.dart';

import '../../resources/app_theme_tokens.dart';
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
    this.overflow,
    this.fontSize,
    this.maxLines,
  }) : _variant = variant;

  const SimpleText.title({
    Key? key,
    required String? text,
    Color? color,
    TextAlign? align,
    TextStyle? style,
    FontWeight? weight,
    TextOverflow? overflow,
    double? fontSize,
    int? maxLines,
  }) : this._(
         key: key,
         text: text,
         variant: _SimpleTextVariant.title,
         color: color,
         align: align,
         style: style,
         weight: weight,
         overflow: overflow,
         fontSize: fontSize,
         maxLines: maxLines,
       );

  const SimpleText.heading({
    Key? key,
    required String? text,
    Color? color,
    TextAlign? align,
    TextStyle? style,
    FontWeight? weight,
    TextOverflow? overflow,
    double? fontSize,
    int? maxLines,
  }) : this._(
         key: key,
         text: text,
         variant: _SimpleTextVariant.heading,
         color: color,
         align: align,
         style: style,
         weight: weight,
         overflow: overflow,
         fontSize: fontSize,
         maxLines: maxLines,
       );

  const SimpleText.body({
    Key? key,
    required String? text,
    Color? color,
    TextAlign? align,
    TextStyle? style,
    FontWeight? weight,
    TextOverflow? overflow,
    double? fontSize,
    int? maxLines,
  }) : this._(
         key: key,
         text: text,
         variant: _SimpleTextVariant.body,
         color: color,
         align: align,
         style: style,
         weight: weight,
         overflow: overflow,
         fontSize: fontSize,
         maxLines: maxLines,
       );

  const SimpleText.caption({
    Key? key,
    required String? text,
    Color? color,
    TextAlign? align,
    TextStyle? style,
    FontWeight? weight,
    TextOverflow? overflow,
    double? fontSize,
    int? maxLines,
  }) : this._(
         key: key,
         text: text,
         variant: _SimpleTextVariant.caption,
         color: color,
         align: align,
         style: style,
         weight: weight,
         overflow: overflow,
         fontSize: fontSize,
         maxLines: maxLines,
       );

  const SimpleText.label({
    Key? key,
    required String? text,
    Color? color,
    TextAlign? align,
    TextStyle? style,
    FontWeight? weight,
    TextOverflow? overflow,
    double? fontSize,
    int? maxLines,
  }) : this._(
         key: key,
         text: text,
         variant: _SimpleTextVariant.label,
         color: color,
         align: align,
         style: style,
         weight: weight,
         overflow: overflow,
         fontSize: fontSize,
         maxLines: maxLines,
       );

  const SimpleText.priceLarge({
    super.key,
    required this.text,
    this.color,
    this.maxLines,
    this.overflow,
    this.align,
    this.fontSize,
  }) : style = JTextStyles.priceLarge,
       weight = FontWeight.w700,
       _variant = _SimpleTextVariant.body;

  const SimpleText.sectionLabel({
    super.key,
    required this.text,
    this.color,
    this.maxLines,
    this.overflow,
    this.fontSize,
  }) : style = JTextStyles.label,
       weight = FontWeight.w700,
       align = null,
       _variant = _SimpleTextVariant.label;

  const SimpleText.counter({
    super.key,
    required this.text,
    this.color,
    this.maxLines,
    this.fontSize,
  }) : style = JTextStyles.heading1,
       weight = FontWeight.w700,
       align = TextAlign.center,
       overflow = TextOverflow.clip,
       _variant = _SimpleTextVariant.heading;

  final String? text;
  final Color? color;
  final TextAlign? align;
  final TextStyle? style;
  final FontWeight? weight;
  final TextOverflow? overflow;
  final double? fontSize;
  final int? maxLines;
  final _SimpleTextVariant _variant;

  @override
  Widget build(BuildContext context) {
    TextStyle resolvedStyle = _resolveStyle(
      context,
    ).merge(style).copyWith(color: color, fontWeight: weight);
    if (fontSize != null) {
      resolvedStyle = resolvedStyle.copyWith(fontSize: fontSize);
    }

    return Text(
      text ?? '',
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow ?? (maxLines == null ? null : TextOverflow.ellipsis),
      style: resolvedStyle,
    );
  }

  TextStyle _resolveStyle(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppThemeTokens tokens = theme.appThemeTokens;
    final Color primaryTextColor = theme.colorScheme.onSurface;
    final Color secondaryTextColor = tokens.mutedText;

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
