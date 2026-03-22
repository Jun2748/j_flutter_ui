import 'package:flutter/material.dart';

import '../../resources/app_theme_tokens.dart';
import '../../resources/dimens.dart';

// Shimmer animation constants
const Duration _kShimmerDuration = Duration(milliseconds: 1200);
// Gradient sweep range: moves a highlight from off-screen-left to off-screen-right.
// begin goes from -1.5 → 1.5, end leads by 1.0, both driven by pos ∈ [0,1].
const double _kShimmerSweepRange = 3.0;
const double _kShimmerBeginOffset = -1.5;
const double _kShimmerEndOffset = -0.5;
// Fraction of baseColor blended toward white to derive the highlight color.
const double _kHighlightBlend = 0.5;

/// Shimmer-animated placeholder rectangle for loading states.
///
/// Size is controlled by [width] and [height]. Use multiple
/// [SimpleSkeletonBox] instances in a [Column] to replicate content
/// structure during data fetching.
///
/// Token defaults: [baseColor] → `tokens.cardBorderColor`,
/// [highlightColor] derived from [baseColor] blended toward white.
class SimpleSkeletonBox extends StatefulWidget {
  const SimpleSkeletonBox({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.baseColor,
    this.highlightColor,
  });

  /// Box width. Defaults to `double.infinity`.
  final double? width;

  /// Box height. Defaults to `JDimens.dp16`.
  final double? height;

  /// Corner radius. Defaults to `JDimens.dp8`.
  final double? borderRadius;

  /// Shimmer base (darker) color. Defaults to `tokens.cardBorderColor`.
  final Color? baseColor;

  /// Shimmer highlight (lighter) color.
  /// Defaults to [baseColor] blended 50% toward white.
  final Color? highlightColor;

  @override
  State<SimpleSkeletonBox> createState() => _SimpleSkeletonBoxState();
}

class _SimpleSkeletonBoxState extends State<SimpleSkeletonBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _kShimmerDuration,
    )..repeat();
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppThemeTokens tokens = Theme.of(context).appThemeTokens;

    final Color resolvedBase = widget.baseColor ?? tokens.cardBorderColor;
    // Blend base 50% toward white for the highlight — no hardcoded color.
    final Color resolvedHighlight =
        widget.highlightColor ??
        Color.lerp(resolvedBase, Colors.white, _kHighlightBlend) ??
        resolvedBase;

    final double resolvedWidth = widget.width ?? double.infinity;
    final double resolvedHeight = widget.height ?? JDimens.dp16;
    final double resolvedRadius = widget.borderRadius ?? JDimens.dp8;

    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        final double pos = _animation.value;
        final Alignment begin =
            Alignment(_kShimmerBeginOffset + pos * _kShimmerSweepRange, 0);
        final Alignment end =
            Alignment(_kShimmerEndOffset + pos * _kShimmerSweepRange, 0);

        return Container(
          width: resolvedWidth,
          height: resolvedHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(resolvedRadius),
            gradient: LinearGradient(
              begin: begin,
              end: end,
              colors: <Color>[resolvedBase, resolvedHighlight, resolvedBase],
              stops: const <double>[0.0, 0.5, 1.0],
            ),
          ),
        );
      },
    );
  }
}
