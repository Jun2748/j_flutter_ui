import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

import '../test_helpers.dart';

void main() {
  group('SimpleBanner', () {
    testWidgets('title renders', (WidgetTester tester) async {
      await pumpTestApp(tester, const SimpleBanner.info(title: 'Heads up'));

      expect(find.text('Heads up'), findsOneWidget);
    });

    testWidgets('message renders', (WidgetTester tester) async {
      await pumpTestApp(
        tester,
        const SimpleBanner.success(
          title: 'Saved',
          message: 'Your changes were saved successfully.',
        ),
      );

      expect(
        find.text('Your changes were saved successfully.'),
        findsOneWidget,
      );
    });

    testWidgets('optional dismiss callback can be triggered', (
      WidgetTester tester,
    ) async {
      bool dismissed = false;

      await pumpTestApp(
        tester,
        SimpleBanner.warning(
          title: 'Dismiss me',
          onDismiss: () {
            dismissed = true;
          },
        ),
      );

      await tester.tap(find.byIcon(Icons.close));
      await tester.pump();

      expect(dismissed, isTrue);
    });
  });
}
