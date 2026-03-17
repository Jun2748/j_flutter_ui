import 'package:flutter/material.dart';

import '../../resources/dimens.dart';
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
    final ThemeData theme = Theme.of(context);
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
                if (action != null) ...<Widget>[JGaps.w16, action!],
              ],
            ),
            if (hasDescription) JGaps.h8 else JGaps.h16,
          ],
          if (hasDescription) ...<Widget>[
            SimpleText.caption(
              text: description!,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            JGaps.h16,
          ],
          child,
        ],
      ),
    );
  }
}
