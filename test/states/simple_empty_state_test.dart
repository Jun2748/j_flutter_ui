import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

import '../test_helpers.dart';

void main() {
  group('SimpleEmptyState', () {
    testWidgets('title renders', (WidgetTester tester) async {
      await pumpTestApp(tester, const SimpleEmptyState(title: 'No items'));

      expect(find.text('No items'), findsOneWidget);
    });

    testWidgets('message renders', (WidgetTester tester) async {
      await pumpTestApp(
        tester,
        const SimpleEmptyState(
          title: 'No items',
          message: 'Try refreshing later.',
        ),
      );

      expect(find.text('Try refreshing later.'), findsOneWidget);
    });

    testWidgets('action button renders when provided', (
      WidgetTester tester,
    ) async {
      await pumpTestApp(
        tester,
        SimpleEmptyState(
          title: 'No items',
          actionLabel: 'Refresh',
          onActionPressed: () {},
        ),
      );

      expect(find.text('Refresh'), findsOneWidget);
    });

    testWidgets('action callback can be triggered', (
      WidgetTester tester,
    ) async {
      bool pressed = false;

      await pumpTestApp(
        tester,
        SimpleEmptyState(
          title: 'No items',
          actionLabel: 'Refresh',
          onActionPressed: () {
            pressed = true;
          },
        ),
      );

      await tester.tap(find.text('Refresh'));
      await tester.pump();

      expect(pressed, isTrue);
    });
  });
}
