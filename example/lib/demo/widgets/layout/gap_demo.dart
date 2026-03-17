import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class GapDemo extends StatelessWidget {
  const GapDemo({super.key});

  String get title => 'JGaps';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: title),
      bodyPadding: JInsets.screenPadding,
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SimpleText.body(text: 'Above JGaps.h8'),
          JGaps.h8,
          SimpleText.caption(text: 'After JGaps.h8'),
          JGaps.h16,
          SimpleText.body(text: 'Above JGaps.h16'),
          JGaps.h16,
          SimpleText.caption(text: 'After JGaps.h16'),
          JGaps.h24,
          SimpleText.body(text: 'Above JGaps.h24'),
          JGaps.h24,
          SimpleText.caption(text: 'After JGaps.h24'),
        ],
      ),
    );
  }
}
