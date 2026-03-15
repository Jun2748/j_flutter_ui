import 'package:flutter/material.dart';

import '../../resources/colors.dart';
import '../../resources/dimens.dart';
import '../layout/gap.dart';
import '../typography/simple_text.dart';

enum _SimpleBannerVariant { info, success, warning, error }

class SimpleBanner extends StatelessWidget {
  const SimpleBanner._({
    super.key,
    required this.title,
    required _SimpleBannerVariant variant,
    this.message,
    this.action,
    this.onDismiss,
    this.icon,
  }) : _variant = variant;

  const SimpleBanner.info({
    Key? key,
    required String title,
    String? message,
    Widget? action,
    VoidCallback? onDismiss,
    IconData? icon,
  }) : this._(
         key: key,
         title: title,
         variant: _SimpleBannerVariant.info,
         message: message,
         action: action,
         onDismiss: onDismiss,
         icon: icon,
       );

  const SimpleBanner.success({
    Key? key,
    required String title,
    String? message,
    Widget? action,
    VoidCallback? onDismiss,
    IconData? icon,
  }) : this._(
         key: key,
         title: title,
         variant: _SimpleBannerVariant.success,
         message: message,
         action: action,
         onDismiss: onDismiss,
         icon: icon,
       );

  const SimpleBanner.warning({
    Key? key,
    required String title,
    String? message,
    Widget? action,
    VoidCallback? onDismiss,
    IconData? icon,
  }) : this._(
         key: key,
         title: title,
         variant: _SimpleBannerVariant.warning,
         message: message,
         action: action,
         onDismiss: onDismiss,
         icon: icon,
       );

  const SimpleBanner.error({
    Key? key,
    required String title,
    String? message,
    Widget? action,
    VoidCallback? onDismiss,
    IconData? icon,
  }) : this._(
         key: key,
         title: title,
         variant: _SimpleBannerVariant.error,
         message: message,
         action: action,
         onDismiss: onDismiss,
         icon: icon,
       );

  final String title;
  final String? message;
  final Widget? action;
  final VoidCallback? onDismiss;
  final IconData? icon;
  final _SimpleBannerVariant _variant;

  @override
  Widget build(BuildContext context) {
    final _SimpleBannerColors colors = _resolveColors(context);
    final IconData resolvedIcon = icon ?? _resolveIcon();
    final bool hasMessage = message != null && message!.trim().isNotEmpty;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(JDimens.dp16),
        border: Border.all(color: colors.border),
      ),
      child: Padding(
        padding: JInsets.all16,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: JDimens.dp32,
              height: JDimens.dp32,
              decoration: BoxDecoration(
                color: colors.foreground.withAlpha(22),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(
                resolvedIcon,
                size: JIconSizes.md,
                color: colors.foreground,
              ),
            ),
            Gap.w16,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SimpleText.body(
                    text: title,
                    color: colors.titleColor,
                    weight: FontWeight.w700,
                    maxLines: 2,
                  ),
                  if (hasMessage) ...<Widget>[
                    Gap.h8,
                    SimpleText.caption(
                      text: message!,
                      color: colors.messageColor,
                      maxLines: 4,
                    ),
                  ],
                  if (action != null) ...<Widget>[
                    Gap.h8,
                    Align(alignment: Alignment.centerLeft, child: action!),
                  ],
                ],
              ),
            ),
            if (onDismiss != null) ...<Widget>[
              Gap.w8,
              IconButton(
                visualDensity: VisualDensity.compact,
                splashRadius: JDimens.dp20,
                onPressed: onDismiss,
                icon: Icon(
                  Icons.close,
                  size: JIconSizes.md,
                  color: colors.messageColor,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData _resolveIcon() {
    switch (_variant) {
      case _SimpleBannerVariant.info:
        return Icons.info_outline;
      case _SimpleBannerVariant.success:
        return Icons.check_circle_outline;
      case _SimpleBannerVariant.warning:
        return Icons.warning_amber_rounded;
      case _SimpleBannerVariant.error:
        return Icons.error_outline;
    }
  }

  _SimpleBannerColors _resolveColors(BuildContext context) {
    final Color textPrimary = JColors.getColor(
      context,
      lightKey: 'textPrimary',
    );
    final Color textSecondary = JColors.getColor(
      context,
      lightKey: 'textSecondary',
    );

    switch (_variant) {
      case _SimpleBannerVariant.info:
        final Color info = JColors.getColor(context, lightKey: 'info');
        return _SimpleBannerColors(
          background: info.withAlpha(16),
          border: info.withAlpha(48),
          foreground: info,
          titleColor: textPrimary,
          messageColor: textSecondary,
        );
      case _SimpleBannerVariant.success:
        final Color success = JColors.getColor(context, lightKey: 'success');
        return _SimpleBannerColors(
          background: success.withAlpha(16),
          border: success.withAlpha(48),
          foreground: success,
          titleColor: textPrimary,
          messageColor: textSecondary,
        );
      case _SimpleBannerVariant.warning:
        final Color warning = JColors.getColor(context, lightKey: 'warning');
        return _SimpleBannerColors(
          background: warning.withAlpha(16),
          border: warning.withAlpha(48),
          foreground: warning,
          titleColor: textPrimary,
          messageColor: textSecondary,
        );
      case _SimpleBannerVariant.error:
        final Color error = JColors.getColor(context, lightKey: 'error');
        return _SimpleBannerColors(
          background: error.withAlpha(16),
          border: error.withAlpha(48),
          foreground: error,
          titleColor: textPrimary,
          messageColor: textSecondary,
        );
    }
  }
}

class _SimpleBannerColors {
  const _SimpleBannerColors({
    required this.background,
    required this.border,
    required this.foreground,
    required this.titleColor,
    required this.messageColor,
  });

  final Color background;
  final Color border;
  final Color foreground;
  final Color titleColor;
  final Color messageColor;
}
