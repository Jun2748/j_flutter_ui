import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

import '../test_helpers.dart';

Widget _buildSubject({
  String label = 'Subtotal',
  String value = 'RM 16.90',
  Color? labelColor,
  Color? valueColor,
  FontWeight? labelWeight,
  FontWeight? valueWeight,
  EdgeInsetsGeometry? padding,
}) {
  return buildTestApp(
    SimpleSummaryRow(
      label: label,
      value: value,
      labelColor: labelColor,
      valueColor: valueColor,
      labelWeight: labelWeight,
      valueWeight: valueWeight,
      padding: padding,
    ),
  );
}

void main() {
  group('SimpleSummaryRow', () {
    testWidgets('renders label and value', (WidgetTester tester) async {
      await tester.pumpWidget(_buildSubject());

      expect(find.text('Subtotal'), findsOneWidget);
      expect(find.text('RM 16.90'), findsOneWidget);
    });

    testWidgets('uses spaceBetween layout', (WidgetTester tester) async {
      await tester.pumpWidget(_buildSubject());

      final Row row = tester.widget<Row>(find.byType(Row));
      expect(row.mainAxisAlignment, MainAxisAlignment.spaceBetween);
    });

    testWidgets('custom labelColor is applied', (WidgetTester tester) async {
      const Color custom = Colors.red;
      await tester.pumpWidget(_buildSubject(labelColor: custom));

      final SimpleText labelWidget = tester.widget<SimpleText>(
        find.ancestor(
          of: find.text('Subtotal'),
          matching: find.byType(SimpleText),
        ),
      );

      expect(labelWidget.color, custom);
    });

    testWidgets('custom valueColor is applied', (WidgetTester tester) async {
      const Color custom = Colors.green;
      await tester.pumpWidget(_buildSubject(valueColor: custom));

      final SimpleText valueWidget = tester.widget<SimpleText>(
        find.ancestor(
          of: find.text('RM 16.90'),
          matching: find.byType(SimpleText),
        ),
      );

      expect(valueWidget.color, custom);
    });

    testWidgets('labelWeight override is applied', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _buildSubject(labelWeight: FontWeight.w700),
      );

      final SimpleText labelWidget = tester.widget<SimpleText>(
        find.ancestor(
          of: find.text('Subtotal'),
          matching: find.byType(SimpleText),
        ),
      );

      expect(labelWidget.weight, FontWeight.w700);
    });

    testWidgets('valueWeight override is applied', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _buildSubject(valueWeight: FontWeight.w700),
      );

      final SimpleText valueWidget = tester.widget<SimpleText>(
        find.ancestor(
          of: find.text('RM 16.90'),
          matching: find.byType(SimpleText),
        ),
      );

      expect(valueWidget.weight, FontWeight.w700);
    });

    testWidgets('custom padding is applied', (WidgetTester tester) async {
      const EdgeInsets custom = EdgeInsets.all(24);
      await tester.pumpWidget(_buildSubject(padding: custom));

      final Padding paddingWidget = tester.widget<Padding>(
        find.ancestor(
          of: find.byType(Row),
          matching: find.byType(Padding),
        ).first,
      );

      expect(paddingWidget.padding, custom);
    });

    testWidgets('no crash with all optional params null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildSubject());

      expect(find.byType(SimpleSummaryRow), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('label is wrapped in Flexible for long text', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _buildSubject(label: 'A very long label that should truncate'),
      );

      expect(
        find.ancestor(
          of: find.text('A very long label that should truncate'),
          matching: find.byType(Flexible),
        ),
        findsOneWidget,
      );
    });

    testWidgets('total-style variant renders correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _buildSubject(
          label: 'Total',
          value: 'RM 25.90',
          labelWeight: FontWeight.w700,
          valueWeight: FontWeight.w700,
          valueColor: Colors.blue,
        ),
      );

      expect(find.text('Total'), findsOneWidget);
      expect(find.text('RM 25.90'), findsOneWidget);

      final SimpleText valueWidget = tester.widget<SimpleText>(
        find.ancestor(
          of: find.text('RM 25.90'),
          matching: find.byType(SimpleText),
        ),
      );
      expect(valueWidget.color, Colors.blue);
      expect(valueWidget.weight, FontWeight.w700);
    });
  });
}
