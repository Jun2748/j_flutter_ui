import 'package:flutter/material.dart';

import '../../../resources/app_theme_tokens.dart';
import '../../../resources/dimens.dart';
import '../../../resources/styles.dart';

typedef SimpleMultiSelectChipBarLabelBuilder<T> = String? Function(T item);

/// Wrap-layout multi-select chip group for toppings, add-ons, or filters.
///
/// Wraps Material [FilterChip] in a [Wrap] with token-driven colors.
/// Toggle logic (e.g. mutual exclusion) is the caller's responsibility
/// inside [onChanged].
class SimpleMultiSelectChipBar<T> extends StatelessWidget {
  const SimpleMultiSelectChipBar({
    super.key,
    required this.items,
    required this.values,
    required this.onChanged,
    required this.labelBuilder,
    this.maxSelections,
    this.spacing,
    this.runSpacing,
    this.selectedColor,
    this.unselectedColor,
    this.selectedLabelColor,
    this.unselectedLabelColor,
  });

  /// Available options.
  final List<T> items;

  /// Currently selected items.
  final Set<T> values;

  /// Called with the updated selection set after a tap.
  final ValueChanged<Set<T>> onChanged;

  /// Provides a display label for each item.
  final SimpleMultiSelectChipBarLabelBuilder<T> labelBuilder;

  /// Maximum simultaneous selections. `null` means no limit.
  final int? maxSelections;

  /// Horizontal gap between chips. Defaults to `JDimens.dp8`.
  final double? spacing;

  /// Vertical gap between wrapped rows. Defaults to `JDimens.dp8`.
  final double? runSpacing;

  /// Background color for selected chips. Defaults to `tokens.primary`.
  final Color? selectedColor;

  /// Background color for unselected chips.
  /// Falls back to `ChipTheme` then `tokens.cardBackground`.
  final Color? unselectedColor;

  /// Label color for selected chips. Defaults to `tokens.onPrimaryResolved`.
  final Color? selectedLabelColor;

  /// Label color for unselected chips.
  /// Falls back to `ChipTheme` then `tokens.mutedText`.
  final Color? unselectedLabelColor;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    final ThemeData theme = Theme.of(context);
    final ChipThemeData chipTheme = ChipTheme.of(context);
    final AppThemeTokens tokens = theme.appThemeTokens;
    final _ResolvedColors colors = _resolveColors(
      theme: theme,
      chipTheme: chipTheme,
      tokens: tokens,
    );

    return Wrap(
      spacing: spacing ?? JDimens.dp8,
      runSpacing: runSpacing ?? JDimens.dp8,
      children: <Widget>[
        for (final T item in items)
          _buildChip(
            context,
            item: item,
            theme: theme,
            chipTheme: chipTheme,
            colors: colors,
            borderColor: tokens.cardBorderColor,
          ),
      ],
    );
  }

  Widget _buildChip(
    BuildContext context, {
    required T item,
    required ThemeData theme,
    required ChipThemeData chipTheme,
    required _ResolvedColors colors,
    required Color borderColor,
  }) {
    final bool isSelected = values.contains(item);
    final int? max = maxSelections;
    final bool atLimit =
        !isSelected && max != null && values.length >= max;

    return FilterChip(
      label: Text(
        labelBuilder(item) ?? '',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: isSelected
            ? _resolveSelectedLabelStyle(theme, chipTheme, colors)
            : _resolveLabelStyle(theme, chipTheme, colors),
      ),
      selected: isSelected,
      onSelected: atLimit && !isSelected
          ? null
          : (_) => _handleTap(item, isSelected),
      showCheckmark: false,
      padding: chipTheme.padding ?? JInsets.horizontal12Vertical8,
      labelPadding: chipTheme.labelPadding,
      backgroundColor: colors.unselectedBackground,
      selectedColor: colors.selectedBackground,
      disabledColor: colors.unselectedBackground,
      side: chipTheme.side ?? BorderSide(color: borderColor),
      shape: chipTheme.shape ?? const StadiumBorder(),
    );
  }

  void _handleTap(T item, bool wasSelected) {
    final Set<T> updated = Set<T>.from(values);
    if (wasSelected) {
      updated.remove(item);
    } else {
      updated.add(item);
    }
    onChanged(updated);
  }

  TextStyle _resolveLabelStyle(
    ThemeData theme,
    ChipThemeData chipTheme,
    _ResolvedColors colors,
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
    _ResolvedColors colors,
  ) {
    final TextStyle baseStyle =
        chipTheme.secondaryLabelStyle ??
        chipTheme.labelStyle ??
        theme.textTheme.labelLarge ??
        theme.textTheme.labelSmall ??
        JTextStyles.label;

    return baseStyle.copyWith(color: colors.selectedLabel);
  }

  _ResolvedColors _resolveColors({
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
        tokens.mutedText;

    return _ResolvedColors(
      selectedBackground: resolvedSelectedBackground,
      unselectedBackground: resolvedUnselectedBackground,
      selectedLabel: resolvedSelectedLabel,
      unselectedLabel: resolvedUnselectedLabel,
    );
  }
}

class _ResolvedColors {
  const _ResolvedColors({
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
