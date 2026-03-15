import 'package:flutter/material.dart';

import '../../resources/colors.dart';
import '../../resources/dimens.dart';
import '../layout/gap.dart';
import '../typography/simple_text.dart';

class FormSection extends StatelessWidget {
  const FormSection({
    super.key,
    this.title,
    this.description,
    required this.child,
    this.padding = JInsets.all16,
    this.action,
  });

  final String? title;
  final String? description;
  final Widget child;
  final EdgeInsets padding;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final bool hasTitle = title != null && title!.trim().isNotEmpty;
    final bool hasDescription =
        description != null && description!.trim().isNotEmpty;

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (hasTitle) ...<Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(child: SimpleText.heading(text: title!, maxLines: 2)),
                if (action != null) ...<Widget>[action!],
              ],
            ),
            if (hasDescription) Gap.h8 else Gap.h16,
          ],
          if (hasDescription) ...<Widget>[
            SimpleText.caption(
              text: description!,
              color: JColors.getColor(context, lightKey: 'textSecondary'),
            ),
            Gap.h16,
          ],
          child,
        ],
      ),
    );
  }
}
