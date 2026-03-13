import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class GapDemo extends StatelessWidget {
  const GapDemo({super.key});

  String get title => 'Gap';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarEx(title: title),
      body: Padding(
        padding: JInsets.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            SimpleText.body(text: 'Above Gap.h8'),
            Gap.h8,
            SimpleText.caption(text: 'After Gap.h8'),
            Gap.h16,
            SimpleText.body(text: 'Above Gap.h16'),
            Gap.h16,
            SimpleText.caption(text: 'After Gap.h16'),
            Gap.h24,
            SimpleText.body(text: 'Above Gap.h24'),
            Gap.h24,
            SimpleText.caption(text: 'After Gap.h24'),
          ],
        ),
      ),
    );
  }
}
