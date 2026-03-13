import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class TextDemo extends StatelessWidget {
  const TextDemo({super.key});

  String get title => 'Text';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarEx(title: title),
      body: Padding(
        padding: JInsets.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
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
    );
  }
}
