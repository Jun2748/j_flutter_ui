import 'package:flutter/material.dart';

import '../../resources/dimens.dart';
import '../layout/gap.dart';

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
        padding ??
        const EdgeInsets.symmetric(
          horizontal: JDimens.dp16,
          vertical: JDimens.dp12,
        );
    final Widget content = Container(
      constraints: BoxConstraints(minHeight: minHeight ?? JHeights.listItem),
      padding: resolvedPadding,
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (leading != null) ...<Widget>[
            leading!,
            const Gap.w(JDimens.dp12),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                title,
                if (subtitle != null) ...<Widget>[
                  const Gap.h(JDimens.dp4),
                  subtitle!,
                ],
              ],
            ),
          ),
          if (trailing != null) ...<Widget>[
            const Gap.w(JDimens.dp12),
            trailing!,
          ],
        ],
      ),
    );

    if (onTap == null) {
      return content;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: content,
      ),
    );
  }
}
