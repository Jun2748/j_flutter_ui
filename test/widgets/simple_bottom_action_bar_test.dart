import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

Widget _buildSubject({
  String actionLabel = 'Add to Cart',
  VoidCallback? onAction = _noOp,
  String? priceText,
  String? labelText,
  bool loading = false,
}) {
  return MaterialApp(
    theme: JAppTheme.lightTheme,
    home: Scaffold(
      bottomNavigationBar: SimpleBottomActionBar(
        actionLabel: actionLabel,
        onAction: onAction,
        priceText: priceText,
        labelText: labelText,
        loading: loading,
      ),
    ),
  );
}

void _noOp() {}

void main() {
  group('SimpleBottomActionBar', () {
    testWidgets('renders actionLabel on button', (WidgetTester tester) async {
      await tester.pumpWidget(_buildSubject(actionLabel: 'Checkout'));

      expect(find.text('Checkout'), findsOneWidget);
    });

    testWidgets('renders priceText when provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _buildSubject(priceText: 'RM 16.90'),
      );

      expect(find.text('RM 16.90'), findsOneWidget);
    });

    testWidgets('renders labelText when provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _buildSubject(labelText: 'Total', priceText: 'RM 16.90'),
      );

      expect(find.text('Total'), findsOneWidget);
    });

    testWidgets('button is disabled when onAction is null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _buildSubject(actionLabel: 'Add to Cart', onAction: null),
      );

      final SimpleButton button = tester.widget<SimpleButton>(
        find.byType(SimpleButton),
      );
      expect(button.onPressed, isNull);
    });

    testWidgets('loading state passes through to button', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _buildSubject(loading: true),
      );

      final SimpleButton button = tester.widget<SimpleButton>(
        find.byType(SimpleButton),
      );
      expect(button.loading, isTrue);
    });

    testWidgets(
      'left side is absent when both labelText and priceText are null',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          _buildSubject(priceText: null, labelText: null),
        );

        expect(find.byType(Column), findsNothing);
        expect(find.byType(SimpleButton), findsOneWidget);
      },
    );
  });
}
