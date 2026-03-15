import 'package:flutter/material.dart';

import '../../resources/colors.dart';
import '../../resources/dimens.dart';
import '../layout/gap.dart';
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
    final _SimpleBadgeColors colors = _resolveColors(context);

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
              Gap.w8,
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

  _SimpleBadgeColors _resolveColors(BuildContext context) {
    final Color border = JColors.getColor(context, lightKey: 'border');
    final Color textPrimary = JColors.getColor(
      context,
      lightKey: 'textPrimary',
    );

    switch (_variant) {
      case _SimpleBadgeVariant.neutral:
        return _SimpleBadgeColors(
          background: JColors.getColor(context, lightKey: 'surface'),
          foreground: textPrimary,
          border: border,
        );
      case _SimpleBadgeVariant.primary:
        final Color primary = JColors.getColor(context, lightKey: 'primary');
        return _SimpleBadgeColors(
          background: primary.withAlpha(22),
          foreground: primary,
          border: primary.withAlpha(56),
        );
      case _SimpleBadgeVariant.success:
        final Color success = JColors.getColor(context, lightKey: 'success');
        return _SimpleBadgeColors(
          background: success.withAlpha(22),
          foreground: success,
          border: success.withAlpha(56),
        );
      case _SimpleBadgeVariant.warning:
        final Color warning = JColors.getColor(context, lightKey: 'warning');
        return _SimpleBadgeColors(
          background: warning.withAlpha(24),
          foreground: warning,
          border: warning.withAlpha(60),
        );
      case _SimpleBadgeVariant.error:
        final Color error = JColors.getColor(context, lightKey: 'error');
        return _SimpleBadgeColors(
          background: error.withAlpha(20),
          foreground: error,
          border: error.withAlpha(56),
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
