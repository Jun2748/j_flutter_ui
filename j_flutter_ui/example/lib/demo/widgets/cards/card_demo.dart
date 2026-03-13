import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class CardDemo extends StatelessWidget {
  const CardDemo({super.key});

  String get title => 'Cards';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarEx(title: title),
      body: Padding(
        padding: JInsets.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SimpleCard(child: SimpleText.body(text: 'Example card')),
            Gap.h16,
            SimpleCard(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Clickable card tapped')),
                );
              },
              child: const SimpleText.body(text: 'Tap this card'),
            ),
          ],
        ),
      ),
    );
  }
}
