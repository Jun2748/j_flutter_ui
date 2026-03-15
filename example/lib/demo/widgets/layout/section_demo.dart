import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class SectionDemo extends StatelessWidget {
  const SectionDemo({super.key});

  String get title => 'Section';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: title),
      body: const Section(
        title: 'Profile',
        child: SimpleCard(
          child: SimpleText.body(
            text: 'This section wraps a card with profile information.',
          ),
        ),
      ),
    );
  }
}
