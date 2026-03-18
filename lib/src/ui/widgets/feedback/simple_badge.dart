import 'package:flutter/material.dart';

import '../../resources/app_theme_tokens.dart';
import '../../resources/colors.dart';
import '../../resources/dimens.dart';
import '../typography/simple_text.dart';

enum _SimpleBadgeVariant { neutral, primary, success, warning, error }

class SimpleBadge extends StatelessWidget {
  const SimpleBadge._({
    super.key,
    required this.label,
    required _SimpleBadgeVariant variant,
    this.icon,
    this.padding,
  }) : _variant = variant;

  const SimpleBadge.neutral({
    Key? key,
    required String label,
    IconData? icon,
    EdgeInsets? padding,
  }) : this._(
         key: key,
         label: label,
         variant: _SimpleBadgeVariant.neutral,
         icon: icon,
         padding: padding,
       );

  const SimpleBadge.primary({
    Key? key,
    required String label,
    IconData? icon,
    EdgeInsets? padding,
  }) : this._(
         key: key,
         label: label,
         variant: _SimpleBadgeVariant.primary,
         icon: icon,
         padding: padding,
       );

  const SimpleBadge.success({
    Key? key,
    required String label,
    IconData? icon,
    EdgeInsets? padding,
  }) : this._(
         key: key,
         label: label,
         variant: _SimpleBadgeVariant.success,
         icon: icon,
         padding: padding,
       );

  const SimpleBadge.warning({
    Key? key,
    required String label,
    IconData? icon,
    EdgeInsets? padding,
  }) : this._(
         key: key,
         label: label,
         variant: _SimpleBadgeVariant.warning,
         icon: icon,
         padding: padding,
       );

  const SimpleBadge.error({
    Key? key,
    required String label,
    IconData? icon,
    EdgeInsets? padding,
  }) : this._(
         key: key,
         label: label,
         variant: _SimpleBadgeVariant.error,
         icon: icon,
         padding: padding,
       );

  final String label;
  final IconData? icon;
  final EdgeInsets? padding;
  final _SimpleBadgeVariant _variant;

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
              weight: FontWeight.w600,
              maxLines: 1,
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
    final Color textPrimary = theme.colorScheme.onSurface;
    final Color cardBackground = tokens.cardBackground;
    final Color cardBorderColor = tokens.cardBorderColor;

    switch (_variant) {
      case _SimpleBadgeVariant.neutral:
        return _SimpleBadgeColors(
          background: cardBackground,
          foreground: textPrimary,
          border: cardBorderColor,
        );
      case _SimpleBadgeVariant.primary:
        final Color primary = theme.colorScheme.primary;
        return _SimpleBadgeColors(
          background: Color.alphaBlend(primary.withAlpha(22), cardBackground),
          foreground: primary,
          border: Color.alphaBlend(primary.withAlpha(56), cardBorderColor),
        );
      case _SimpleBadgeVariant.success:
        final Color success = statusColors.success;
        return _SimpleBadgeColors(
          background: Color.alphaBlend(success.withAlpha(22), cardBackground),
          foreground: success,
          border: Color.alphaBlend(success.withAlpha(56), cardBorderColor),
        );
      case _SimpleBadgeVariant.warning:
        final Color warning = statusColors.warning;
        return _SimpleBadgeColors(
          background: Color.alphaBlend(warning.withAlpha(24), cardBackground),
          foreground: warning,
          border: Color.alphaBlend(warning.withAlpha(60), cardBorderColor),
        );
      case _SimpleBadgeVariant.error:
        final Color error = theme.colorScheme.error;
        return _SimpleBadgeColors(
          background: Color.alphaBlend(error.withAlpha(20), cardBackground),
          foreground: error,
          border: Color.alphaBlend(error.withAlpha(56), cardBorderColor),
        );
    }
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
