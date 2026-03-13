import 'package:flutter/material.dart';

import '../../resources/colors.dart';
import '../../resources/dimens.dart';

class SimpleCard extends StatelessWidget {
  const SimpleCard({
    super.key,
    required this.child,
    this.padding = JInsets.all16,
    this.margin = EdgeInsets.zero,
    this.radius,
    this.onTap,
  });

  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double? radius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final double resolvedRadius = radius ?? JDimens.dp16;
    final Widget content = Padding(padding: padding, child: child);

    return Card(
      margin: margin,
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      color: JColors.getColor(context, lightKey: 'card'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(resolvedRadius),
        side: BorderSide(color: JColors.getColor(context, lightKey: 'border')),
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
