import 'package:flutter/material.dart';

import '../../resources/app_theme_tokens.dart';
import '../../resources/dimens.dart';
import '../../resources/styles.dart';
import '../layout/v_stack.dart';
import '../typography/simple_text.dart';

const ValueKey<String> _barrierKey = ValueKey<String>(
  'simple_progress_overlay_barrier',
);
const ValueKey<String> _cardKey = ValueKey<String>(
  'simple_progress_overlay_card',
);

class SimpleProgressOverlay extends StatelessWidget {
  const SimpleProgressOverlay({
    super.key,
    this.indicator,
    this.message,
    this.barrierColor,
    this.cardColor,
    this.cardPadding,
    this.cardBorderRadius,
    this.messageStyle,
  });

  /// Custom loading indicator widget (for example a spinner or branded
  /// animation). When omitted, a token-aware [CircularProgressIndicator]
  /// renders as the default.
  final Widget? indicator;

  /// Optional supporting message shown below the indicator.
  final String? message;

  /// Optional full-screen scrim color. When null, a strong neutral fallback
  /// scrim is used so the overlay reads clearly above arbitrary app content.
  final Color? barrierColor;

  /// Optional centered card surface color. Defaults to transparent so only the
  /// indicator and message render above the barrier by default.
  final Color? cardColor;

  /// Optional card padding. Defaults to [JInsets.all32].
  final EdgeInsetsGeometry? cardPadding;

  /// Optional rounded card radius. Defaults to [JDimens.dp24] when a custom
  /// [cardColor] is provided.
  final double? cardBorderRadius;

  /// Optional message text style. Defaults to body-medium sizing with muted
  /// token color for secondary supporting text.
  final TextStyle? messageStyle;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppThemeTokens tokens = theme.appThemeTokens;
    final ProgressIndicatorThemeData progressTheme =
        theme.progressIndicatorTheme;
    final Color resolvedBarrierColor =
        barrierColor ??
        // Neutral fallback scrim for apps that do not provide an explicit
        // overlay barrier color.
        Colors.black.withAlpha(180);
    final Color resolvedCardColor = cardColor ?? Colors.transparent;
    final EdgeInsetsGeometry resolvedCardPadding = cardPadding ?? JInsets.all32;
    final BorderRadius? resolvedCardBorderRadius = cardColor != null
        ? BorderRadius.circular(cardBorderRadius ?? JDimens.dp24)
        : null;
    final TextStyle resolvedMessageStyle =
        messageStyle ??
        (theme.textTheme.bodyMedium ?? JTextStyles.body2).copyWith(
          color: tokens.mutedText,
        );
    final Widget resolvedIndicator =
        indicator ??
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            progressTheme.color ?? tokens.primary,
          ),
          strokeWidth: JDimens.dp3,
        );

    return AbsorbPointer(
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: ColoredBox(key: _barrierKey, color: resolvedBarrierColor),
          ),
          Positioned.fill(
            child: Center(
              child: Container(
                key: _cardKey,
                constraints: const BoxConstraints(minWidth: JDimens.dp160),
                padding: resolvedCardPadding,
                decoration: BoxDecoration(
                  color: resolvedCardColor,
                  borderRadius: resolvedCardBorderRadius,
                ),
                child: VStack(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    resolvedIndicator,
                    if (message != null) ...<Widget>[
                      JGaps.h24,
                      SimpleText.body(
                        text: message,
                        style: resolvedMessageStyle,
                        color: resolvedMessageStyle.color,
                        align: TextAlign.center,
                        maxLines: 4,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
