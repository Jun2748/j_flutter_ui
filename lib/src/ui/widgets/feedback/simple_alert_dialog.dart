import 'package:flutter/material.dart';

import '../../localization/intl.dart';
import '../../localization/l.dart';
import '../../resources/app_theme_tokens.dart';
import '../../resources/dimens.dart';
import '../controls/buttons/simple_button.dart';
import '../typography/simple_text.dart';

class SimpleAlertDialog extends StatelessWidget {
  const SimpleAlertDialog({
    super.key,
    this.title,
    this.message,
    this.content,
    this.confirmText,
    this.cancelText,
    this.onConfirm,
    this.onCancel,
    this.barrierDismissible = true,
  });

  final String? title;
  final String? message;
  final Widget? content;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool barrierDismissible;

  static Future<T?> show<T>(
    BuildContext context, {
    String? title,
    String? message,
    Widget? content,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext dialogContext) {
        return SimpleAlertDialog(
          title: title,
          message: message,
          content: content,
          confirmText: confirmText,
          cancelText: cancelText,
          onConfirm: onConfirm,
          onCancel: onCancel,
          barrierDismissible: barrierDismissible,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppThemeTokens tokens = theme.appThemeTokens;
    final DialogThemeData dialogTheme = theme.dialogTheme;
    final Color textPrimary = tokens.onCardResolved(theme);
    final Color textSecondary = tokens.mutedText;
    final bool hasTitle = title != null && title!.trim().isNotEmpty;
    final Widget? resolvedContent = _buildContent(context, textSecondary);
    final String resolvedConfirmText = _resolveConfirmText(context);

    return AlertDialog(
      backgroundColor: dialogTheme.backgroundColor ?? tokens.cardBackground,
      surfaceTintColor: dialogTheme.surfaceTintColor ?? Colors.transparent,
      shape:
          dialogTheme.shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(JDimens.dp16),
            side: BorderSide(color: tokens.cardBorderColor),
          ),
      titlePadding: const EdgeInsets.fromLTRB(
        JDimens.dp24,
        JDimens.dp24,
        JDimens.dp24,
        JDimens.dp8,
      ),
      contentPadding: const EdgeInsets.fromLTRB(
        JDimens.dp24,
        JDimens.dp8,
        JDimens.dp24,
        JDimens.dp16,
      ),
      actionsPadding: const EdgeInsets.fromLTRB(
        JDimens.dp16,
        JDimens.dp0,
        JDimens.dp16,
        JDimens.dp16,
      ),
      title: hasTitle
          ? SimpleText.heading(text: title!, color: textPrimary, maxLines: 2)
          : null,
      content: resolvedContent,
      actions: <Widget>[
        if (cancelText != null)
          SimpleButton.secondary(
            label: cancelText!,
            onPressed: () {
              Navigator.of(context).pop();
              onCancel?.call();
            },
          ),
        SimpleButton.primary(
          label: resolvedConfirmText,
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm?.call();
          },
        ),
      ],
    );
  }

  Widget? _buildContent(BuildContext context, Color textSecondary) {
    if (content != null) {
      return content;
    }

    if (message == null || message!.trim().isEmpty) {
      return null;
    }

    return SimpleText.body(text: message!, color: textSecondary, maxLines: 6);
  }

  String _resolveConfirmText(BuildContext context) {
    final String? customLabel = confirmText?.trim();
    if (customLabel != null && customLabel.isNotEmpty) {
      return customLabel;
    }

    final String localizedLabel = Intl.text(L.commonOkay, context: context);
    if (localizedLabel.isNotEmpty && localizedLabel != L.commonOkay) {
      return localizedLabel;
    }

    return 'Okay';
  }
}
