import 'package:flutter/material.dart';

class BottomNavItem {
  const BottomNavItem({
    required this.icon,
    required this.label,
    this.activeIcon,
  });

  final IconData icon;
  final String label;
  final IconData? activeIcon;
}

class BottomNavBarEx extends StatelessWidget {
  const BottomNavBarEx({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BottomNavItem> items;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: items
          .map(
            (BottomNavItem item) => BottomNavigationBarItem(
              icon: Icon(item.icon),
              activeIcon: item.activeIcon == null
                  ? null
                  : Icon(item.activeIcon),
              label: item.label,
            ),
          )
          .toList(),
    );
  }
}
