import 'package:flutter/material.dart';

import '../../resources/colors.dart';
import '../../resources/dimens.dart';
import '../layout/gap.dart';
import '../typography/simple_text.dart';

class SimpleLoadingView extends StatelessWidget {
  const SimpleLoadingView({super.key, this.message, this.padding});

  final String? message;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final bool hasMessage = message != null && message!.trim().isNotEmpty;

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
                color: JColors.getColor(context, lightKey: 'primary'),
              ),
            ),
            if (hasMessage) ...<Widget>[
              Gap.h16,
              SimpleText.body(
                text: message!,
                color: JColors.getColor(context, lightKey: 'textSecondary'),
                align: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
