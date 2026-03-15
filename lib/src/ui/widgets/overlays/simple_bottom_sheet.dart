import 'package:flutter/material.dart';

import '../../resources/colors.dart';
import '../../resources/dimens.dart';
import '../layout/gap.dart';
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
    final Color card = JColors.getColor(context, lightKey: 'card');
    final Color border = JColors.getColor(context, lightKey: 'border');
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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(JDimens.dp24)),
      ),
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
                        color: border,
                        borderRadius: BorderRadius.circular(JDimens.dp12),
                      ),
                    ),
                  ),
                if (titleText != null) ...<Widget>[
                  SimpleText.heading(text: titleText),
                  Gap.h8,
                ],
                if (messageText != null) ...<Widget>[
                  SimpleText.caption(
                    text: messageText,
                    color: JColors.getColor(
                      bottomSheetContext,
                      lightKey: 'textSecondary',
                    ),
                    maxLines: 4,
                  ),
                  Gap.h16,
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
