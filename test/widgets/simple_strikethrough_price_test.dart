import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

import '../test_helpers.dart';

Widget _buildSubject({
  String originalPrice = 'RM 18.90',
  String currentPrice = 'RM 14.90',
  Color? originalPriceColor,
  Color? currentPriceColor,
  FontWeight? currentPriceWeight,
  TextStyle? style,
  double? gap,
}) {
  return buildTestApp(
    SimpleStrikethroughPrice(
      originalPrice: originalPrice,
      currentPrice: currentPrice,
      originalPriceColor: originalPriceColor,
      currentPriceColor: currentPriceColor,
      currentPriceWeight: currentPriceWeight,
      style: style,
      gap: gap,
    ),
  );
}

Widget _buildStackedSubject({
  String originalPrice = 'RM 18.90',
  String currentPrice = 'RM 14.90',
  Color? originalPriceColor,
  Color? currentPriceColor,
  FontWeight? currentPriceWeight,
  TextStyle? style,
  double? gap,
}) {
  return buildTestApp(
    SimpleStrikethroughPrice.stacked(
      originalPrice: originalPrice,
      currentPrice: currentPrice,
      originalPriceColor: originalPriceColor,
      currentPriceColor: currentPriceColor,
      currentPriceWeight: currentPriceWeight,
      style: style,
      gap: gap,
    ),
  );
}

void main() {
  group('SimpleStrikethroughPrice', () {
    testWidgets('renders both prices', (WidgetTester tester) async {
      await tester.pumpWidget(_buildSubject());

      expect(find.text('RM 18.90'), findsOneWidget);
      expect(find.text('RM 14.90'), findsOneWidget);
    });

    testWidgets('original price has lineThrough decoration', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildSubject());

      final SimpleText originalWidget = tester.widget<SimpleText>(
        find.ancestor(
          of: find.text('RM 18.90'),
          matching: find.byType(SimpleText),
        ),
      );

      expect(
        originalWidget.style?.decoration,
        equals(TextDecoration.lineThrough),
      );
    });

    testWidgets('current price has no strikethrough', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildSubject());

      final SimpleText currentWidget = tester.widget<SimpleText>(
        find.ancestor(
          of: find.text('RM 14.90'),
          matching: find.byType(SimpleText),
        ),
      );

      // style is null on the current price widget (no decoration override)
      expect(
        currentWidget.style?.decoration,
        isNot(contains(TextDecoration.lineThrough)),
      );
    });

    testWidgets('custom originalPriceColor is applied', (
      WidgetTester tester,
    ) async {
      const Color custom = Colors.grey;
      await tester.pumpWidget(_buildSubject(originalPriceColor: custom));

      final SimpleText originalWidget = tester.widget<SimpleText>(
        find.ancestor(
          of: find.text('RM 18.90'),
          matching: find.byType(SimpleText),
        ),
      );

      expect(originalWidget.color, custom);
    });

    testWidgets('custom currentPriceColor is applied', (
      WidgetTester tester,
    ) async {
      const Color custom = Colors.red;
      await tester.pumpWidget(_buildSubject(currentPriceColor: custom));

      final SimpleText currentWidget = tester.widget<SimpleText>(
        find.ancestor(
          of: find.text('RM 14.90'),
          matching: find.byType(SimpleText),
        ),
      );

      expect(currentWidget.color, custom);
    });

    testWidgets('current price defaults to FontWeight.w700', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildSubject());

      final SimpleText currentWidget = tester.widget<SimpleText>(
        find.ancestor(
          of: find.text('RM 14.90'),
          matching: find.byType(SimpleText),
        ),
      );

      expect(currentWidget.weight, FontWeight.w700);
    });

    testWidgets('custom currentPriceWeight is applied', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _buildSubject(currentPriceWeight: FontWeight.w400),
      );

      final SimpleText currentWidget = tester.widget<SimpleText>(
        find.ancestor(
          of: find.text('RM 14.90'),
          matching: find.byType(SimpleText),
        ),
      );

      expect(currentWidget.weight, FontWeight.w400);
    });

    testWidgets('uses Row with baseline cross-axis alignment', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildSubject());

      final Row row = tester.widget<Row>(find.byType(Row));
      expect(row.crossAxisAlignment, CrossAxisAlignment.baseline);
    });

    testWidgets('no crash with all optional params null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildSubject());

      expect(find.byType(SimpleStrikethroughPrice), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('custom gap is applied as SizedBox width', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildSubject(gap: JDimens.dp16));

      final Iterable<SizedBox> boxes = tester.widgetList<SizedBox>(
        find.byType(SizedBox),
      );

      expect(boxes.any((SizedBox b) => b.width == JDimens.dp16), isTrue);
    });
  });

  group('SimpleStrikethroughPrice.stacked', () {
    testWidgets('renders both prices', (WidgetTester tester) async {
      await tester.pumpWidget(_buildStackedSubject());

      expect(find.text('RM 18.90'), findsOneWidget);
      expect(find.text('RM 14.90'), findsOneWidget);
    });

    testWidgets('uses Column with start alignment', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildStackedSubject());

      final Column column = tester.widget<Column>(find.byType(Column));
      expect(column.crossAxisAlignment, CrossAxisAlignment.start);
      expect(column.mainAxisSize, MainAxisSize.min);
    });

    testWidgets('original price has lineThrough decoration', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildStackedSubject());

      final SimpleText originalWidget = tester.widget<SimpleText>(
        find.ancestor(
          of: find.text('RM 18.90'),
          matching: find.byType(SimpleText),
        ),
      );

      expect(
        originalWidget.style?.decoration,
        equals(TextDecoration.lineThrough),
      );
    });

    testWidgets('custom gap is applied as SizedBox height', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildStackedSubject(gap: JDimens.dp12));

      final Iterable<SizedBox> boxes = tester.widgetList<SizedBox>(
        find.byType(SizedBox),
      );

      expect(boxes.any((SizedBox b) => b.height == JDimens.dp12), isTrue);
    });

    testWidgets('no crash with all optional params null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildStackedSubject());

      expect(find.byType(SimpleStrikethroughPrice), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('custom colors are applied in stacked layout', (
      WidgetTester tester,
    ) async {
      const Color customOriginal = Colors.grey;
      const Color customCurrent = Colors.red;
      await tester.pumpWidget(
        _buildStackedSubject(
          originalPriceColor: customOriginal,
          currentPriceColor: customCurrent,
        ),
      );

      final SimpleText originalWidget = tester.widget<SimpleText>(
        find.ancestor(
          of: find.text('RM 18.90'),
          matching: find.byType(SimpleText),
        ),
      );
      final SimpleText currentWidget = tester.widget<SimpleText>(
        find.ancestor(
          of: find.text('RM 14.90'),
          matching: find.byType(SimpleText),
        ),
      );

      expect(originalWidget.color, customOriginal);
      expect(currentWidget.color, customCurrent);
    });
  });
}
