import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

import '../test_helpers.dart';

Widget _buildSubject({
  Widget child = const Text('VOUCHER10'),
  VoidCallback? onTap,
  Color? backgroundColor,
  Color? borderColor,
  double? borderRadius,
  double? dashWidth,
  double? dashGap,
  double? borderWidth,
  EdgeInsetsGeometry? padding,
  EdgeInsetsGeometry? margin,
}) {
  return buildTestApp(
    SimpleVoucherCard(
      onTap: onTap,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      borderRadius: borderRadius,
      dashWidth: dashWidth,
      dashGap: dashGap,
      borderWidth: borderWidth,
      padding: padding,
      margin: margin,
      child: child,
    ),
  );
}

void main() {
  group('SimpleVoucherCard', () {
    testWidgets('renders child content', (WidgetTester tester) async {
      await tester.pumpWidget(_buildSubject());

      expect(find.text('VOUCHER10'), findsOneWidget);
    });

    testWidgets('renders without crashing with default params', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildSubject());

      expect(find.byType(SimpleVoucherCard), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('CustomPaint is present for dashed border', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildSubject());

      // At least one CustomPaint is the dashed-border painter; Flutter
      // internals may render additional CustomPaint widgets.
      expect(find.byType(CustomPaint), findsAtLeastNWidgets(1));
    });

    testWidgets('uses custom backgroundColor', (WidgetTester tester) async {
      const Color custom = Color(0xFFFFF3E0);
      await tester.pumpWidget(_buildSubject(backgroundColor: custom));

      final Container container = tester.widget<Container>(
        find.descendant(
          of: find.byType(SimpleVoucherCard),
          matching: find.byType(Container),
        ),
      );

      final BoxDecoration decoration = container.decoration! as BoxDecoration;
      expect(decoration.color, custom);
    });

    testWidgets('onTap callback fires when tapped', (
      WidgetTester tester,
    ) async {
      bool tapped = false;
      await tester.pumpWidget(
        _buildSubject(onTap: () => tapped = true),
      );

      await tester.tap(find.byType(SimpleVoucherCard));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('InkWell is present when onTap is non-null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildSubject(onTap: () {}));

      expect(find.byType(InkWell), findsOneWidget);
    });

    testWidgets('InkWell is absent when onTap is null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildSubject());

      expect(find.byType(InkWell), findsNothing);
    });

    testWidgets('custom padding is applied to container', (
      WidgetTester tester,
    ) async {
      const EdgeInsets custom = EdgeInsets.all(24);
      await tester.pumpWidget(_buildSubject(padding: custom));

      final Container container = tester.widget<Container>(
        find.descendant(
          of: find.byType(SimpleVoucherCard),
          matching: find.byType(Container),
        ),
      );

      expect(container.padding, custom);
    });

    testWidgets('margin is applied via outer Padding', (
      WidgetTester tester,
    ) async {
      const EdgeInsets custom = EdgeInsets.all(16);
      await tester.pumpWidget(_buildSubject(margin: custom));

      final Padding outerPadding = tester.widget<Padding>(
        find.ancestor(
          of: find.byType(ClipRRect),
          matching: find.byType(Padding),
        ).first,
      );

      expect(outerPadding.padding, custom);
    });

    testWidgets('no crash with all optional params null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildSubject());

      expect(find.byType(SimpleVoucherCard), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
