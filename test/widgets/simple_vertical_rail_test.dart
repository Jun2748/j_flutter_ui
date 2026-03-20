import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

import '../test_helpers.dart';

void main() {
  group('SimpleVerticalRail', () {
    testWidgets('selected item background is opt-in', (
      WidgetTester tester,
    ) async {
      await pumpTestApp(
        tester,
        SimpleVerticalRail(
          items: const <SimpleVerticalRailItem>[
            SimpleVerticalRailItem(icon: Icons.home_outlined, label: 'Home'),
            SimpleVerticalRailItem(
              icon: Icons.person_outline,
              label: 'Profile',
            ),
          ],
          selectedIndex: 0,
          onSelected: (_) {},
        ),
      );

      final List<Ink> inks = tester.widgetList<Ink>(find.byType(Ink)).toList();

      expect(inks, hasLength(2));
      expect(inks.first.decoration, isNull);
      expect(inks.last.decoration, isNull);
    });

    testWidgets('applies selected item background with a rounded highlight', (
      WidgetTester tester,
    ) async {
      const Color selectedBackground = Color(0xFFE0F2FE);

      await pumpTestApp(
        tester,
        SimpleVerticalRail(
          items: const <SimpleVerticalRailItem>[
            SimpleVerticalRailItem(icon: Icons.home_outlined, label: 'Home'),
            SimpleVerticalRailItem(
              icon: Icons.person_outline,
              label: 'Profile',
            ),
          ],
          selectedIndex: 1,
          selectedItemBackgroundColor: selectedBackground,
          onSelected: (_) {},
        ),
      );

      final List<Ink> inks = tester.widgetList<Ink>(find.byType(Ink)).toList();
      final BoxDecoration decoration = inks.last.decoration! as BoxDecoration;

      expect(inks.first.decoration, isNull);
      expect(decoration.color, selectedBackground);
      expect(decoration.borderRadius, BorderRadius.circular(JDimens.dp12));
    });
  });
}
