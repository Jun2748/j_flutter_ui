import 'package:flutter/material.dart';

import '../../resources/app_theme_tokens.dart';
import '../../resources/dimens.dart';
import '../../resources/styles.dart';

/// Read-only star rating display with optional review count.
///
/// Supports full and half stars. Pass [reviewCount] to render
/// a "(n)" count label beside the stars.
///
/// Token defaults: [filledColor] → `tokens.primary`,
/// [emptyColor] → `tokens.cardBorderColor`,
/// [ratingCountColor] → `tokens.mutedText`.
class SimpleRatingBar extends StatelessWidget {
  const SimpleRatingBar({
    super.key,
    required this.rating,
    this.starCount = 5,
    this.reviewCount,
    this.starSize,
    this.filledColor,
    this.emptyColor,
    this.ratingCountColor,
    this.gap,
  });

  /// Numeric rating value, clamped to 0.0–[starCount].
  final double rating;

  /// Total number of stars displayed. Defaults to `5`.
  final int starCount;

  /// Optional review count shown as "(n)" beside the stars.
  final int? reviewCount;

  /// Star icon size. Defaults to `JIconSizes.sm` (16 dp).
  final double? starSize;

  /// Filled star color. Defaults to `tokens.primary`.
  final Color? filledColor;

  /// Empty star color. Defaults to `tokens.cardBorderColor`.
  final Color? emptyColor;

  /// Review count text color. Defaults to `tokens.mutedText`.
  final Color? ratingCountColor;

  /// Gap between stars, and between the star row and count label.
  /// Defaults to `JDimens.dp4`.
  final double? gap;

  @override
  Widget build(BuildContext context) {
    final AppThemeTokens tokens = Theme.of(context).appThemeTokens;

    final Color resolvedFilled = filledColor ?? tokens.primary;
    final Color resolvedEmpty = emptyColor ?? tokens.cardBorderColor;
    final Color resolvedCountColor = ratingCountColor ?? tokens.mutedText;
    final double resolvedSize = starSize ?? JIconSizes.sm;
    final double resolvedGap = gap ?? JDimens.dp4;

    final double clampedRating = rating.clamp(0.0, starCount.toDouble());
    final int? count = reviewCount;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        for (int i = 0; i < starCount; i++) ...<Widget>[
          if (i > 0) SizedBox(width: resolvedGap),
          _buildStar(
            index: i,
            rating: clampedRating,
            filledColor: resolvedFilled,
            emptyColor: resolvedEmpty,
            size: resolvedSize,
          ),
        ],
        if (count != null) ...<Widget>[
          SizedBox(width: resolvedGap),
          Text(
            '($count)',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: JTextStyles.label.copyWith(color: resolvedCountColor),
          ),
        ],
      ],
    );
  }

  Widget _buildStar({
    required int index,
    required double rating,
    required Color filledColor,
    required Color emptyColor,
    required double size,
  }) {
    final double fraction = rating - index;

    final IconData iconData;
    final Color color;

    if (fraction >= 1.0) {
      iconData = Icons.star;
      color = filledColor;
    } else if (fraction >= 0.5) {
      iconData = Icons.star_half;
      color = filledColor;
    } else {
      iconData = Icons.star_border;
      color = emptyColor;
    }

    return Icon(iconData, size: size, color: color);
  }
}
