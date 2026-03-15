import 'package:flutter/material.dart';

import '../../resources/colors.dart';
import '../../resources/dimens.dart';
import '../controls/buttons/simple_button.dart';
import '../layout/gap.dart';
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

    return Center(
      child: Padding(
        padding: padding ?? JInsets.all24,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            illustration ?? _buildIcon(context),
            Gap.h16,
            SimpleText.heading(text: title, align: TextAlign.center),
            if (hasMessage) ...<Widget>[
              Gap.h8,
              SimpleText.body(
                text: message!,
                color: JColors.getColor(context, lightKey: 'textSecondary'),
                align: TextAlign.center,
                maxLines: 4,
              ),
            ],
            if (hasRetry) ...<Widget>[
              Gap.h16,
              SimpleButton.primary(label: retryLabel!, onPressed: onRetry),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    final IconData resolvedIcon = icon ?? Icons.error_outline;
    final Color error = JColors.getColor(context, lightKey: 'error');

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
