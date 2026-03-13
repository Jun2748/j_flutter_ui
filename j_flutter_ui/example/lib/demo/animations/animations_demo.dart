import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class AnimationsDemo extends StatelessWidget {
  const AnimationsDemo({super.key});

  String get title => 'Animations';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarEx(title: 'Animations'),
      body: const Center(child: SimpleText.body(text: 'Animations')),
    );
  }
}
