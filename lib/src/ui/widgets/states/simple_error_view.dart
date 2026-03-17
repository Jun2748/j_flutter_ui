import 'package:flutter/material.dart';

import '../../localization/intl.dart';
import '../../localization/l.dart';
import '../../resources/app_theme_tokens.dart';
import '../../resources/dimens.dart';
import '../controls/buttons/simple_button.dart';
import '../typography/simple_text.dart';

class SimpleErrorView extends StatelessWidget {
  const SimpleErrorView({
    super.key,
    this.illustration,
    this.icon,
    this.title = '',
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
    final AppThemeTokens tokens = AppThemeTokens.resolve(theme);

    return Center(
      child: Padding(
        padding: padding ?? JInsets.all24,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            illustration ?? _buildIcon(context),
            JGaps.h16,
            SimpleText.heading(
              text: _resolveTitle(context),
              align: TextAlign.center,
            ),
            if (hasMessage) ...<Widget>[
              JGaps.h8,
              SimpleText.body(
                text: message!,
                color: tokens.mutedText,
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

  String _resolveTitle(BuildContext context) {
    final String customTitle = title.trim();
    if (customTitle.isNotEmpty) {
      return customTitle;
    }

    final String localizedTitle = Intl.text(L.stateErrorTitle, context: context);
    if (localizedTitle.isNotEmpty && localizedTitle != L.stateErrorTitle) {
      return localizedTitle;
    }

    return 'Something went wrong';
  }
}
