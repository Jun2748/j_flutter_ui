import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

import '../test_helpers.dart';

const List<SimpleStepItem> _threeSteps = <SimpleStepItem>[
  SimpleStepItem(label: 'Placed'),
  SimpleStepItem(label: 'Preparing'),
  SimpleStepItem(label: 'Ready'),
];

Widget _buildSubject({
  List<SimpleStepItem> steps = _threeSteps,
  int currentStep = 0,
  Color? completedColor,
  Color? activeColor,
  Color? incompleteColor,
  Color? activeLabelColor,
  Color? inactiveLabelColor,
  double? dotSize,
  double? connectorThickness,
}) {
  return buildTestApp(
    SimpleStepIndicator(
      steps: steps,
      currentStep: currentStep,
      completedColor: completedColor,
      activeColor: activeColor,
      incompleteColor: incompleteColor,
      activeLabelColor: activeLabelColor,
      inactiveLabelColor: inactiveLabelColor,
      dotSize: dotSize,
      connectorThickness: connectorThickness,
    ),
  );
}

void main() {
  group('SimpleStepIndicator', () {
    testWidgets('renders all step labels', (WidgetTester tester) async {
      await tester.pumpWidget(_buildSubject());

      expect(find.text('Placed'), findsOneWidget);
      expect(find.text('Preparing'), findsOneWidget);
      expect(find.text('Ready'), findsOneWidget);
    });

    testWidgets('renders empty when steps list is empty', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _buildSubject(steps: const <SimpleStepItem>[]),
      );

      expect(find.byType(SizedBox), findsOneWidget);
      expect(find.byType(Row), findsNothing);
    });

    testWidgets('currentStep clamps to last step when out of range', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _buildSubject(currentStep: 99),
      );

      expect(find.byType(SimpleStepIndicator), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('currentStep clamps to 0 when negative', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _buildSubject(currentStep: -1),
      );

      expect(find.byType(SimpleStepIndicator), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders three Expanded cells for three steps', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildSubject());

      expect(find.byType(Expanded), findsAtLeastNWidgets(3));
    });

    testWidgets('renders step with icon without crashing', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _buildSubject(
          steps: const <SimpleStepItem>[
            SimpleStepItem(label: 'Placed', icon: Icons.check),
            SimpleStepItem(label: 'Preparing'),
            SimpleStepItem(label: 'Ready'),
          ],
          currentStep: 1,
        ),
      );

      expect(find.byIcon(Icons.check), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('no crash with single step', (WidgetTester tester) async {
      await tester.pumpWidget(
        _buildSubject(
          steps: const <SimpleStepItem>[SimpleStepItem(label: 'Done')],
          currentStep: 0,
        ),
      );

      expect(find.text('Done'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('custom dotSize is applied', (WidgetTester tester) async {
      await tester.pumpWidget(
        _buildSubject(dotSize: JDimens.dp20),
      );

      final Iterable<SizedBox> trackBoxes = tester.widgetList<SizedBox>(
        find.byType(SizedBox),
      );

      expect(trackBoxes.any((SizedBox b) => b.height == JDimens.dp20), isTrue);
    });

    testWidgets('no crash with all optional params null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildSubject());

      expect(find.byType(SimpleStepIndicator), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('all steps completed renders without crash', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _buildSubject(currentStep: 2),
      );

      expect(find.byType(SimpleStepIndicator), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
