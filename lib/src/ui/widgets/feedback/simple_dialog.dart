import 'package:flutter/material.dart' hide SimpleDialog;

import '../../resources/dimens.dart';
import '../controls/buttons/simple_button.dart';
import '../typography/simple_text.dart';

class SimpleDialog extends StatelessWidget {
  const SimpleDialog({
    super.key,
    this.title,
    this.message,
    this.content,
    this.confirmText = 'OK',
    this.cancelText,
    this.onConfirm,
    this.onCancel,
    this.barrierDismissible = true,
  });

  final String? title;
  final String? message;
  final Widget? content;
  final String confirmText;
  final String? cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool barrierDismissible;

  static Future<T?> show<T>(
    BuildContext context, {
    String? title,
    String? message,
    Widget? content,
    String confirmText = 'OK',
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext dialogContext) {
        return SimpleDialog(
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
    final Color textPrimary = theme.colorScheme.onSurface;
    final Color textSecondary = theme.colorScheme.onSurfaceVariant;
    final bool hasTitle = title != null && title!.trim().isNotEmpty;
    final Widget? resolvedContent = _buildContent(context, textSecondary);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(JDimens.dp16),
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
          label: confirmText,
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
}
