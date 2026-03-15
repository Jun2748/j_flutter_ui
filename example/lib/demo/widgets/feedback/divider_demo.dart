import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class DividerDemo extends StatelessWidget {
  const DividerDemo({super.key});

  String get title => 'Divider';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: title),
      body: ListView(
        padding: JInsets.screenPadding,
        children: const <Widget>[
          SimpleText.body(text: 'Content above default divider'),
          SimpleDivider(),
          SimpleText.body(text: 'Content between dividers'),
          SimpleDivider(
            thickness: 2,
            indent: JDimens.dp16,
            endIndent: JDimens.dp16,
          ),
          SimpleText.body(text: 'Content below custom divider'),
        ],
      ),
    );
  }
}
