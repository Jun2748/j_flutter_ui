import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

import '../test_helpers.dart';

void main() {
  group('SimpleErrorView', () {
    testWidgets('default or custom title renders', (WidgetTester tester) async {
      await pumpTestApp(tester, const SimpleErrorView());

      expect(find.text('Something went wrong'), findsOneWidget);
    });

    testWidgets('message renders', (WidgetTester tester) async {
      await pumpTestApp(
        tester,
        const SimpleErrorView(message: 'Could not load bookings.'),
      );

      expect(find.text('Could not load bookings.'), findsOneWidget);
    });

    testWidgets('retry button renders when provided', (
      WidgetTester tester,
    ) async {
      await pumpTestApp(
        tester,
        SimpleErrorView(retryLabel: 'Try Again', onRetry: () {}),
      );

      expect(find.text('Try Again'), findsOneWidget);
    });

    testWidgets('retry callback can be triggered', (WidgetTester tester) async {
      bool retried = false;

      await pumpTestApp(
        tester,
        SimpleErrorView(
          retryLabel: 'Try Again',
          onRetry: () {
            retried = true;
          },
        ),
      );

      await tester.tap(find.text('Try Again'));
      await tester.pump();

      expect(retried, isTrue);
    });
  });
}
