import 'package:flutter/material.dart';

import '../../resources/app_theme_tokens.dart';
import '../../resources/dimens.dart';

const Duration _kDotAnimationDuration = Duration(milliseconds: 250);

/// Horizontal dot-strip page indicator for [PageView] carousels.
///
/// The active dot stretches into a pill via [AnimatedContainer].
/// Inactive dots are circles.
///
/// Token defaults: [activeColor] → `tokens.primary`,
/// [inactiveColor] → `tokens.cardBorderColor`.
class SimplePageIndicator extends StatelessWidget {
  const SimplePageIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
    this.activeColor,
    this.inactiveColor,
    this.dotSize,
    this.activeDotWidth,
    this.dotSpacing,
  });

  /// Total number of pages (dots).
  final int count;

  /// Zero-based index of the active page. Clamped to valid range.
  final int currentIndex;

  /// Active dot color. Defaults to `tokens.primary`.
  final Color? activeColor;

  /// Inactive dot color. Defaults to `tokens.cardBorderColor`.
  final Color? inactiveColor;

  /// Diameter of each dot. Defaults to `JDimens.dp8`.
  final double? dotSize;

  /// Width of the active (pill) dot. Defaults to `JDimens.dp20`.
  final double? activeDotWidth;

  /// Gap between dots. Defaults to `JDimens.dp6`.
  final double? dotSpacing;

  @override
  Widget build(BuildContext context) {
    if (count <= 0) {
      return const SizedBox.shrink();
    }

    final AppThemeTokens tokens = Theme.of(context).appThemeTokens;

    final Color resolvedActive = activeColor ?? tokens.primary;
    final Color resolvedInactive = inactiveColor ?? tokens.cardBorderColor;
    final double resolvedDot = dotSize ?? JDimens.dp8;
    final double resolvedActiveDotWidth = activeDotWidth ?? JDimens.dp20;
    final double resolvedSpacing = dotSpacing ?? JDimens.dp6;

    final int safeIndex = currentIndex.clamp(0, count - 1);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (int i = 0; i < count; i++) ...<Widget>[
          if (i > 0) SizedBox(width: resolvedSpacing),
          _Dot(
            isActive: i == safeIndex,
            activeColor: resolvedActive,
            inactiveColor: resolvedInactive,
            dotSize: resolvedDot,
            activeDotWidth: resolvedActiveDotWidth,
          ),
        ],
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({
    required this.isActive,
    required this.activeColor,
    required this.inactiveColor,
    required this.dotSize,
    required this.activeDotWidth,
  });

  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;
  final double dotSize;
  final double activeDotWidth;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: _kDotAnimationDuration,
      curve: Curves.easeInOut,
      width: isActive ? activeDotWidth : dotSize,
      height: dotSize,
      decoration: BoxDecoration(
        color: isActive ? activeColor : inactiveColor,
        borderRadius: BorderRadius.circular(dotSize / 2),
      ),
    );
  }
}
