import 'package:flutter/material.dart';

import '../../resources/colors.dart';
import '../../resources/dimens.dart';
import '../controls/buttons/simple_button.dart';
import '../layout/gap.dart';
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
            if (hasAction) ...<Widget>[
              Gap.h16,
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
    final IconData resolvedIcon = icon ?? Icons.inbox_outlined;
    final Color primary = JColors.getColor(context, lightKey: 'primary');

    return Container(
      width: JDimens.dp64,
      height: JDimens.dp64,
      decoration: BoxDecoration(
        color: primary.withAlpha(16),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Icon(resolvedIcon, size: JIconSizes.xl, color: primary),
    );
  }
}
