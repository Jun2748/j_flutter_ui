import 'package:flutter/material.dart';

import '../../resources/app_theme_tokens.dart';
import '../../resources/dimens.dart';
import '../typography/simple_text.dart';

class SimpleBottomSheet {
  const SimpleBottomSheet._();

  static Future<T?> show<T>(
    BuildContext context, {
    String? title,
    String? message,
    required Widget child,
    bool isScrollControlled = true,
    bool showHandle = true,
    EdgeInsets? padding,
  }) {
    final ThemeData theme = Theme.of(context);
    final AppThemeTokens tokens = theme.appThemeTokens;
    final BottomSheetThemeData bottomSheetTheme = theme.bottomSheetTheme;
    final Color card =
        bottomSheetTheme.modalBackgroundColor ??
        bottomSheetTheme.backgroundColor ??
        tokens.cardBackground;
    final Color border = tokens.cardBorderColor;
    final Color handleColor =
        bottomSheetTheme.dragHandleColor ?? tokens.dividerColor;
    final Color messageColor = tokens.mutedText;
    final ShapeBorder sheetShape =
        bottomSheetTheme.shape ??
        RoundedRectangleBorder(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(JDimens.dp24),
          ),
          side: BorderSide(color: border),
        );
    final String? titleText = title != null && title.trim().isNotEmpty
        ? title
        : null;
    final String? messageText = message != null && message.trim().isNotEmpty
        ? message
        : null;

    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      backgroundColor: card,
      shape: sheetShape,
      builder: (BuildContext bottomSheetContext) {
        return SafeArea(
          top: false,
          child: Padding(
            padding: padding ?? JInsets.all16,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (showHandle)
                  Center(
                    child: Container(
                      key: const ValueKey<String>('simple_bottom_sheet_handle'),
                      width: JDimens.dp40,
                      height: JDimens.dp4,
                      margin: const EdgeInsets.only(bottom: JDimens.dp16),
                      decoration: BoxDecoration(
                        color: handleColor,
                        borderRadius: BorderRadius.circular(JDimens.dp12),
                      ),
                    ),
                  ),
                if (titleText != null) ...<Widget>[
                  SimpleText.heading(text: titleText),
                  JGaps.h8,
                ],
                if (messageText != null) ...<Widget>[
                  SimpleText.caption(
                    text: messageText,
                    color: messageColor,
                    maxLines: 4,
                  ),
                  JGaps.h16,
                ],
                child,
              ],
            ),
          ),
        );
      },
    );
  }
}
