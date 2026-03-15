import 'package:flutter/material.dart';

import '../../resources/colors.dart';
import '../../resources/dimens.dart';
import '../../resources/styles.dart';

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
  });

  final int? currentIndex;
  final ValueChanged<int>? onTap;
  final List<SimpleBottomNavItem>? items;

  @override
  Widget build(BuildContext context) {
    final List<SimpleBottomNavItem> resolvedItems =
        items ?? const <SimpleBottomNavItem>[];
    if (resolvedItems.isEmpty) {
      return const SizedBox.shrink();
    }

    final int safeIndex = currentIndex == null
        ? 0
        : currentIndex!.clamp(0, resolvedItems.length - 1);
    final Color card = JColors.getColor(context, lightKey: 'card');
    final Color border = JColors.getColor(context, lightKey: 'border');
    final Color primary = JColors.getColor(context, lightKey: 'primary');
    final Color textSecondary = JColors.getColor(
      context,
      lightKey: 'textSecondary',
    );

    if (resolvedItems.length < 2) {
      final SimpleBottomNavItem item = resolvedItems.first;
      return Material(
        color: card,
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: JHeights.appBar,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(item.activeIcon ?? item.icon ?? Icons.circle_outlined),
                  const SizedBox(width: JDimens.dp8),
                  Text(item.label ?? ''),
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
          selectedLabelStyle: JTextStyles.label.copyWith(
            color: primary,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: JTextStyles.label.copyWith(
            color: textSecondary,
          ),
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
