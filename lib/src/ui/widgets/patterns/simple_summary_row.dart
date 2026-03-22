import 'package:flutter/material.dart';

import '../../resources/app_theme_tokens.dart';
import '../../resources/dimens.dart';
import '../typography/simple_text.dart';

/// Label-left + value-right row for order summaries, receipts, and info lists.
///
/// Override [labelWeight] / [valueWeight] and [valueColor] to create
/// an emphasized "Total" variant.
class SimpleSummaryRow extends StatelessWidget {
  const SimpleSummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.labelColor,
    this.valueColor,
    this.labelWeight,
    this.valueWeight,
    this.padding,
  });

  /// Left-side text (e.g. "Subtotal", "Tax (6%)").
  final String label;

  /// Right-side text (e.g. "RM 16.90").
  final String value;

  /// Label text color. Defaults to `tokens.mutedText`.
  final Color? labelColor;

  /// Value text color. Defaults to `tokens.mutedText`.
  final Color? valueColor;

  /// Label font weight override for emphasis.
  final FontWeight? labelWeight;

  /// Value font weight override for emphasis.
  final FontWeight? valueWeight;

  /// Row padding. Defaults to `JInsets.vertical12`.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final AppThemeTokens tokens = Theme.of(context).appThemeTokens;

    final Color resolvedLabelColor = labelColor ?? tokens.mutedText;
    final Color resolvedValueColor = valueColor ?? tokens.mutedText;
    final EdgeInsetsGeometry resolvedPadding = padding ?? JInsets.vertical12;

    return Padding(
      padding: resolvedPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: SimpleText.body(
              text: label,
              color: resolvedLabelColor,
              weight: labelWeight,
              maxLines: 1,
            ),
          ),
          JGaps.w16,
          SimpleText.body(
            text: value,
            color: resolvedValueColor,
            weight: valueWeight,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
