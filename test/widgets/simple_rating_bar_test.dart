import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

import '../test_helpers.dart';

Widget _buildSubject({
  double rating = 3.5,
  int starCount = 5,
  int? reviewCount,
  double? starSize,
  Color? filledColor,
  Color? emptyColor,
  Color? ratingCountColor,
  double? gap,
}) {
  return buildTestApp(
    SimpleRatingBar(
      rating: rating,
      starCount: starCount,
      reviewCount: reviewCount,
      starSize: starSize,
      filledColor: filledColor,
      emptyColor: emptyColor,
      ratingCountColor: ratingCountColor,
      gap: gap,
    ),
  );
}

void main() {
  group('SimpleRatingBar', () {
    testWidgets('renders correct number of stars', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildSubject(rating: 4.0, starCount: 5));

      // 4 full + 1 empty = 5 star icons total
      final int starCount = tester
          .widgetList<Icon>(
            find.byWidgetPredicate(
              (Widget w) =>
                  w is Icon &&
                  (w.icon == Icons.star ||
                      w.icon == Icons.star_half ||
                      w.icon == Icons.star_border),
            ),
          )
          .length;

      expect(starCount, 5);
    });

    testWidgets('3.5 rating shows 3 full + 1 half + 1 empty', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildSubject(rating: 3.5));

      expect(find.byIcon(Icons.star), findsNWidgets(3));
      expect(find.byIcon(Icons.star_half), findsOneWidget);
      expect(find.byIcon(Icons.star_border), findsOneWidget);
    });

    testWidgets('5.0 rating shows all full stars', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildSubject(rating: 5.0));

      expect(find.byIcon(Icons.star), findsNWidgets(5));
      expect(find.byIcon(Icons.star_half), findsNothing);
      expect(find.byIcon(Icons.star_border), findsNothing);
    });

    testWidgets('0.0 rating shows all empty stars', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildSubject(rating: 0.0));

      expect(find.byIcon(Icons.star_border), findsNWidgets(5));
      expect(find.byIcon(Icons.star), findsNothing);
      expect(find.byIcon(Icons.star_half), findsNothing);
    });

    testWidgets('rating is clamped above maximum', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildSubject(rating: 99.0));

      expect(find.byIcon(Icons.star), findsNWidgets(5));
      expect(tester.takeException(), isNull);
    });

    testWidgets('rating is clamped below 0', (WidgetTester tester) async {
      await tester.pumpWidget(_buildSubject(rating: -1.0));

      expect(find.byIcon(Icons.star_border), findsNWidgets(5));
      expect(tester.takeException(), isNull);
    });

    testWidgets('reviewCount renders count label when provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _buildSubject(rating: 4.0, reviewCount: 128),
      );

      expect(find.text('(128)'), findsOneWidget);
    });

    testWidgets('reviewCount label is absent when null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildSubject(rating: 4.0));

      expect(find.textContaining('('), findsNothing);
    });

    testWidgets('custom filledColor is applied to full stars', (
      WidgetTester tester,
    ) async {
      const Color custom = Colors.orange;
      await tester.pumpWidget(
        _buildSubject(rating: 5.0, filledColor: custom),
      );

      final Iterable<Icon> stars = tester.widgetList<Icon>(
        find.byIcon(Icons.star),
      );

      expect(stars.every((Icon i) => i.color == custom), isTrue);
    });

    testWidgets('custom emptyColor is applied to empty stars', (
      WidgetTester tester,
    ) async {
      const Color custom = Colors.grey;
      await tester.pumpWidget(
        _buildSubject(rating: 0.0, emptyColor: custom),
      );

      final Iterable<Icon> stars = tester.widgetList<Icon>(
        find.byIcon(Icons.star_border),
      );

      expect(stars.every((Icon i) => i.color == custom), isTrue);
    });

    testWidgets('no crash with all optional params null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildSubject());

      expect(find.byType(SimpleRatingBar), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
