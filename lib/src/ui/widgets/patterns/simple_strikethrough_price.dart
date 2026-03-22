import 'package:flutter/material.dart';

import '../../resources/app_theme_tokens.dart';
import '../../resources/dimens.dart';
import '../typography/simple_text.dart';

/// Original price with strikethrough beside a current (discounted) price.
///
/// Token defaults: original price uses [AppThemeTokens.mutedText],
/// current price uses [AppThemeTokens.primary] with bold weight.
///
/// The default constructor renders prices side-by-side in a [Row] with
/// baseline alignment. Use [SimpleStrikethroughPrice.stacked] for tight
/// vertical product cards where prices sit on separate lines.
class SimpleStrikethroughPrice extends StatelessWidget {
  const SimpleStrikethroughPrice({
    super.key,
    required this.originalPrice,
    required this.currentPrice,
    this.originalPriceColor,
    this.currentPriceColor,
    this.currentPriceWeight,
    this.style,
    this.gap,
  }) : _direction = Axis.horizontal;

  /// Vertical variant — original price on top, current price below.
  ///
  /// Use in tight vertical product cards where horizontal space is limited.
  /// Gap defaults to [JDimens.dp2] for tighter line spacing.
  const SimpleStrikethroughPrice.stacked({
    super.key,
    required this.originalPrice,
    required this.currentPrice,
    this.originalPriceColor,
    this.currentPriceColor,
    this.currentPriceWeight,
    this.style,
    this.gap,
  }) : _direction = Axis.vertical;

  /// Struck-through price string (e.g. "RM 18.90").
  final String originalPrice;

  /// Active price string (e.g. "RM 14.90").
  final String currentPrice;

  /// Color for the struck-through text. Defaults to `tokens.mutedText`.
  final Color? originalPriceColor;

  /// Color for the current price text. Defaults to `tokens.primary`.
  final Color? currentPriceColor;

  /// Font weight for the current price. Defaults to `FontWeight.w700`.
  final FontWeight? currentPriceWeight;

  /// Base [TextStyle] merged into both price texts. Useful for size overrides.
  final TextStyle? style;

  /// Gap between the two price texts. Defaults to [JDimens.dp8] for
  /// horizontal layout, [JDimens.dp2] for stacked.
  final double? gap;

  final Axis _direction;

  @override
  Widget build(BuildContext context) {
    final AppThemeTokens tokens = Theme.of(context).appThemeTokens;

    final Color resolvedOriginalColor = originalPriceColor ?? tokens.mutedText;
    final Color resolvedCurrentColor = currentPriceColor ?? tokens.primary;

    final TextStyle strikeStyle = (style ?? const TextStyle()).copyWith(
      decoration: TextDecoration.lineThrough,
      decorationColor: resolvedOriginalColor,
    );

    final Widget originalWidget = SimpleText.body(
      text: originalPrice,
      color: resolvedOriginalColor,
      style: strikeStyle,
      maxLines: 1,
    );

    final Widget currentWidget = SimpleText.body(
      text: currentPrice,
      color: resolvedCurrentColor,
      weight: currentPriceWeight ?? FontWeight.w700,
      style: style,
      maxLines: 1,
    );

    return _direction == Axis.horizontal
        ? _buildRow(originalWidget, currentWidget)
        : _buildColumn(originalWidget, currentWidget);
  }

  Widget _buildRow(Widget original, Widget current) {
    final double resolvedGap = gap ?? JDimens.dp8;

    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        Flexible(child: original),
        SizedBox(width: resolvedGap),
        Flexible(child: current),
      ],
    );
  }

  Widget _buildColumn(Widget original, Widget current) {
    final double resolvedGap = gap ?? JDimens.dp2;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        original,
        SizedBox(height: resolvedGap),
        current,
      ],
    );
  }
}
