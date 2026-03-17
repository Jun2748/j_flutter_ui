import 'package:flutter/material.dart';

import '../../resources/dimens.dart';

class SimpleTabs extends StatelessWidget {
  const SimpleTabs({
    super.key,
    required this.tabs,
    required this.children,
    this.initialIndex = 0,
    this.isScrollable = false,
    this.padding,
  }) : assert(tabs.length == children.length);

  final List<Tab> tabs;
  final List<Widget> children;
  final int initialIndex;
  final bool isScrollable;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color primary = theme.colorScheme.primary;
    final Color textSecondary =
        theme.textTheme.bodyMedium?.color ?? theme.colorScheme.onSurfaceVariant;
    final Color divider =
        DividerTheme.of(context).color ?? theme.colorScheme.outlineVariant;

    return DefaultTabController(
      length: tabs.length,
      initialIndex: initialIndex,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TabBar(
              tabs: tabs,
              isScrollable: isScrollable,
              labelColor: primary,
              unselectedLabelColor: textSecondary,
              indicatorColor: primary,
              dividerColor: divider,
              labelPadding: const EdgeInsets.symmetric(
                horizontal: JDimens.dp12,
              ),
            ),
            JGaps.h16,
            Expanded(child: TabBarView(children: children)),
          ],
        ),
      ),
    );
  }
}
