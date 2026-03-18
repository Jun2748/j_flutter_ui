import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

void main() {
  group('AppThemeTokens on* resolution', () {
    testWidgets(
      'SimpleButton.primary foreground follows token primary when onPrimary is not provided',
      (WidgetTester tester) async {
        const AppThemeTokens tokens = AppThemeTokens(
          primary: Color(0xFFFFFFFF),
          secondary: Color(0xFF7C3AED),
          cardBackground: Color(0xFFFDFBF4),
          cardBorderColor: Color(0xFFD97706),
          inputBackground: Color(0xFFECFEFF),
          inputBorderColor: Color(0xFF0891B2),
          dividerColor: Color(0xFFF59E0B),
          mutedText: Color(0xFF92400E),
        );

        final ThemeData theme = _withTokens(JAppTheme.lightTheme, tokens);

        await tester.pumpWidget(
          MaterialApp(
            theme: theme,
            home: Scaffold(
              body: SimpleButton.primary(label: 'Save', onPressed: () {}),
            ),
          ),
        );

        final ElevatedButton button = tester.widget<ElevatedButton>(
          find.byType(ElevatedButton),
        );

        expect(
          button.style!.foregroundColor!.resolve(<WidgetState>{}),
          Colors.black,
        );
      },
    );
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

