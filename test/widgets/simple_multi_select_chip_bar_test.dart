import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

import '../test_helpers.dart';

Widget _buildSubject({
  List<String> items = const <String>['A', 'B', 'C', 'D'],
  Set<String> values = const <String>{},
  ValueChanged<Set<String>>? onChanged,
  int? maxSelections,
  Color? selectedColor,
  Color? unselectedColor,
  Color? selectedLabelColor,
  Color? unselectedLabelColor,
}) {
  return buildTestApp(
    SimpleMultiSelectChipBar<String>(
      items: items,
      values: values,
      onChanged: onChanged ?? (_) {},
      labelBuilder: (String item) => item,
      maxSelections: maxSelections,
      selectedColor: selectedColor,
      unselectedColor: unselectedColor,
      selectedLabelColor: selectedLabelColor,
      unselectedLabelColor: unselectedLabelColor,
    ),
  );
}

void main() {
  group('SimpleMultiSelectChipBar', () {
    testWidgets('renders all items', (WidgetTester tester) async {
      await tester.pumpWidget(_buildSubject());

      expect(find.text('A'), findsOneWidget);
      expect(find.text('B'), findsOneWidget);
      expect(find.text('C'), findsOneWidget);
      expect(find.text('D'), findsOneWidget);
    });

    testWidgets('renders empty when items is empty', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildSubject(items: const <String>[]));

      expect(find.byType(SizedBox), findsOneWidget);
      expect(find.byType(FilterChip), findsNothing);
    });

    testWidgets('tapping unselected item adds it to selection', (
      WidgetTester tester,
    ) async {
      Set<String>? result;
      await tester.pumpWidget(
        _buildSubject(
          values: const <String>{'A'},
          onChanged: (Set<String> v) => result = v,
        ),
      );

      await tester.tap(find.text('B'));
      await tester.pump();

      expect(result, containsAll(<String>['A', 'B']));
    });

    testWidgets('tapping selected item removes it from selection', (
      WidgetTester tester,
    ) async {
      Set<String>? result;
      await tester.pumpWidget(
        _buildSubject(
          values: const <String>{'A', 'B'},
          onChanged: (Set<String> v) => result = v,
        ),
      );

      await tester.tap(find.text('A'));
      await tester.pump();

      expect(result, equals(<String>{'B'}));
    });

    testWidgets('maxSelections prevents adding beyond limit', (
      WidgetTester tester,
    ) async {
      Set<String>? result;
      await tester.pumpWidget(
        _buildSubject(
          values: const <String>{'A', 'B'},
          maxSelections: 2,
          onChanged: (Set<String> v) => result = v,
        ),
      );

      await tester.tap(find.text('C'));
      await tester.pump();

      expect(result, isNull);
    });

    testWidgets('maxSelections still allows deselecting', (
      WidgetTester tester,
    ) async {
      Set<String>? result;
      await tester.pumpWidget(
        _buildSubject(
          values: const <String>{'A', 'B'},
          maxSelections: 2,
          onChanged: (Set<String> v) => result = v,
        ),
      );

      await tester.tap(find.text('A'));
      await tester.pump();

      expect(result, equals(<String>{'B'}));
    });

    testWidgets('custom selectedColor is applied', (
      WidgetTester tester,
    ) async {
      const Color custom = Colors.orange;
      await tester.pumpWidget(
        _buildSubject(
          values: const <String>{'A'},
          selectedColor: custom,
        ),
      );

      final FilterChip chip = tester.widget<FilterChip>(
        find.ancestor(
          of: find.text('A'),
          matching: find.byType(FilterChip),
        ),
      );

      expect(chip.selectedColor, custom);
    });

    testWidgets('custom unselectedColor is applied', (
      WidgetTester tester,
    ) async {
      const Color custom = Colors.grey;
      await tester.pumpWidget(
        _buildSubject(unselectedColor: custom),
      );

      final FilterChip chip = tester.widget<FilterChip>(
        find.ancestor(
          of: find.text('A'),
          matching: find.byType(FilterChip),
        ),
      );

      expect(chip.backgroundColor, custom);
    });

    testWidgets('no crash with all optional params null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildSubject());

      expect(find.byType(SimpleMultiSelectChipBar<String>), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('no upper limit when maxSelections is null', (
      WidgetTester tester,
    ) async {
      Set<String>? result;
      await tester.pumpWidget(
        _buildSubject(
          values: const <String>{'A', 'B', 'C'},
          onChanged: (Set<String> v) => result = v,
        ),
      );

      await tester.tap(find.text('D'));
      await tester.pump();

      expect(result, containsAll(<String>['A', 'B', 'C', 'D']));
    });
  });
}
