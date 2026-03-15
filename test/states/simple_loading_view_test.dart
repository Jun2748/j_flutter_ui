import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

import '../test_helpers.dart';

void main() {
  group('SimpleLoadingView', () {
    testWidgets('loading indicator renders', (WidgetTester tester) async {
      await pumpTestApp(tester, const SimpleLoadingView());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('optional message renders when provided', (
      WidgetTester tester,
    ) async {
      await pumpTestApp(
        tester,
        const SimpleLoadingView(message: 'Loading bookings...'),
      );

      expect(find.text('Loading bookings...'), findsOneWidget);
    });
  });
}
