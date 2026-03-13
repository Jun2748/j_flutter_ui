import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class ButtonDemo extends StatelessWidget {
  const ButtonDemo({super.key});

  String get title => 'Buttons';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarEx(title: title),
      body: Padding(
        padding: JInsets.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SimpleButton.primary(label: 'Primary Button', onPressed: () {}),
            Gap.h16,
            SimpleButton.secondary(label: 'Secondary Button', onPressed: () {}),
            Gap.h16,
            SimpleButton.outline(label: 'Outline Button', onPressed: () {}),
            Gap.h16,
            SimpleButton.text(label: 'Text Button', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
