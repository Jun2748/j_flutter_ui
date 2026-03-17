import 'package:flutter/material.dart';

import '../../resources/app_theme_tokens.dart';
import '../../resources/dimens.dart';
import '../controls/buttons/simple_button.dart';
import '../typography/simple_text.dart';

class SimpleEmptyState extends StatelessWidget {
  const SimpleEmptyState({
    super.key,
    this.illustration,
    this.icon,
    required this.title,
    this.message,
    this.actionLabel,
    this.onActionPressed,
    this.padding,
  });

  final Widget? illustration;
  final IconData? icon;
  final String title;
  final String? message;
  final String? actionLabel;
  final VoidCallback? onActionPressed;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final bool hasMessage = message != null && message!.trim().isNotEmpty;
    final bool hasAction =
        actionLabel != null &&
        actionLabel!.trim().isNotEmpty &&
        onActionPressed != null;
    final ThemeData theme = Theme.of(context);
    final AppThemeTokens tokens = AppThemeTokens.resolve(theme);

    return Center(
      child: Padding(
        padding: padding ?? JInsets.all24,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            illustration ?? _buildIcon(context),
            JGaps.h16,
            SimpleText.heading(text: title, align: TextAlign.center),
            if (hasMessage) ...<Widget>[
              JGaps.h8,
              SimpleText.body(
                text: message!,
                color: tokens.mutedText,
                align: TextAlign.center,
                maxLines: 4,
              ),
            ],
            if (hasAction) ...<Widget>[
              JGaps.h16,
              SimpleButton.primary(
                label: actionLabel!,
                onPressed: onActionPressed,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppThemeTokens tokens = AppThemeTokens.resolve(theme);
    final IconData resolvedIcon = icon ?? Icons.inbox_outlined;
    final Color primary = tokens.primary;
    final Color background = Color.alphaBlend(
      primary.withAlpha(16),
      tokens.cardBackground,
    );

    return Container(
      width: JDimens.dp64,
      height: JDimens.dp64,
      decoration: BoxDecoration(
        color: background,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Icon(resolvedIcon, size: JIconSizes.xl, color: primary),
    );
  }
}
