import 'package:flutter/material.dart';

import '../../resources/app_theme_tokens.dart';
import '../../resources/colors.dart';
import '../../resources/dimens.dart';
import '../../resources/tinted_surface.dart';
import '../typography/simple_text.dart';

enum _SimpleSnackbarVariant { info, success, warning, error }

class SimpleSnackbar {
  const SimpleSnackbar._();

  static void showInfo(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    _show(
      context,
      variant: _SimpleSnackbarVariant.info,
      message: message,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }

  static void showSuccess(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    _show(
      context,
      variant: _SimpleSnackbarVariant.success,
      message: message,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }

  static void showWarning(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    _show(
      context,
      variant: _SimpleSnackbarVariant.warning,
      message: message,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }

  static void showError(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    _show(
      context,
      variant: _SimpleSnackbarVariant.error,
      message: message,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }

  static void _show(
    BuildContext context, {
    required _SimpleSnackbarVariant variant,
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final _SimpleSnackbarColors colors = _resolveColors(context, variant);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: colors.background,
        margin: JInsets.all16,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(JDimens.dp12),
          side: BorderSide(color: colors.border),
        ),
        content: SimpleText.body(
          text: message,
          color: colors.foreground,
          maxLines: 3,
        ),
        action: actionLabel != null && onAction != null
            ? SnackBarAction(
                label: actionLabel,
                textColor: colors.actionColor,
                onPressed: onAction,
              )
            : null,
      ),
    );
  }

  static _SimpleSnackbarColors _resolveColors(
    BuildContext context,
    _SimpleSnackbarVariant variant,
  ) {
    final ThemeData theme = Theme.of(context);
    final AppThemeTokens tokens = theme.appThemeTokens;
    final JStatusColors statusColors =
        theme.extension<JStatusColors>() ??
        JStatusColors.fallback(brightness: theme.brightness);
    final Color textPrimary = theme.colorScheme.onSurface;
    final Color cardBackground = tokens.cardBackground;
    final Color cardBorderColor = tokens.cardBorderColor;

    switch (variant) {
      case _SimpleSnackbarVariant.info:
        final Color info = statusColors.info;
        return _SimpleSnackbarColors(
          background: JTints.surface(cardBackground, info, alpha: 22),
          foreground: textPrimary,
          border: JTints.border(cardBorderColor, info, alpha: 48),
          actionColor: info,
        );
      case _SimpleSnackbarVariant.success:
        final Color success = statusColors.success;
        return _SimpleSnackbarColors(
          background: JTints.surface(cardBackground, success, alpha: 22),
          foreground: textPrimary,
          border: JTints.border(cardBorderColor, success, alpha: 48),
          actionColor: success,
        );
      case _SimpleSnackbarVariant.warning:
        final Color warning = statusColors.warning;
        return _SimpleSnackbarColors(
          background: JTints.surface(cardBackground, warning, alpha: 22),
          foreground: textPrimary,
          border: JTints.border(cardBorderColor, warning, alpha: 48),
          actionColor: warning,
        );
      case _SimpleSnackbarVariant.error:
        final Color error = theme.colorScheme.error;
        return _SimpleSnackbarColors(
          background: JTints.surface(cardBackground, error, alpha: 20),
          foreground: textPrimary,
          border: JTints.border(cardBorderColor, error, alpha: 48),
          actionColor: error,
        );
    }
  }
}

class _SimpleSnackbarColors {
  const _SimpleSnackbarColors({
    required this.background,
    required this.foreground,
    required this.border,
    required this.actionColor,
  });

  final Color background;
  final Color foreground;
  final Color border;
  final Color actionColor;
}
