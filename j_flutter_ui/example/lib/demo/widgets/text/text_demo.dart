import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class TextDemo extends StatelessWidget {
  const TextDemo({super.key});

  String get title => 'Text';

  @override
  Widget build(BuildContext context) {
    final Color primary = JColors.getColor(context, lightKey: 'primary');
    final Color success = JColors.getColor(context, lightKey: 'success');
    final Color error = JColors.getColor(context, lightKey: 'error');

    return AppScaffold(
      appBar: AppBarEx(title: title),
      body: ListView(
        padding: JInsets.screenPadding,
        children: <Widget>[
          const Section(
            title: 'Typography scale',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SimpleText.title(text: 'SimpleText.title'),
                Gap.h16,
                SimpleText.heading(text: 'SimpleText.heading'),
                Gap.h16,
                SimpleText.body(text: 'SimpleText.body'),
                Gap.h16,
                SimpleText.caption(text: 'SimpleText.caption'),
                Gap.h16,
                SimpleText.label(text: 'SimpleText.label'),
              ],
            ),
          ),
          Gap.h24,
          Section(
            title: 'Color usage',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SimpleText.body(text: 'Primary emphasis', color: primary),
                const Gap.h(JDimens.dp12),
                SimpleText.body(text: 'Success status', color: success),
                const Gap.h(JDimens.dp12),
                SimpleText.body(text: 'Error status', color: error),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
