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
        children: const <Widget>[
          _DemoCard(
            title: 'Raw AppText',
            child: AppText(text: 'This is raw AppText content.'),
          ),
          JGaps.h16,
          _DemoCard(
            title: 'Localized AppText',
            child: AppText(
              localeKey: 'common.welcome',
              args: <String, String>{'name': 'Developer'},
            ),
          ),
          JGaps.h16,
          _DemoCard(
            title: 'AppText with HTML',
            child: AppText(
              text: 'This is <strong>bold</strong> and <em>italic</em> HTML.',
              useHtml: true,
            ),
          ),
          JGaps.h16,
          _DemoCard(
            title: 'Localized AppText with HTML',
            child: AppText(
              localeKey: 'demo.html.localized',
              useHtml: true,
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
