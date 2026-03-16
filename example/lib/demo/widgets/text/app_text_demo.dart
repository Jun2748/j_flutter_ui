import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class AppTextDemo extends StatelessWidget {
  const AppTextDemo({super.key});

  String get title => 'AppText';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: title),
      bodyPadding: JInsets.screenPadding,
      body: ListView(
        children: <Widget>[
          const _DemoCard(
            title: 'Raw AppText',
            child: AppText(text: 'This is raw AppText content.'),
          ),
          JGaps.h16,
          const _DemoCard(
            title: 'Localized AppText',
            child: AppText(
              localeKey: L.commonWelcome,
              args: <String, String>{'name': 'Developer'},
            ),
          ),
          JGaps.h16,
          const _DemoCard(
            title: 'AppText with HTML',
            child: AppText(
              text: 'This is <strong>bold</strong> and <em>italic</em> HTML.',
              useHtml: true,
            ),
          ),
          JGaps.h16,
          const _DemoCard(
            title: 'Localized AppText with HTML',
            child: AppText(localeKey: L.demoHtmlLocalized, useHtml: true),
          ),
          JGaps.h16,
          _DemoCard(
            title: 'Intl.text helper',
            child: VStack(
              gap: JDimens.dp16,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AppText(text: Intl.text(L.commonConfirm)),
                SimpleButton.text(
                  label: Intl.text(L.commonCancel),
                  onPressed: () {},
                ),
                SimpleTextField(
                  labelText: Intl.text(L.loginPhone),
                  hintText: Intl.text(L.commonOkay),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DemoCard extends StatelessWidget {
  const _DemoCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SimpleCard(
      child: Padding(
        padding: JInsets.card,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SimpleText.label(text: title),
            JGaps.h8,
            child,
          ],
        ),
      ),
    );
  }
}
