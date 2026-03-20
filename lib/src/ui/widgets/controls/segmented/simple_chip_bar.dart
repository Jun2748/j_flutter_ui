import 'package:flutter/material.dart';

import '../../../resources/app_theme_tokens.dart';
import '../../../resources/dimens.dart';
import '../../../resources/styles.dart';

typedef SimpleChipBarLabelBuilder<T> = String? Function(T item);

class SimpleChipBar<T> extends StatelessWidget {
  const SimpleChipBar({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    required this.labelBuilder,
    this.padding,
    this.selectedColor,
    this.unselectedColor,
    this.selectedLabelColor,
    this.unselectedLabelColor,
  });

  final List<T> items;
  final T? value;
  final ValueChanged<T> onChanged;
  final SimpleChipBarLabelBuilder<T> labelBuilder;
  final EdgeInsetsGeometry? padding;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? selectedLabelColor;
  final Color? unselectedLabelColor;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    final ThemeData theme = Theme.of(context);
    final ChipThemeData chipTheme = ChipTheme.of(context);
    final AppThemeTokens tokens = theme.appThemeTokens;
    final _SimpleChipBarColors colors = _resolveColors(
      theme: theme,
      chipTheme: chipTheme,
      tokens: tokens,
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        children: <Widget>[
          for (int index = 0; index < items.length; index++) ...<Widget>[
            if (index > 0) JGaps.w8,
            _buildChip(
              context,
              item: items[index],
              chipTheme: chipTheme,
              colors: colors,
              borderColor: tokens.cardBorderColor,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildChip(
    BuildContext context, {
    required T item,
    required ChipThemeData chipTheme,
    required _SimpleChipBarColors colors,
    required Color borderColor,
  }) {
    final ThemeData theme = Theme.of(context);
    final bool isSelected = item == value;

    return ChoiceChip(
      label: Text(
        labelBuilder(item) ?? '',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: isSelected
            ? _resolveSelectedLabelStyle(theme, chipTheme, colors)
            : _resolveLabelStyle(theme, chipTheme, colors),
      ),
      selected: isSelected,
      onSelected: (_) => onChanged(item),
      showCheckmark: false,
      padding: chipTheme.padding ?? JInsets.horizontal12Vertical8,
      labelPadding: chipTheme.labelPadding,
      backgroundColor: colors.unselectedBackground,
      selectedColor: colors.selectedBackground,
      side: chipTheme.side ?? BorderSide(color: borderColor),
      shape: chipTheme.shape ?? const StadiumBorder(),
    );
  }

  TextStyle _resolveLabelStyle(
    ThemeData theme,
    ChipThemeData chipTheme,
    _SimpleChipBarColors colors,
  ) {
    final TextStyle baseStyle =
        chipTheme.labelStyle ??
        theme.textTheme.labelLarge ??
        theme.textTheme.labelSmall ??
        JTextStyles.label;

    return baseStyle.copyWith(color: colors.unselectedLabel);
  }

  TextStyle _resolveSelectedLabelStyle(
    ThemeData theme,
    ChipThemeData chipTheme,
    _SimpleChipBarColors colors,
  ) {
    final TextStyle baseStyle =
        chipTheme.secondaryLabelStyle ??
        chipTheme.labelStyle ??
        theme.textTheme.labelLarge ??
        theme.textTheme.labelSmall ??
        JTextStyles.label;

    return baseStyle.copyWith(color: colors.selectedLabel);
  }

  _SimpleChipBarColors _resolveColors({
    required ThemeData theme,
    required ChipThemeData chipTheme,
    required AppThemeTokens tokens,
  }) {
    final Color resolvedSelectedBackground =
        selectedColor ??
        chipTheme.secondarySelectedColor ??
        chipTheme.selectedColor ??
        tokens.primary;
    final Color resolvedUnselectedBackground =
        unselectedColor ?? chipTheme.backgroundColor ?? tokens.cardBackground;
    final Color resolvedSelectedLabel =
        selectedLabelColor ??
        chipTheme.secondaryLabelStyle?.color ??
        tokens.onPrimaryResolved(theme);
    final Color resolvedUnselectedLabel =
        unselectedLabelColor ??
        chipTheme.labelStyle?.color ??
        theme.textTheme.labelLarge?.color ??
        tokens.onCardResolved(theme);

    return _SimpleChipBarColors(
      selectedBackground: resolvedSelectedBackground,
      unselectedBackground: resolvedUnselectedBackground,
      selectedLabel: resolvedSelectedLabel,
      unselectedLabel: resolvedUnselectedLabel,
    );
  }
}

class _SimpleChipBarColors {
  const _SimpleChipBarColors({
    required this.selectedBackground,
    required this.unselectedBackground,
    required this.selectedLabel,
    required this.unselectedLabel,
  });

  final Color selectedBackground;
  final Color unselectedBackground;
  final Color selectedLabel;
  final Color unselectedLabel;
}
