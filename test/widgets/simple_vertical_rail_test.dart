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

  group('SimpleVerticalRail — badgeLabel', () {
    testWidgets('item with badgeLabel renders badge text', (
      WidgetTester tester,
    ) async {
      await pumpTestApp(
        tester,
        SimpleVerticalRail(
          items: const <SimpleVerticalRailItem>[
            SimpleVerticalRailItem(
              icon: Icons.local_cafe_outlined,
              label: 'Coffee',
              badgeLabel: 'SOE',
            ),
            SimpleVerticalRailItem(icon: Icons.spa_outlined, label: 'Tea'),
          ],
          selectedIndex: 0,
          onSelected: (_) {},
        ),
      );

      expect(find.text('SOE'), findsOneWidget);
      expect(find.text('Coffee'), findsOneWidget);
      expect(find.text('Tea'), findsOneWidget);
    });

    testWidgets('item without badgeLabel renders no badge text', (
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

      // Only item labels render — no extra badge text.
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
      // Confirm no unexpected extra text nodes from badges.
      expect(find.byType(DecoratedBox), findsNWidgets(1));
    });

    testWidgets('multiple items can carry independent badgeLabels', (
      WidgetTester tester,
    ) async {
      await pumpTestApp(
        tester,
        SimpleVerticalRail(
          items: const <SimpleVerticalRailItem>[
            SimpleVerticalRailItem(
              icon: Icons.local_cafe_outlined,
              label: 'Coffee',
              badgeLabel: 'SOE',
            ),
            SimpleVerticalRailItem(icon: Icons.spa_outlined, label: 'Tea'),
            SimpleVerticalRailItem(
              icon: Icons.water_drop_outlined,
              label: 'Series',
              badgeLabel: '1.7B+',
            ),
          ],
          selectedIndex: 0,
          onSelected: (_) {},
        ),
      );

      expect(find.text('SOE'), findsOneWidget);
      expect(find.text('1.7B+'), findsOneWidget);
      // Middle item has no badge.
      expect(find.text('Tea'), findsOneWidget);
    });

    testWidgets('non-badged item renders no badge text', (
      WidgetTester tester,
    ) async {
      await pumpTestApp(
        tester,
        SimpleVerticalRail(
          items: const <SimpleVerticalRailItem>[
            SimpleVerticalRailItem(
              icon: Icons.local_cafe_outlined,
              label: 'Coffee',
              badgeLabel: 'NEW',
            ),
            SimpleVerticalRailItem(icon: Icons.spa_outlined, label: 'Tea'),
          ],
          selectedIndex: 0,
          onSelected: (_) {},
        ),
      );

      // Badge text appears exactly once (for Coffee), not for Tea.
      expect(find.text('NEW'), findsOneWidget);
      // No unexpected badge text appears alongside Tea.
      expect(find.text('Tea'), findsOneWidget);
      expect(find.text('Coffee'), findsOneWidget);
    });
  });
}
