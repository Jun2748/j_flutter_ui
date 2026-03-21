import 'package:flutter/material.dart';

import '../../resources/app_theme_tokens.dart';
import '../../resources/colors.dart';
import '../../resources/dimens.dart';
import '../../resources/tinted_surface.dart';
import '../typography/simple_text.dart';

enum _SimpleBadgeVariant { neutral, primary, success, warning, error, filled }

class SimpleBadge extends StatelessWidget {
  const SimpleBadge._({
    super.key,
    required this.label,
    required _SimpleBadgeVariant variant,
    this.icon,
    this.padding,
    this.labelWeight,
    this.labelStyle,
    Color? filledColor,
    Color? filledForeground,
  }) : _variant = variant,
       _filledColor = filledColor,
       _filledForeground = filledForeground;

  const SimpleBadge.neutral({
    Key? key,
    required String label,
    IconData? icon,
    EdgeInsets? padding,
    FontWeight? labelWeight,
    TextStyle? labelStyle,
  }) : this._(
         key: key,
         label: label,
         variant: _SimpleBadgeVariant.neutral,
         icon: icon,
         padding: padding,
         labelWeight: labelWeight,
         labelStyle: labelStyle,
       );

  const SimpleBadge.primary({
    Key? key,
    required String label,
    IconData? icon,
    EdgeInsets? padding,
    FontWeight? labelWeight,
    TextStyle? labelStyle,
  }) : this._(
         key: key,
         label: label,
         variant: _SimpleBadgeVariant.primary,
         icon: icon,
         padding: padding,
         labelWeight: labelWeight,
         labelStyle: labelStyle,
       );

  const SimpleBadge.success({
    Key? key,
    required String label,
    IconData? icon,
    EdgeInsets? padding,
    FontWeight? labelWeight,
    TextStyle? labelStyle,
  }) : this._(
         key: key,
         label: label,
         variant: _SimpleBadgeVariant.success,
         icon: icon,
         padding: padding,
         labelWeight: labelWeight,
         labelStyle: labelStyle,
       );

  const SimpleBadge.warning({
    Key? key,
    required String label,
    IconData? icon,
    EdgeInsets? padding,
    FontWeight? labelWeight,
    TextStyle? labelStyle,
  }) : this._(
         key: key,
         label: label,
         variant: _SimpleBadgeVariant.warning,
         icon: icon,
         padding: padding,
         labelWeight: labelWeight,
         labelStyle: labelStyle,
       );

  const SimpleBadge.error({
    Key? key,
    required String label,
    IconData? icon,
    EdgeInsets? padding,
    FontWeight? labelWeight,
    TextStyle? labelStyle,
  }) : this._(
         key: key,
         label: label,
         variant: _SimpleBadgeVariant.error,
         icon: icon,
         padding: padding,
         labelWeight: labelWeight,
         labelStyle: labelStyle,
       );

  /// Solid-fill badge for strong emphasis: discount tags, count indicators, and
  /// any context where the tinted badge variants are visually insufficient.
  ///
  /// [color] is the solid background — typically a theme-resolved color such as
  /// [ColorScheme.error] for discount/alert contexts or [ColorScheme.primary]
  /// for count indicators.
  ///
  /// [foregroundColor] defaults to a luminance-computed white or black so
  /// contrast is maintained automatically when [color] is theme-derived.
  /// Pass an explicit value to override (e.g. [ColorScheme.onError]).
  ///
  /// [labelWeight] overrides the default [FontWeight.w600] label weight.
  /// [labelStyle] is merged into the label [TextStyle] before color and weight
  /// are applied — use it for compact layouts (e.g. `TextStyle(height: 1.0)`).
  const SimpleBadge.filled({
    Key? key,
    required String label,
    required Color color,
    Color? foregroundColor,
    IconData? icon,
    EdgeInsets? padding,
    FontWeight? labelWeight,
    TextStyle? labelStyle,
  }) : this._(
         key: key,
         label: label,
         variant: _SimpleBadgeVariant.filled,
         filledColor: color,
         filledForeground: foregroundColor,
         icon: icon,
         padding: padding,
         labelWeight: labelWeight,
         labelStyle: labelStyle,
       );

  final String label;
  final IconData? icon;
  final EdgeInsets? padding;

  /// Optional [FontWeight] for the badge label. Defaults to [FontWeight.w600].
  final FontWeight? labelWeight;

  /// Optional [TextStyle] merged into the label before color and weight are
  /// applied. Use for compact icon-corner badges: `TextStyle(height: 1.0)`.
  final TextStyle? labelStyle;

  final _SimpleBadgeVariant _variant;

  // Only used by the filled variant.
  final Color? _filledColor;
  final Color? _filledForeground;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final _SimpleBadgeColors colors = _resolveColors(theme);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(JDimens.dp24),
        border: Border.all(color: colors.border),
      ),
      child: Padding(
        padding:
            padding ??
            const EdgeInsets.symmetric(
              horizontal: JDimens.dp8,
              vertical: JDimens.dp4,
            ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (icon != null) ...<Widget>[
              Icon(icon, size: JIconSizes.xs, color: colors.foreground),
              JGaps.w8,
            ],
            SimpleText.label(
              text: label,
              color: colors.foreground,
              weight: labelWeight ?? FontWeight.w600,
              maxLines: 1,
              style: labelStyle,
            ),
          ],
        ),
      ),
    );
  }

  _SimpleBadgeColors _resolveColors(ThemeData theme) {
    final AppThemeTokens tokens = theme.appThemeTokens;
    final JStatusColors statusColors =
        theme.extension<JStatusColors>() ??
        JStatusColors.fallback(brightness: theme.brightness);
    final Color cardBackground = tokens.cardBackground;
    final Color cardBorderColor = tokens.cardBorderColor;

    switch (_variant) {
      case _SimpleBadgeVariant.neutral:
        return _SimpleBadgeColors(
          background: cardBackground,
          foreground: tokens.onCardResolved(theme),
          border: cardBorderColor,
        );
      case _SimpleBadgeVariant.primary:
        final Color primary = tokens.primary;
        return _SimpleBadgeColors(
          background: JTints.surface(cardBackground, primary, alpha: 22),
          foreground: primary,
          border: JTints.border(cardBorderColor, primary, alpha: 56),
        );
      case _SimpleBadgeVariant.success:
        final Color success = statusColors.success;
        return _SimpleBadgeColors(
          background: JTints.surface(cardBackground, success, alpha: 22),
          foreground: success,
          border: JTints.border(cardBorderColor, success, alpha: 56),
        );
      case _SimpleBadgeVariant.warning:
        final Color warning = statusColors.warning;
        return _SimpleBadgeColors(
          background: JTints.surface(cardBackground, warning, alpha: 24),
          foreground: warning,
          border: JTints.border(cardBorderColor, warning, alpha: 60),
        );
      case _SimpleBadgeVariant.error:
        final Color error = theme.colorScheme.error;
        return _SimpleBadgeColors(
          background: JTints.surface(cardBackground, error, alpha: 20),
          foreground: error,
          border: JTints.border(cardBorderColor, error, alpha: 56),
        );
      case _SimpleBadgeVariant.filled:
        final Color bg = _filledColor ?? theme.colorScheme.onSurface;
        return _SimpleBadgeColors(
          background: bg,
          foreground: _filledForeground ?? _computedForeground(bg),
          // Solid fill needs no additional border.
          border: Colors.transparent,
        );
    }
  }

  /// Luminance-based foreground default for filled badges: dark background →
  /// white, light background → black. Matches the contrast logic used by
  /// [AppThemeTokens._onColorForBackground].
  static Color _computedForeground(Color background) {
    return ThemeData.estimateBrightnessForColor(background) == Brightness.dark
        ? Colors.white
        : Colors.black;
  }
}

class _SimpleBadgeColors {
  const _SimpleBadgeColors({
    required this.background,
    required this.foreground,
    required this.border,
  });

  final Color background;
  final Color foreground;
  final Color border;
}
