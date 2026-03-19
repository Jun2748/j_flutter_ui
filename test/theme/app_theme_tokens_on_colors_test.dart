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

    testWidgets(
      'primary badge and selected controls follow AppThemeTokens primary pair',
      (WidgetTester tester) async {
        const AppThemeTokens tokens = AppThemeTokens(
          primary: Color(0xFF102030),
          onPrimary: Color(0xFFFEDCBA),
          secondary: Color(0xFF7C3AED),
          cardBackground: Color(0xFFFDFBF4),
          cardBorderColor: Color(0xFFD97706),
          inputBackground: Color(0xFFECFEFF),
          inputBorderColor: Color(0xFF0891B2),
          dividerColor: Color(0xFFF59E0B),
          mutedText: Color(0xFF92400E),
        );

        final ThemeData theme = _withTokens(
          JAppTheme.lightTheme.copyWith(
            colorScheme: JAppTheme.lightTheme.colorScheme.copyWith(
              primary: const Color(0xFFDC2626),
              onPrimary: const Color(0xFF22C55E),
            ),
          ),
          tokens,
        );

        await tester.pumpWidget(
          MaterialApp(
            theme: theme,
            home: Scaffold(
              body: Column(
                children: <Widget>[
                  const SimpleBadge.primary(label: 'Primary badge'),
                  const SimpleCheckbox(value: true, label: 'Accept'),
                  const SimpleSwitch(value: true, label: 'Notifications'),
                  SimpleSegmentedControl<int>(
                    items: const <SimpleSegmentedItem<int>>[
                      SimpleSegmentedItem<int>(value: 1, label: 'One'),
                      SimpleSegmentedItem<int>(value: 2, label: 'Two'),
                    ],
                    value: 1,
                    onChanged: _noopSegmentedChanged,
                  ),
                ],
              ),
            ),
          ),
        );

        final Text badgeText = tester.widget<Text>(find.text('Primary badge'));
        final Checkbox checkbox = tester.widget<Checkbox>(
          find.byType(Checkbox),
        );
        final Switch switchWidget = tester.widget<Switch>(find.byType(Switch));
        final Text selectedSegmentText = tester.widget<Text>(find.text('One'));

        expect(badgeText.style?.color, const Color(0xFF102030));
        expect(checkbox.checkColor, const Color(0xFFFEDCBA));
        expect(
          switchWidget.thumbColor?.resolve(<WidgetState>{WidgetState.selected}),
          const Color(0xFFFEDCBA),
        );
        expect(selectedSegmentText.style?.color, const Color(0xFFFEDCBA));
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

void _noopSegmentedChanged(int _) {}
