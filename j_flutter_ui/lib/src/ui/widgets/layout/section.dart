import 'package:flutter/material.dart';

import '../../resources/dimens.dart';
import '../typography/simple_text.dart';
import 'gap.dart';

class Section extends StatelessWidget {
  const Section({
    super.key,
    this.title,
    this.action,
    required this.child,
    this.padding = JInsets.screenPadding,
  });

  final String? title;
  final Widget? action;
  final Widget? child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final bool hasHeader = title != null && title!.trim().isNotEmpty;

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (hasHeader) ...<Widget>[
            Row(
              children: <Widget>[
                Expanded(child: SimpleText.heading(text: title!, maxLines: 1)),
                if (action != null) ...<Widget>[Gap.w16, action!],
              ],
            ),
            Gap.h16,
          ],
          child ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
