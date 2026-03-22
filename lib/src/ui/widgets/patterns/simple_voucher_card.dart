import 'dart:ui' show PathMetric, PathMetrics;

import 'package:flutter/material.dart';

import '../../resources/app_theme_tokens.dart';
import '../../resources/dimens.dart';

/// A card with a dashed border for voucher, promo, and loyalty card surfaces.
///
/// Accepts a composition [child] slot for full content flexibility.
/// Set [onTap] to make the card interactive; `null` renders a static surface.
///
/// Token defaults: [backgroundColor] → `tokens.cardBackground`,
/// [borderColor] → `tokens.cardBorderColor`.
class SimpleVoucherCard extends StatelessWidget {
  const SimpleVoucherCard({
    super.key,
    required this.child,
    this.onTap,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.dashWidth,
    this.dashGap,
    this.borderWidth,
    this.padding,
    this.margin,
  });

  /// Card content.
  final Widget child;

  /// Called when the card is tapped. `null` = non-interactive.
  final VoidCallback? onTap;

  /// Card fill color. Defaults to `tokens.cardBackground`.
  final Color? backgroundColor;

  /// Dashed border color. Defaults to `tokens.cardBorderColor`.
  final Color? borderColor;

  /// Corner radius. Defaults to `JDimens.dp12`.
  final double? borderRadius;

  /// Length of each dash segment. Defaults to `JDimens.dp8`.
  final double? dashWidth;

  /// Gap between dash segments. Defaults to `JDimens.dp4`.
  final double? dashGap;

  /// Stroke width of the dashed border. Defaults to `JDimens.dp1_5`.
  final double? borderWidth;

  /// Inner content padding. Defaults to `JInsets.all16`.
  final EdgeInsetsGeometry? padding;

  /// Outer margin. Defaults to `EdgeInsets.zero`.
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppThemeTokens tokens = theme.appThemeTokens;

    final Color resolvedBackground =
        backgroundColor ??
        theme.cardTheme.color ??
        tokens.cardBackground;
    final Color resolvedBorder = borderColor ?? tokens.cardBorderColor;
    final double resolvedRadius = borderRadius ?? JDimens.dp12;
    final double resolvedDashWidth = dashWidth ?? JDimens.dp8;
    final double resolvedDashGap = dashGap ?? JDimens.dp4;
    final double resolvedBorderWidth = borderWidth ?? JDimens.dp1_5;
    final EdgeInsetsGeometry resolvedPadding = padding ?? JInsets.all16;
    final EdgeInsetsGeometry resolvedMargin = margin ?? EdgeInsets.zero;

    Widget card = ClipRRect(
      borderRadius: BorderRadius.circular(resolvedRadius),
      child: CustomPaint(
        painter: _DashedBorderPainter(
          color: resolvedBorder,
          radius: resolvedRadius,
          dashWidth: resolvedDashWidth,
          dashGap: resolvedDashGap,
          strokeWidth: resolvedBorderWidth,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: resolvedBackground,
            borderRadius: BorderRadius.circular(resolvedRadius),
          ),
          padding: resolvedPadding,
          child: child,
        ),
      ),
    );

    if (onTap != null) {
      card = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(resolvedRadius),
        child: card,
      );
    }

    return Padding(
      padding: resolvedMargin,
      child: card,
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  const _DashedBorderPainter({
    required this.color,
    required this.radius,
    required this.dashWidth,
    required this.dashGap,
    required this.strokeWidth,
  });

  final Color color;
  final double radius;
  final double dashWidth;
  final double dashGap;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        strokeWidth / 2,
        strokeWidth / 2,
        size.width - strokeWidth,
        size.height - strokeWidth,
      ),
      Radius.circular(radius),
    );

    final Path path = Path()..addRRect(rrect);
    _drawDashedPath(canvas, path, paint);
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    final PathMetrics metrics = path.computeMetrics();
    for (final PathMetric metric in metrics) {
      double distance = 0;
      bool draw = true;
      while (distance < metric.length) {
        final double segmentLength = draw ? dashWidth : dashGap;
        final double end = (distance + segmentLength).clamp(0, metric.length);
        if (draw) {
          canvas.drawPath(metric.extractPath(distance, end), paint);
        }
        distance += segmentLength;
        draw = !draw;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedBorderPainter old) =>
      old.color != color ||
      old.radius != radius ||
      old.dashWidth != dashWidth ||
      old.dashGap != dashGap ||
      old.strokeWidth != strokeWidth;
}
