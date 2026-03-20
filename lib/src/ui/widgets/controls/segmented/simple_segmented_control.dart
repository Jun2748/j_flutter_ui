import 'package:flutter/material.dart';

import '../../../resources/app_theme_tokens.dart';
import '../../../resources/dimens.dart';
import '../../typography/simple_text.dart';

class SimpleSegmentedItem<T> {
  const SimpleSegmentedItem({
    required this.value,
    required this.label,
    this.icon,
  });

  final T value;
  final String label;
  final IconData? icon;
}

class SimpleSegmentedControl<T> extends StatelessWidget {
  const SimpleSegmentedControl({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.padding,
    this.expanded = true,
  });

  final List<SimpleSegmentedItem<T>> items;
  final T value;
  final ValueChanged<T> onChanged;
  final EdgeInsets? padding;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppThemeTokens tokens = theme.appThemeTokens;
    final Color surface = tokens.cardBackground;
    final Color border = tokens.cardBorderColor;

    return Container(
      padding: padding ?? JInsets.all4,
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(JDimens.dp16),
        border: Border.all(color: border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          for (int index = 0; index < items.length; index++)
            _buildSegment(context, items[index], index),
        ],
      ),
    );
  }

  Widget _buildSegment(
    BuildContext context,
    SimpleSegmentedItem<T> item,
    int index,
  ) {
    final ThemeData theme = Theme.of(context);
    final AppThemeTokens tokens = theme.appThemeTokens;
    final bool isSelected = item.value == value;
    final Color primary = tokens.primary;
    final Color onPrimary = tokens.onPrimaryResolved(theme);
    final Color textPrimary = tokens.onCardResolved(theme);
    final Color textSecondary = tokens.mutedText;

    Widget child = InkWell(
      borderRadius: BorderRadius.circular(JDimens.dp12),
      onTap: () => onChanged(item.value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: JInsets.horizontal12Vertical8,
        decoration: BoxDecoration(
          color: isSelected ? primary : Colors.transparent,
          borderRadius: BorderRadius.circular(JDimens.dp12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
          children: <Widget>[
            if (item.icon != null) ...<Widget>[
              Icon(
                item.icon,
                size: JIconSizes.sm,
                color: isSelected ? onPrimary : textSecondary,
              ),
              JGaps.w8,
            ],
            Flexible(
              child: SimpleText.label(
                text: item.label,
                color: isSelected ? onPrimary : textPrimary,
                weight: FontWeight.w600,
                align: TextAlign.center,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );

    if (expanded) {
      child = Expanded(child: child);
    } else if (index > 0) {
      child = Padding(
        padding: const EdgeInsetsDirectional.only(start: JDimens.dp4),
        child: child,
      );
    }

    return child;
  }
}
