import 'package:flutter/material.dart';

import '../../resources/app_theme_tokens.dart';
import '../../resources/dimens.dart';
import '../../resources/styles.dart';

class SimpleVerticalRailItem {
  const SimpleVerticalRailItem({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

class SimpleVerticalRail extends StatelessWidget {
  const SimpleVerticalRail({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onSelected,
    this.itemHeight = 76.0,
    this.iconSize,
    this.labelStyle,
    this.backgroundColor,
    this.borderColor,
    this.showEndBorder = true,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.selectedItemBackgroundColor,
  });

  final List<SimpleVerticalRailItem> items;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  /// Height of each item. Defaults to 76dp.
  final double itemHeight;

  /// Icon size. Defaults to [JIconSizes.lg].
  final double? iconSize;

  /// Label text style base. Active/inactive weight is applied on top.
  /// Defaults to [JTextStyles.label].
  final TextStyle? labelStyle;

  /// Rail background color. Defaults to [ThemeData.scaffoldBackgroundColor].
  final Color? backgroundColor;

  /// End border color. Defaults to [AppThemeTokens.dividerColor].
  final Color? borderColor;

  /// Whether to draw a 1dp end border separating the rail from content.
  /// Defaults to true.
  final bool showEndBorder;

  /// Color for the selected/active item (icon + label).
  /// Defaults to [ColorScheme.onSurface].
  final Color? selectedItemColor;

  /// Color for unselected/inactive items (icon + label).
  /// Defaults to [AppThemeTokens.mutedText].
  final Color? unselectedItemColor;

  /// Optional background color for the selected/active item highlight.
  /// Defaults to null for no selected background.
  final Color? selectedItemBackgroundColor;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppThemeTokens tokens = theme.appThemeTokens;

    final Color resolvedBackground =
        backgroundColor ?? theme.scaffoldBackgroundColor;
    final Color resolvedBorder = borderColor ?? tokens.dividerColor;
    final double resolvedIconSize = iconSize ?? JIconSizes.lg;
    final TextStyle resolvedLabelBase = labelStyle ?? JTextStyles.label;
    final BorderRadius selectedItemBorderRadius = BorderRadius.circular(
      JDimens.dp12,
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: resolvedBackground,
        border: showEndBorder
            ? BorderDirectional(
                end: BorderSide(color: resolvedBorder, width: JDimens.dp1),
              )
            : null,
      ),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final SimpleVerticalRailItem item = items[index];
          final bool isActive = index == selectedIndex;
          final Color itemColor = isActive
              ? (selectedItemColor ?? theme.colorScheme.onSurface)
              : (unselectedItemColor ?? tokens.mutedText);

          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => onSelected(index),
              borderRadius: selectedItemBackgroundColor == null
                  ? null
                  : selectedItemBorderRadius,
              child: SizedBox(
                height: itemHeight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: JDimens.dp8),
                  child: Ink(
                    decoration: isActive && selectedItemBackgroundColor != null
                        ? BoxDecoration(
                            color: selectedItemBackgroundColor,
                            borderRadius: selectedItemBorderRadius,
                          )
                        : null,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          item.icon,
                          size: resolvedIconSize,
                          color: itemColor,
                        ),
                        const SizedBox(height: JDimens.dp4),
                        Text(
                          item.label,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: resolvedLabelBase.copyWith(
                            color: itemColor,
                            fontWeight: isActive
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
