import 'package:flutter/material.dart';

import '../../resources/app_theme_tokens.dart';
import '../../resources/dimens.dart';
import '../../resources/styles.dart';
import '../feedback/simple_badge.dart';
import '../layout/h_stack.dart';
import '../typography/simple_text.dart';

class SimpleBottomNavItem {
  const SimpleBottomNavItem({
    required this.icon,
    required this.label,
    this.activeIcon,
    this.badgeLabel,
  });

  final IconData? icon;
  final String? label;
  final IconData? activeIcon;

  /// Optional short text rendered as a badge overlaid on the item's icon
  /// (top-end corner). Suitable for counts ("3") or short status markers.
  final String? badgeLabel;
}

class SimpleBottomNavBar extends StatelessWidget {
  const SimpleBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.backgroundColor,
    this.borderColor,
    this.activeIconBackgroundColor,
  });

  final int? currentIndex;
  final ValueChanged<int>? onTap;
  final List<SimpleBottomNavItem>? items;
  final Color? backgroundColor;
  final Color? borderColor;

  /// Optional circular background color for the selected/active icon.
  /// Defaults to null for the standard active icon treatment.
  final Color? activeIconBackgroundColor;

  @override
  Widget build(BuildContext context) {
    final List<SimpleBottomNavItem> resolvedItems =
        items ?? const <SimpleBottomNavItem>[];
    if (resolvedItems.isEmpty) {
      return const SizedBox.shrink();
    }

    final ThemeData theme = Theme.of(context);
    final AppThemeTokens tokens = theme.appThemeTokens;
    final BottomNavigationBarThemeData bottomNavTheme =
        theme.bottomNavigationBarTheme;
    final int safeIndex = currentIndex == null
        ? 0
        : currentIndex!.clamp(0, resolvedItems.length - 1);
    final Color card =
        backgroundColor ??
        bottomNavTheme.backgroundColor ??
        tokens.cardBackground;
    final Color border = borderColor ?? tokens.cardBorderColor;
    final Color primary = bottomNavTheme.selectedItemColor ?? tokens.primary;
    final Color textSecondary =
        bottomNavTheme.unselectedItemColor ?? tokens.mutedText;
    final TextStyle labelStyle =
        theme.textTheme.labelSmall ?? JTextStyles.label;
    final TextStyle selectedLabelStyle =
        bottomNavTheme.selectedLabelStyle ??
        labelStyle.copyWith(color: primary, fontWeight: FontWeight.w600);
    final TextStyle unselectedLabelStyle =
        bottomNavTheme.unselectedLabelStyle ??
        labelStyle.copyWith(color: textSecondary);
    final double iconSize =
        bottomNavTheme.selectedIconTheme?.size ??
        bottomNavTheme.unselectedIconTheme?.size ??
        JIconSizes.md;

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
                  _buildActiveNavIcon(context, item) ??
                      _buildInactiveNavIcon(context, item),
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
          type: bottomNavTheme.type ?? BottomNavigationBarType.fixed,
          backgroundColor: card,
          elevation: bottomNavTheme.elevation ?? 0,
          showSelectedLabels: bottomNavTheme.showSelectedLabels ?? true,
          showUnselectedLabels: bottomNavTheme.showUnselectedLabels ?? true,
          selectedItemColor: primary,
          unselectedItemColor: textSecondary,
          selectedLabelStyle: selectedLabelStyle,
          unselectedLabelStyle: unselectedLabelStyle,
          iconSize: iconSize,
          items: resolvedItems
              .map(
                (SimpleBottomNavItem item) => BottomNavigationBarItem(
                  icon: _buildInactiveNavIcon(context, item),
                  activeIcon: _buildActiveNavIcon(context, item),
                  label: item.label ?? '',
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildInactiveNavIcon(BuildContext context, SimpleBottomNavItem item) {
    return _wrapIconWithBadge(
      context,
      item,
      Icon(item.icon ?? Icons.circle_outlined),
    );
  }

  Widget? _buildActiveNavIcon(BuildContext context, SimpleBottomNavItem item) {
    if (activeIconBackgroundColor == null && item.activeIcon == null) {
      return null;
    }

    final Widget icon = Icon(
      item.activeIcon ?? item.icon ?? Icons.circle_outlined,
    );

    if (activeIconBackgroundColor == null) {
      return _wrapIconWithBadge(context, item, icon);
    }

    return _wrapIconWithBadge(
      context,
      item,
      DecoratedBox(
        decoration: BoxDecoration(
          color: activeIconBackgroundColor,
          shape: BoxShape.circle,
        ),
        child: Padding(padding: JInsets.all8, child: icon),
      ),
    );
  }

  Widget _wrapIconWithBadge(
    BuildContext context,
    SimpleBottomNavItem item,
    Widget icon,
  ) {
    final String? badgeLabel = item.badgeLabel;
    if (badgeLabel == null) {
      return icon;
    }

    final ThemeData theme = Theme.of(context);
    final AppThemeTokens tokens = theme.appThemeTokens;

    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        icon,
        PositionedDirectional(
          top: -JDimens.dp4,
          end: -JDimens.dp8,
          child: SimpleBadge.filled(
            label: badgeLabel,
            color: tokens.primary,
            foregroundColor: tokens.onPrimaryResolved(theme),
            padding: const EdgeInsets.symmetric(
              horizontal: JDimens.dp4,
              vertical: JDimens.dp2,
            ),
            labelWeight: FontWeight.w700,
            labelStyle: const TextStyle(height: 1.0),
          ),
        ),
      ],
    );
  }
}
