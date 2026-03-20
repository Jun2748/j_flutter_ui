import 'package:flutter/material.dart';

import '../../resources/app_theme_tokens.dart';
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
    final AppThemeTokens tokens = theme.appThemeTokens;
    final TabBarThemeData tabBarTheme = theme.tabBarTheme;
    final Color primary = tabBarTheme.labelColor ?? tokens.primary;
    final Color textSecondary =
        tabBarTheme.unselectedLabelColor ?? tokens.mutedText;
    final Color divider = tabBarTheme.dividerColor ?? tokens.dividerColor;

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
              indicatorColor: tabBarTheme.indicatorColor ?? primary,
              dividerColor: divider,
              labelPadding: tabBarTheme.labelPadding ?? JInsets.horizontal12,
            ),
            JGaps.h16,
            Expanded(child: TabBarView(children: children)),
          ],
        ),
      ),
    );
  }
}
