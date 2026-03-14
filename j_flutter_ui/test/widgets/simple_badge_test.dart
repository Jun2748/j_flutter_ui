import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

import '../test_helpers.dart';

void main() {
  group('SimpleBadge', () {
    testWidgets('badge label renders', (WidgetTester tester) async {
      await pumpTestApp(
        tester,
        const Center(child: SimpleBadge.neutral(label: 'Draft')),
      );

      expect(find.text('Draft'), findsOneWidget);
    });

    testWidgets('a variant renders correctly', (WidgetTester tester) async {
      await pumpTestApp(
        tester,
        const Center(
          child: SimpleBadge.success(
            label: 'Active',
            icon: Icons.check_circle_outline,
          ),
        ),
      );

      expect(find.text('Active'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle_outline), findsOneWidget);
    });
  });
}
