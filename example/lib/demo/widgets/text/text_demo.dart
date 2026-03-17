import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class TextDemo extends StatelessWidget {
  const TextDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    String tr(String key) => Intl.text(key, context: context);
    final Color primary = theme.colorScheme.primary;
    final Color success =
        theme.extension<JStatusColors>()?.success ?? theme.colorScheme.tertiary;
    final Color error = theme.colorScheme.error;

    return AppScaffold(
      appBar: AppBarEx(title: tr(L.demoTextTitle)),
      body: ListView(
        padding: JInsets.screenPadding,
        children: <Widget>[
          Section(
            title: tr(L.demoTextScaleTitle),
            child: VStack(
              gap: JDimens.dp16,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SimpleText.title(text: tr(L.demoTextTitleSample)),
                SimpleText.heading(text: tr(L.demoTextHeadingSample)),
                SimpleText.body(text: tr(L.demoTextBodySample)),
                SimpleText.caption(text: tr(L.demoTextCaptionSample)),
                SimpleText.label(text: tr(L.demoTextLabelSample)),
              ],
            ),
          ),
          JGaps.h24,
          Section(
            title: tr(L.demoTextColorsTitle),
            child: VStack(
              gap: JDimens.dp12,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SimpleText.body(
                  text: tr(L.demoTextPrimaryLabel),
                  color: primary,
                ),
                SimpleText.body(
                  text: tr(L.demoTextSuccessLabel),
                  color: success,
                ),
                SimpleText.body(text: tr(L.demoTextErrorLabel), color: error),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
