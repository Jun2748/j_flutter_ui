import 'package:flutter/material.dart';

import '../../resources/app_theme_tokens.dart';
import '../../resources/dimens.dart';
import '../typography/simple_text.dart';

/// Original price with strikethrough beside a current (discounted) price.
///
/// Token defaults: original price uses [AppThemeTokens.mutedText],
/// current price uses [AppThemeTokens.primary] with bold weight.
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
  });

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

  /// Gap between the two price texts. Defaults to `JDimens.dp8`.
  final double? gap;

  @override
  Widget build(BuildContext context) {
    final AppThemeTokens tokens = Theme.of(context).appThemeTokens;

    final Color resolvedOriginalColor = originalPriceColor ?? tokens.mutedText;
    final Color resolvedCurrentColor = currentPriceColor ?? tokens.primary;
    final double resolvedGap = gap ?? JDimens.dp8;

    // Strikethrough applied by merging a decoration into the base style.
    final TextStyle strikeStyle = (style ?? const TextStyle()).copyWith(
      decoration: TextDecoration.lineThrough,
      decorationColor: resolvedOriginalColor,
    );

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        SimpleText.body(
          text: originalPrice,
          color: resolvedOriginalColor,
          style: strikeStyle,
          maxLines: 2,
        ),

        SizedBox(width: resolvedGap),
        SimpleText.body(
          text: currentPrice,
          color: resolvedCurrentColor,
          weight: currentPriceWeight ?? FontWeight.w700,
          style: style,
          maxLines: 2,
        ),
      ],
    );
  }
}
