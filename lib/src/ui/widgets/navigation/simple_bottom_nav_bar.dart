import 'package:flutter/material.dart';

import '../../resources/app_theme_tokens.dart';
import '../../resources/dimens.dart';
import '../../resources/styles.dart';
import '../layout/h_stack.dart';
import '../typography/simple_text.dart';

class SimpleBottomNavItem {
  const SimpleBottomNavItem({
    required this.icon,
    required this.label,
    this.activeIcon,
  });

  final IconData? icon;
  final String? label;
  final IconData? activeIcon;
}

class SimpleBottomNavBar extends StatelessWidget {
  const SimpleBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.backgroundColor,
    this.borderColor,
  });

  final int? currentIndex;
  final ValueChanged<int>? onTap;
  final List<SimpleBottomNavItem>? items;
  final Color? backgroundColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final List<SimpleBottomNavItem> resolvedItems =
        items ?? const <SimpleBottomNavItem>[];
    if (resolvedItems.isEmpty) {
      return const SizedBox.shrink();
    }

    final ThemeData theme = Theme.of(context);
    final AppThemeTokens tokens = AppThemeTokens.resolve(theme);
    final int safeIndex = currentIndex == null
        ? 0
        : currentIndex!.clamp(0, resolvedItems.length - 1);
    final Color card = backgroundColor ?? tokens.cardBackground;
    final Color border = borderColor ?? tokens.cardBorderColor;
    final Color primary = tokens.primary;
    final Color textSecondary = tokens.mutedText;
    final TextStyle labelStyle =
        theme.textTheme.labelSmall ?? JTextStyles.label;

    if (resolvedItems.length < 2) {
      final SimpleBottomNavItem item = resolvedItems.first;
      return Material(
        color: card,
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: JHeights.appBar,
            child: Center(
              child: HStack(
                gap: JDimens.dp8,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(item.activeIcon ?? item.icon ?? Icons.circle_outlined),
                  SimpleText.label(text: item.label ?? ''),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: card,
        border: Border(top: BorderSide(color: border)),
      ),
      child: SafeArea(
        top: false,
        child: BottomNavigationBar(
          currentIndex: safeIndex,
          onTap: onTap,
          type: BottomNavigationBarType.fixed,
          backgroundColor: card,
          elevation: 0,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: primary,
          unselectedItemColor: textSecondary,
          selectedLabelStyle: labelStyle.copyWith(
            color: primary,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: labelStyle.copyWith(color: textSecondary),
          iconSize: JIconSizes.md,
          items: resolvedItems
              .map(
                (SimpleBottomNavItem item) => BottomNavigationBarItem(
                  icon: Icon(item.icon ?? Icons.circle_outlined),
                  activeIcon: item.activeIcon == null
                      ? null
                      : Icon(item.activeIcon),
                  label: item.label ?? '',
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
