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
    this.weight,
    this.maxLines = 10,
  }) : _variant = variant;

  const SimpleText.title({
    Key? key,
    required String? text,
    Color? color,
    TextAlign? align,
    FontWeight? weight,
    int? maxLines,
  }) : this._(
         key: key,
         text: text,
         variant: _SimpleTextVariant.title,
         color: color,
         align: align,
         weight: weight,
         maxLines: maxLines,
       );

  const SimpleText.heading({
    Key? key,
    required String? text,
    Color? color,
    TextAlign? align,
    FontWeight? weight,
    int? maxLines,
  }) : this._(
         key: key,
         text: text,
         variant: _SimpleTextVariant.heading,
         color: color,
         align: align,
         weight: weight,
         maxLines: maxLines,
       );

  const SimpleText.body({
    Key? key,
    required String? text,
    Color? color,
    TextAlign? align,
    FontWeight? weight,
    int? maxLines,
  }) : this._(
         key: key,
         text: text,
         variant: _SimpleTextVariant.body,
         color: color,
         align: align,
         weight: weight,
         maxLines: maxLines,
       );

  const SimpleText.caption({
    Key? key,
    required String? text,
    Color? color,
    TextAlign? align,
    FontWeight? weight,
    int? maxLines,
  }) : this._(
         key: key,
         text: text,
         variant: _SimpleTextVariant.caption,
         color: color,
         align: align,
         weight: weight,
         maxLines: maxLines,
       );

  const SimpleText.label({
    Key? key,
    required String? text,
    Color? color,
    TextAlign? align,
    FontWeight? weight,
    int? maxLines,
  }) : this._(
         key: key,
         text: text,
         variant: _SimpleTextVariant.label,
         color: color,
         align: align,
         weight: weight,
         maxLines: maxLines,
       );

  final String? text;
  final Color? color;
  final TextAlign? align;
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
      style: _resolveStyle().copyWith(color: color, fontWeight: weight),
    );
  }

  TextStyle _resolveStyle() {
    switch (_variant) {
      case _SimpleTextVariant.title:
        return JTextStyles.title1;
      case _SimpleTextVariant.heading:
        return JTextStyles.heading1;
      case _SimpleTextVariant.body:
        return JTextStyles.body1;
      case _SimpleTextVariant.caption:
        return JTextStyles.body2;
      case _SimpleTextVariant.label:
        return JTextStyles.label;
    }
  }
}
