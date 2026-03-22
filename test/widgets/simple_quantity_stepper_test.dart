import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

import '../test_helpers.dart';

void main() {
  group('SimpleQuantityStepper', () {
    testWidgets('renders with default params', (WidgetTester tester) async {
      await pumpTestApp(
        tester,
        SimpleQuantityStepper(value: 3, onChanged: (_) {}),
      );

      expect(find.text('3'), findsOneWidget);
      expect(find.byIcon(Icons.remove), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('minus button disabled at minValue', (
      WidgetTester tester,
    ) async {
      int? lastValue;
      await pumpTestApp(
        tester,
        SimpleQuantityStepper(
          value: 1,
          minValue: 1,
          onChanged: (int v) => lastValue = v,
        ),
      );

      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();

      expect(lastValue, isNull);
    });

    testWidgets('plus button disabled at maxValue', (
      WidgetTester tester,
    ) async {
      int? lastValue;
      await pumpTestApp(
        tester,
        SimpleQuantityStepper(
          value: 5,
          maxValue: 5,
          onChanged: (int v) => lastValue = v,
        ),
      );

      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      expect(lastValue, isNull);
    });

    testWidgets('minus calls onChanged with value - 1', (
      WidgetTester tester,
    ) async {
      int? lastValue;
      await pumpTestApp(
        tester,
        SimpleQuantityStepper(
          value: 3,
          onChanged: (int v) => lastValue = v,
        ),
      );

      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();

      expect(lastValue, 2);
    });

    testWidgets('plus calls onChanged with value + 1', (
      WidgetTester tester,
    ) async {
      int? lastValue;
      await pumpTestApp(
        tester,
        SimpleQuantityStepper(
          value: 3,
          onChanged: (int v) => lastValue = v,
        ),
      );

      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      expect(lastValue, 4);
    });

    testWidgets('both buttons disabled when onChanged is null', (
      WidgetTester tester,
    ) async {
      await pumpTestApp(
        tester,
        const SimpleQuantityStepper(value: 3),
      );

      final Finder minusButton = find.byIcon(Icons.remove);
      final Finder plusButton = find.byIcon(Icons.add);

      expect(minusButton, findsOneWidget);
      expect(plusButton, findsOneWidget);

      final SimpleIconButton minusWidget = tester.widget<SimpleIconButton>(
        find.ancestor(
          of: minusButton,
          matching: find.byType(SimpleIconButton),
        ),
      );
      final SimpleIconButton plusWidget = tester.widget<SimpleIconButton>(
        find.ancestor(
          of: plusButton,
          matching: find.byType(SimpleIconButton),
        ),
      );

      expect(minusWidget.onPressed, isNull);
      expect(plusWidget.onPressed, isNull);
    });

    testWidgets('custom activeColor is applied to enabled buttons', (
      WidgetTester tester,
    ) async {
      const Color customColor = Colors.orange;
      await pumpTestApp(
        tester,
        SimpleQuantityStepper(
          value: 3,
          onChanged: (_) {},
          activeColor: customColor,
        ),
      );

      final SimpleIconButton plusWidget = tester.widget<SimpleIconButton>(
        find.ancestor(
          of: find.byIcon(Icons.add),
          matching: find.byType(SimpleIconButton),
        ),
      );

      expect(plusWidget.foregroundColor, customColor);
      expect(plusWidget.borderColor, customColor);
    });

    testWidgets('no crash with all optional params null', (
      WidgetTester tester,
    ) async {
      await pumpTestApp(
        tester,
        const SimpleQuantityStepper(value: 1),
      );

      expect(find.byType(SimpleQuantityStepper), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('respects custom buttonSize and iconSize', (
      WidgetTester tester,
    ) async {
      await pumpTestApp(
        tester,
        SimpleQuantityStepper(
          value: 2,
          onChanged: (_) {},
          buttonSize: JDimens.dp32,
          iconSize: JIconSizes.sm,
        ),
      );

      final SimpleIconButton button = tester.widget<SimpleIconButton>(
        find.ancestor(
          of: find.byIcon(Icons.add),
          matching: find.byType(SimpleIconButton),
        ),
      );

      expect(button.size, JDimens.dp32);
      expect(button.iconSize, JIconSizes.sm);
    });

    testWidgets('no upper limit when maxValue is null', (
      WidgetTester tester,
    ) async {
      int? lastValue;
      await pumpTestApp(
        tester,
        SimpleQuantityStepper(
          value: 999,
          onChanged: (int v) => lastValue = v,
        ),
      );

      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      expect(lastValue, 1000);
    });
  });
}
