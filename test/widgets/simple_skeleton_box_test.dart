import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

import '../test_helpers.dart';

Widget _buildSubject({
  double? width,
  double? height,
  double? borderRadius,
  Color? baseColor,
  Color? highlightColor,
}) {
  return buildTestApp(
    SimpleSkeletonBox(
      width: width,
      height: height,
      borderRadius: borderRadius,
      baseColor: baseColor,
      highlightColor: highlightColor,
    ),
  );
}

void main() {
  group('SimpleSkeletonBox', () {
    testWidgets('renders without crashing', (WidgetTester tester) async {
      await tester.pumpWidget(_buildSubject());

      expect(find.byType(SimpleSkeletonBox), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('applies custom width and height', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _buildSubject(width: JDimens.dp200, height: JDimens.dp80),
      );

      final Container box = tester.widget<Container>(
        find.descendant(
          of: find.byType(SimpleSkeletonBox),
          matching: find.byType(Container),
        ),
      );

      expect(box.constraints?.maxWidth, JDimens.dp200);
      expect(box.constraints?.maxHeight, JDimens.dp80);
    });

    testWidgets('applies custom borderRadius', (WidgetTester tester) async {
      await tester.pumpWidget(_buildSubject(borderRadius: JDimens.dp16));

      final Container box = tester.widget<Container>(
        find.descendant(
          of: find.byType(SimpleSkeletonBox),
          matching: find.byType(Container),
        ),
      );

      final BoxDecoration decoration = box.decoration! as BoxDecoration;
      expect(
        decoration.borderRadius,
        BorderRadius.circular(JDimens.dp16),
      );
    });

    testWidgets('uses LinearGradient for shimmer', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildSubject());

      final Container box = tester.widget<Container>(
        find.descendant(
          of: find.byType(SimpleSkeletonBox),
          matching: find.byType(Container),
        ),
      );

      final BoxDecoration decoration = box.decoration! as BoxDecoration;
      expect(decoration.gradient, isA<LinearGradient>());
    });

    testWidgets('custom baseColor appears in gradient stops', (
      WidgetTester tester,
    ) async {
      const Color custom = Color(0xFFAABBCC);
      await tester.pumpWidget(_buildSubject(baseColor: custom));

      final Container box = tester.widget<Container>(
        find.descendant(
          of: find.byType(SimpleSkeletonBox),
          matching: find.byType(Container),
        ),
      );

      final BoxDecoration decoration = box.decoration! as BoxDecoration;
      final LinearGradient gradient = decoration.gradient! as LinearGradient;

      expect(gradient.colors.first, custom);
      expect(gradient.colors.last, custom);
    });

    testWidgets('custom highlightColor appears in gradient middle stop', (
      WidgetTester tester,
    ) async {
      const Color base = Color(0xFFCCCCCC);
      const Color highlight = Colors.white;
      await tester.pumpWidget(
        _buildSubject(baseColor: base, highlightColor: highlight),
      );

      final Container box = tester.widget<Container>(
        find.descendant(
          of: find.byType(SimpleSkeletonBox),
          matching: find.byType(Container),
        ),
      );

      final BoxDecoration decoration = box.decoration! as BoxDecoration;
      final LinearGradient gradient = decoration.gradient! as LinearGradient;

      expect(gradient.colors[1], highlight);
    });

    testWidgets('animation advances after pump', (WidgetTester tester) async {
      await tester.pumpWidget(_buildSubject());

      // Capture gradient begin alignment before advancing
      Container box() => tester.widget<Container>(
            find.descendant(
              of: find.byType(SimpleSkeletonBox),
              matching: find.byType(Container),
            ),
          );

      final LinearGradient before =
          (box().decoration! as BoxDecoration).gradient! as LinearGradient;

      await tester.pump(const Duration(milliseconds: 300));

      final LinearGradient after =
          (box().decoration! as BoxDecoration).gradient! as LinearGradient;

      expect(before.begin, isNot(equals(after.begin)));
    });

    testWidgets('no crash with all optional params null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildSubject());

      expect(find.byType(SimpleSkeletonBox), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('disposes animation controller without error', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildSubject());
      await tester.pumpWidget(const SizedBox.shrink());

      expect(tester.takeException(), isNull);
    });
  });
}
