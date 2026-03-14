import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class TabsDemo extends StatelessWidget {
  const TabsDemo({super.key});

  String get title => 'Tabs';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: title),
      body: Padding(
        padding: JInsets.screenPadding,
        child: SizedBox(
          height: 320,
          child: SimpleTabs(
            tabs: const <Tab>[
              Tab(text: 'Details'),
              Tab(text: 'History'),
              Tab(text: 'Notes'),
            ],
            children: const <Widget>[
              Center(child: SimpleText.body(text: 'Details content')),
              Center(child: SimpleText.body(text: 'History content')),
              Center(child: SimpleText.body(text: 'Notes content')),
            ],
          ),
        ),
      ),
    );
  }
}
