import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

void main() {
  group('SimpleFloatingBanner', () {
    testWidgets('show helper renders and close button dismisses the banner', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: JAppTheme.lightTheme,
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                return TextButton(
                  onPressed: () {
                    showSimpleFloatingBanner<void>(
                      context,
                      child: const Text('Overlay content'),
                    );
                  },
                  child: const Text('Open'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Overlay content'), findsOneWidget);
      expect(
        find.byKey(
          const ValueKey<String>('simple_floating_banner_close_button'),
        ),
        findsOneWidget,
      );

      await tester.tap(
        find.byKey(
          const ValueKey<String>('simple_floating_banner_close_button'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Overlay content'), findsNothing);
    });

    testWidgets('backdrop tap dismisses when barrierDismissible is true', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: JAppTheme.lightTheme,
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                return TextButton(
                  onPressed: () {
                    showSimpleFloatingBanner<void>(
                      context,
                      child: const Text('Dismissible banner'),
                    );
                  },
                  child: const Text('Open'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      expect(find.text('Dismissible banner'), findsOneWidget);

      final Finder barrierFinder = find.byKey(
        const ValueKey<String>('simple_floating_banner_barrier'),
      );
      final Offset barrierTapTarget =
          tester.getTopLeft(barrierFinder) + const Offset(10, 10);

      await tester.tapAt(barrierTapTarget);
      await tester.pumpAndSettle();

      expect(find.text('Dismissible banner'), findsNothing);
    });

    testWidgets('backdrop tap is ignored when barrierDismissible is false', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: JAppTheme.lightTheme,
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                return TextButton(
                  onPressed: () {
                    showSimpleFloatingBanner<void>(
                      context,
                      barrierDismissible: false,
                      child: const Text('Sticky banner'),
                    );
                  },
                  child: const Text('Open'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      final Finder barrierFinder = find.byKey(
        const ValueKey<String>('simple_floating_banner_barrier'),
      );
      final Offset barrierTapTarget =
          tester.getTopLeft(barrierFinder) + const Offset(10, 10);

      await tester.tapAt(barrierTapTarget);
      await tester.pumpAndSettle();

      expect(find.text('Sticky banner'), findsOneWidget);
    });

    testWidgets('dialog theme styling wins before token fallback', (
      WidgetTester tester,
    ) async {
      const AppThemeTokens tokens = AppThemeTokens(
        primary: Color(0xFF0F766E),
        secondary: Color(0xFF7C3AED),
        cardBackground: Color(0xFFFDFBF4),
        cardBorderColor: Color(0xFFD97706),
        inputBackground: Color(0xFFECFEFF),
        inputBorderColor: Color(0xFF0891B2),
        dividerColor: Color(0xFFF59E0B),
        mutedText: Color(0xFF92400E),
      );
      const Color dialogSurface = Color(0xFFF5F3FF);
      const Color dialogBarrier = Color(0xAA111827);
      const Color dialogBorder = Color(0xFF7C3AED);

      await tester.pumpWidget(
        MaterialApp(
          theme: _withTokens(
            JAppTheme.lightTheme.copyWith(
              dialogTheme: const DialogThemeData(
                backgroundColor: dialogSurface,
                barrierColor: dialogBarrier,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(JDimens.dp20)),
                  side: BorderSide(color: dialogBorder),
                ),
              ),
            ),
            tokens,
          ),
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                return TextButton(
                  onPressed: () {
                    showSimpleFloatingBanner<void>(
                      context,
                      child: const Text('Styled banner'),
                    );
                  },
                  child: const Text('Open'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      final ColoredBox barrier = tester.widget<ColoredBox>(
        find.byKey(const ValueKey<String>('simple_floating_banner_barrier')),
      );
      final Material surface = tester.widget<Material>(
        find.byKey(const ValueKey<String>('simple_floating_banner_surface')),
      );
      final RoundedRectangleBorder shape =
          surface.shape! as RoundedRectangleBorder;

      expect(barrier.color, dialogBarrier);
      expect(surface.color, dialogSurface);
      expect(shape.side.color, dialogBorder);
      expect(shape.borderRadius, BorderRadius.circular(JDimens.dp20));
    });
  });
}

ThemeData _withTokens(ThemeData base, AppThemeTokens tokens) {
  final List<ThemeExtension<dynamic>> extensions =
      base.extensions.values
          .where(
            (ThemeExtension<dynamic> extension) => extension is! AppThemeTokens,
          )
          .toList()
        ..add(tokens);

  return base.copyWith(extensions: extensions);
}
