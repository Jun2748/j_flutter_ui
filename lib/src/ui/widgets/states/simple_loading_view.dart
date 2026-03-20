import 'package:flutter/material.dart';

import '../../resources/app_theme_tokens.dart';
import '../../resources/dimens.dart';
import '../typography/simple_text.dart';

class SimpleLoadingView extends StatelessWidget {
  const SimpleLoadingView({super.key, this.message, this.padding});

  final String? message;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final bool hasMessage = message != null && message!.trim().isNotEmpty;
    final ThemeData theme = Theme.of(context);
    final AppThemeTokens tokens = theme.appThemeTokens;
    final ProgressIndicatorThemeData progressTheme =
        theme.progressIndicatorTheme;

    return Center(
      child: Padding(
        padding: padding ?? JInsets.all24,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: JDimens.dp32,
              height: JDimens.dp32,
              child: CircularProgressIndicator(
                strokeWidth: JDimens.dp2,
                color: progressTheme.color ?? tokens.primary,
              ),
            ),
            if (hasMessage) ...<Widget>[
              JGaps.h16,
              SimpleText.body(
                text: message!,
                color: tokens.mutedText,
                align: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
