import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

void main() {
  group('SimpleProgressOverlay', () {
    testWidgets('renders default indicator when indicator is null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildOverlayApp(const SimpleProgressOverlay()));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders custom indicator widget when provided', (
      WidgetTester tester,
    ) async {
      const ValueKey<String> indicatorKey = ValueKey<String>(
        'custom_progress_indicator',
      );

      await tester.pumpWidget(
        _buildOverlayApp(
          const SimpleProgressOverlay(
            indicator: SizedBox(
              key: indicatorKey,
              width: JDimens.dp32,
              height: JDimens.dp32,
            ),
          ),
        ),
      );

      expect(find.byKey(indicatorKey), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('renders message text when provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _buildOverlayApp(
          const SimpleProgressOverlay(message: 'Adding to cart...'),
        ),
      );

      expect(find.text('Adding to cart...'), findsOneWidget);
    });

    testWidgets('does not render message when message is null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildOverlayApp(const SimpleProgressOverlay()));

      expect(find.byType(SimpleText), findsNothing);
    });

    testWidgets('AbsorbPointer blocks taps on content behind overlay', (
      WidgetTester tester,
    ) async {
      const ValueKey<String> buttonKey = ValueKey<String>('behind_overlay');
      int tapCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          theme: JAppTheme.lightTheme,
          home: Stack(
            children: <Widget>[
              Scaffold(
                body: Center(
                  child: TextButton(
                    key: buttonKey,
                    onPressed: () {
                      tapCount += 1;
                    },
                    child: const Text('Tap me'),
                  ),
                ),
              ),
              const SimpleProgressOverlay(),
            ],
          ),
        ),
      );

      await tester.tap(find.byKey(buttonKey), warnIfMissed: false);
      await tester.pump();

      expect(tapCount, 0);
    });

    testWidgets('custom barrierColor is applied when provided', (
      WidgetTester tester,
    ) async {
      const Color barrier = Color(0xAA123456);

      await tester.pumpWidget(
        _buildOverlayApp(const SimpleProgressOverlay(barrierColor: barrier)),
      );

      final ColoredBox barrierWidget = tester.widget<ColoredBox>(
        find.byKey(const ValueKey<String>('simple_progress_overlay_barrier')),
      );

      expect(barrierWidget.color, barrier);
    });

    testWidgets('cardColor defaults to transparent when not provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(_buildOverlayApp(const SimpleProgressOverlay()));

      final Container cardWidget = tester.widget<Container>(
        find.byKey(const ValueKey<String>('simple_progress_overlay_card')),
      );
      final BoxDecoration decoration = cardWidget.decoration! as BoxDecoration;

      expect(decoration.color, Colors.transparent);
      expect(decoration.borderRadius, isNull);
    });

    testWidgets('custom cardColor is applied when provided', (
      WidgetTester tester,
    ) async {
      const Color card = Color(0xFFF5F3FF);

      await tester.pumpWidget(
        _buildOverlayApp(const SimpleProgressOverlay(cardColor: card)),
      );

      final Container cardWidget = tester.widget<Container>(
        find.byKey(const ValueKey<String>('simple_progress_overlay_card')),
      );
      final BoxDecoration decoration = cardWidget.decoration! as BoxDecoration;

      expect(decoration.color, card);
    });
  });
}

Widget _buildOverlayApp(Widget overlay) {
  return MaterialApp(
    theme: JAppTheme.lightTheme,
    home: Scaffold(body: Stack(children: <Widget>[const SizedBox(), overlay])),
  );
}
