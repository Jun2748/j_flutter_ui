import 'package:flutter/material.dart';

import '../../resources/dimens.dart';
import '../controls/buttons/simple_button.dart';
import '../typography/simple_text.dart';

class SimpleErrorView extends StatelessWidget {
  const SimpleErrorView({
    super.key,
    this.illustration,
    this.icon,
    this.title = 'Something went wrong',
    this.message,
    this.retryLabel,
    this.onRetry,
    this.padding,
  });

  final Widget? illustration;
  final IconData? icon;
  final String title;
  final String? message;
  final String? retryLabel;
  final VoidCallback? onRetry;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final bool hasMessage = message != null && message!.trim().isNotEmpty;
    final bool hasRetry =
        retryLabel != null && retryLabel!.trim().isNotEmpty && onRetry != null;
    final ThemeData theme = Theme.of(context);

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
                color: theme.colorScheme.onSurfaceVariant,
                align: TextAlign.center,
                maxLines: 4,
              ),
            ],
            if (hasRetry) ...<Widget>[
              JGaps.h16,
              SimpleButton.primary(label: retryLabel!, onPressed: onRetry),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    final IconData resolvedIcon = icon ?? Icons.error_outline;
    final Color error = Theme.of(context).colorScheme.error;

    return Container(
      width: JDimens.dp64,
      height: JDimens.dp64,
      decoration: BoxDecoration(
        color: error.withAlpha(16),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Icon(resolvedIcon, size: JIconSizes.xl, color: error),
    );
  }
}
