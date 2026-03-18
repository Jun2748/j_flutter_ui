import 'package:flutter/material.dart';

import '../../resources/app_theme_tokens.dart';
import '../../resources/dimens.dart';

class SimpleCard extends StatelessWidget {
  const SimpleCard({
    super.key,
    required this.child,
    this.padding = JInsets.all16,
    this.margin = JInsets.all16,
    this.radius,
    this.backgroundColor,
    this.borderColor,
    this.onTap,
  });

  final Widget? child;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double? radius;
  final Color? backgroundColor;
  final Color? borderColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final double resolvedRadius = radius ?? JDimens.dp16;
    final ThemeData theme = Theme.of(context);
    final AppThemeTokens tokens = theme.appThemeTokens;
    final Color resolvedBackgroundColor =
        backgroundColor ?? tokens.cardBackground;
    final Color resolvedBorderColor = borderColor ?? tokens.cardBorderColor;
    final Widget content = Padding(
      padding: padding,
      child: child ?? const SizedBox.shrink(),
    );

    return Card(
      margin: margin,
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      color: resolvedBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(resolvedRadius),
        side: BorderSide(color: resolvedBorderColor),
      ),
      child: onTap == null
          ? content
          : InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(resolvedRadius),
              child: content,
            ),
    );
  }
}
