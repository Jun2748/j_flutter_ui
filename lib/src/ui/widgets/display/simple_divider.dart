import 'package:flutter/material.dart';

import '../../resources/colors.dart';
import '../../resources/dimens.dart';

class SimpleDivider extends StatelessWidget {
  const SimpleDivider({
    super.key,
    this.height = JDimens.dp24,
    this.thickness = 1,
    this.indent = 0,
    this.endIndent = 0,
    this.color,
  });

  final double height;
  final double thickness;
  final double indent;
  final double endIndent;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
      color: color ?? JColors.getColor(context, lightKey: 'divider'),
    );
  }
}
