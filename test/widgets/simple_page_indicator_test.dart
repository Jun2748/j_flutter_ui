import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

import '../test_helpers.dart';

Widget _buildSubject({
  int count = 4,
  int currentIndex = 0,
  Color? activeColor,
  Color? inactiveColor,
  double? dotSize,
  double? activeDotWidth,
  double? dotSpacing,
}) {
  return buildTestApp(
    SimplePageIndicator(
      count: count,
      currentIndex: currentIndex,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      dotSize: dotSize,
      activeDotWidth: activeDotWidth,
      dotSpacing: dotSpacing,
    ),
  );
}

void main() {
  group('SimplePageIndicator', () {
    testWidgets('renders without crashing', (WidgetTester tester) async {
      await tester.pumpWidget(_buildSubject());

      expect(find.byType(SimplePageIndicator), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders empty when count is 0', (WidgetTester tester) async {
      await tester.pumpWidget(_buildSubject(count: 0));

      expect(find.byType(AnimatedContainer), findsNothing);
    });

    testWidgets('renders correct number of dots', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildSubject(count: 5));

      expect(find.byType(AnimatedContainer), findsNWidgets(5));
    });

    testWidgets('active dot has activeDotWidth', (WidgetTester tester) async {
      await tester.pumpWidget(
        _buildSubject(
          count: 3,
          currentIndex: 1,
          dotSize: JDimens.dp8,
          activeDotWidth: JDimens.dp20,
        ),
      );

      final List<AnimatedContainer> dots = tester
          .widgetList<AnimatedContainer>(find.byType(AnimatedContainer))
          .toList();

      // Index 1 is active
      expect(dots[1].constraints?.maxWidth, JDimens.dp20);
    });

    testWidgets('inactive dots have dotSize width', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _buildSubject(
          count: 3,
          currentIndex: 1,
          dotSize: JDimens.dp8,
          activeDotWidth: JDimens.dp20,
        ),
      );

      final List<AnimatedContainer> dots = tester
          .widgetList<AnimatedContainer>(find.byType(AnimatedContainer))
          .toList();

      expect(dots[0].constraints?.maxWidth, JDimens.dp8);
      expect(dots[2].constraints?.maxWidth, JDimens.dp8);
    });

    testWidgets('active dot uses activeColor', (WidgetTester tester) async {
      const Color custom = Colors.red;
      await tester.pumpWidget(
        _buildSubject(count: 3, currentIndex: 0, activeColor: custom),
      );

      final List<AnimatedContainer> dots = tester
          .widgetList<AnimatedContainer>(find.byType(AnimatedContainer))
          .toList();

      final BoxDecoration dec = dots[0].decoration! as BoxDecoration;
      expect(dec.color, custom);
    });

    testWidgets('inactive dots use inactiveColor', (
      WidgetTester tester,
    ) async {
      const Color custom = Colors.grey;
      await tester.pumpWidget(
        _buildSubject(count: 3, currentIndex: 0, inactiveColor: custom),
      );

      final List<AnimatedContainer> dots = tester
          .widgetList<AnimatedContainer>(find.byType(AnimatedContainer))
          .toList();

      final BoxDecoration dec1 = dots[1].decoration! as BoxDecoration;
      final BoxDecoration dec2 = dots[2].decoration! as BoxDecoration;
      expect(dec1.color, custom);
      expect(dec2.color, custom);
    });

    testWidgets('currentIndex is clamped above count - 1', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _buildSubject(count: 3, currentIndex: 99),
      );

      expect(find.byType(SimplePageIndicator), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('currentIndex is clamped below 0', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _buildSubject(count: 3, currentIndex: -5),
      );

      expect(find.byType(SimplePageIndicator), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('no crash with all optional params null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildSubject());

      expect(find.byType(SimplePageIndicator), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
