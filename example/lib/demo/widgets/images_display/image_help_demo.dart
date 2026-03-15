import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class ImageHelpDemo extends StatelessWidget {
  const ImageHelpDemo({super.key});

  String get title => 'Images Helper Demo';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: title),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Images.svg(Svgs.search, width: 28, height: 28),
            const SizedBox(height: 8),
            const Text('Icon SVG using Images.svg(Svgs.search)'),
            const SizedBox(height: 32),
            Images.svg(Flags.malaysia, width: 28, height: 28),
            const SizedBox(height: 8),
            const Text('Flag SVG using Images.svg(Flags.malaysia)'),
            const SizedBox(height: 32),
            Images.svg(Illustrations.emptyState, width: 120),
            const SizedBox(height: 8),
            const Text('Illustration SVG using Images.svg'),
          ],
        ),
      ),
    );
  }
}
