import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class ScaffoldDemo extends StatelessWidget {
  const ScaffoldDemo({super.key});

  String get title => 'Scaffold';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(
        title: title,
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: const Icon(Icons.tune_outlined)),
        ],
      ),
      bodyPadding: JInsets.screenPadding,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Create'),
        icon: const Icon(Icons.add),
      ),
      body: ListView(
        children: const <Widget>[
          Section(
            title: 'AppScaffold usage',
            child: SimpleCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SimpleText.body(
                    text:
                        'This page itself is built with AppScaffold and shows a shared app bar, body padding, safe area handling, and floating action button support.',
                  ),
                ],
              ),
            ),
          ),
          JGaps.h16,
          Section(
            title: 'Why use it',
            child: SimpleCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SimpleText.body(
                    text:
                        'Use AppScaffold to keep screen scaffolding consistent across the demo app and product screens.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
