import 'package:flutter/material.dart';

import '../../resources/dimens.dart';

class SimpleListItem extends StatelessWidget {
  const SimpleListItem({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.padding,
    this.minHeight,
  });

  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final double? minHeight;

  @override
  Widget build(BuildContext context) {
    final EdgeInsetsGeometry resolvedPadding =
        padding ?? JInsets.horizontal16Vertical12;
    final Widget content = Container(
      constraints: BoxConstraints(minHeight: minHeight ?? JHeights.listItem),
      padding: resolvedPadding,
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (leading != null) ...<Widget>[leading!, JGaps.w12],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                title,
                if (subtitle != null) ...<Widget>[JGaps.h4, subtitle!],
              ],
            ),
          ),
          if (trailing != null) ...<Widget>[JGaps.w12, trailing!],
        ],
      ),
    );

    if (onTap == null) {
      return content;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(onTap: onTap, child: content),
    );
  }
}
