import 'package:flutter/material.dart';

import '../../resources/app_theme_tokens.dart';
import '../../resources/dimens.dart';

class SimpleDivider extends StatelessWidget {
  const SimpleDivider({
    super.key,
    this.height = JDimens.dp24,
    this.thickness = JDimens.dp1,
    this.indent = JDimens.dp0,
    this.endIndent = JDimens.dp0,
    this.color,
  });

  final double height;
  final double thickness;
  final double indent;
  final double endIndent;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final AppThemeTokens tokens = AppThemeTokens.resolve(Theme.of(context));

    return Divider(
      height: height,
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
      color: color ?? tokens.dividerColor,
    );
  }
}
