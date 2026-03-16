import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class ImageHelperDemo extends StatelessWidget {
  const ImageHelperDemo({super.key});

  String get title => 'Images Helper';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: title),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Images.svg(UiIcons.search, width: 28, height: 28),
            JGaps.h8,
            const Text('Icon SVG using Images.svg(UiIcons.search)'),
            JGaps.h32,
            Images.svg(Flags.malaysia, width: 28, height: 28),
            JGaps.h8,
            const Text('Flag SVG using Images.svg(Flags.malaysia)'),
            JGaps.h32,
            Images.svg(Illustrations.emptyState, width: 120),
            JGaps.h8,
            const Text('Illustration SVG using Images.svg'),
          ],
        ),
      ),
    );
  }
}
