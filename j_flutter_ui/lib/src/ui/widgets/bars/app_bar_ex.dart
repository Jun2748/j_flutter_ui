import 'package:flutter/material.dart';

import '../../resources/dimens.dart';

class AppBarEx extends StatelessWidget implements PreferredSizeWidget {
  const AppBarEx({
    super.key,
    this.title,
    this.titleWidget,
    this.actions,
    this.leading,
    this.centerTitle = false,
  });

  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;

  @override
  Size get preferredSize => const Size.fromHeight(JHeights.appBar);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: titleWidget ?? (title != null ? Text(title!) : null),
      actions: actions,
      leading: leading,
      centerTitle: centerTitle,
    );
  }
}
