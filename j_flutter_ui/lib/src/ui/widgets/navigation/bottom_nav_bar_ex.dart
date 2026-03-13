import 'package:flutter/material.dart';

class BottomNavItem {
  const BottomNavItem({
    required this.icon,
    required this.label,
    this.activeIcon,
  });

  final IconData? icon;
  final String? label;
  final IconData? activeIcon;
}

class BottomNavBarEx extends StatelessWidget {
  const BottomNavBarEx({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  final int? currentIndex;
  final ValueChanged<int>? onTap;
  final List<BottomNavItem>? items;

  @override
  Widget build(BuildContext context) {
    final List<BottomNavItem> resolvedItems = items ?? const <BottomNavItem>[];
    if (resolvedItems.isEmpty) {
      return const SizedBox.shrink();
    }

    final int safeIndex = currentIndex == null
        ? 0
        : currentIndex!.clamp(0, resolvedItems.length - 1);

    if (resolvedItems.length < 2) {
      final BottomNavItem item = resolvedItems.first;
      return Material(
        color: Theme.of(context).colorScheme.surface,
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 56,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(item.activeIcon ?? item.icon ?? Icons.circle_outlined),
                  const SizedBox(width: 8),
                  Text(item.label ?? ''),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return BottomNavigationBar(
      currentIndex: safeIndex,
      onTap: onTap,
      items: resolvedItems
          .map(
            (BottomNavItem item) => BottomNavigationBarItem(
              icon: Icon(item.icon ?? Icons.circle_outlined),
              activeIcon: item.activeIcon == null
                  ? null
                  : Icon(item.activeIcon),
              label: item.label ?? '',
            ),
          )
          .toList(),
    );
  }
}
