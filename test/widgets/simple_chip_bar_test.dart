import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

void main() {
  group('SimpleChipBar', () {
    testWidgets('uses a horizontal scroll layout and reports taps', (
      WidgetTester tester,
    ) async {
      String? selectedValue = 'all';

      await tester.pumpWidget(
        MaterialApp(
          theme: JAppTheme.lightTheme,
          home: Scaffold(
            body: SimpleChipBar<String>(
              items: const <String>['all', 'popular', 'new'],
              value: selectedValue,
              labelBuilder: (String item) => item.toUpperCase(),
              onChanged: (String value) {
                selectedValue = value;
              },
            ),
          ),
        ),
      );

      final SingleChildScrollView scrollView = tester.widget(
        find.byType(SingleChildScrollView),
      );

      expect(scrollView.scrollDirection, Axis.horizontal);
      expect(find.text('ALL'), findsOneWidget);
      expect(find.text('POPULAR'), findsOneWidget);
      expect(find.text('NEW'), findsOneWidget);

      await tester.tap(find.text('POPULAR'));
      await tester.pump();

      expect(selectedValue, 'popular');
    });

    testWidgets('prefers ChipTheme values before token fallback', (
      WidgetTester tester,
    ) async {
      const Color themeBackground = Color(0xFFF5F3FF);
      const Color themeSelected = Color(0xFF7C3AED);
      const Color themeBorder = Color(0xFFC4B5FD);
      const Color themeLabel = Color(0xFF5B21B6);
      const Color themeSelectedLabel = Color(0xFFFFFFFF);

      await tester.pumpWidget(
        MaterialApp(
          theme: JAppTheme.lightTheme.copyWith(
            chipTheme: const ChipThemeData(
              backgroundColor: themeBackground,
              secondarySelectedColor: themeSelected,
              side: BorderSide(color: themeBorder),
              labelStyle: TextStyle(color: themeLabel),
              secondaryLabelStyle: TextStyle(color: themeSelectedLabel),
            ),
          ),
          home: Scaffold(
            body: SimpleChipBar<String>(
              items: const <String>['desserts', 'drinks'],
              value: 'desserts',
              labelBuilder: (String item) => item,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      final List<RawChip> chips = tester
          .widgetList<RawChip>(find.byType(RawChip))
          .toList();
      final Text selectedLabel = chips.first.label as Text;
      final Text unselectedLabel = chips.last.label as Text;

      expect(chips, hasLength(2));
      expect(chips.first.selectedColor, themeSelected);
      expect(chips.first.backgroundColor, themeBackground);
      expect(chips.first.side?.color, themeBorder);
      expect(chips.first.showCheckmark, false);
      expect(selectedLabel.style?.color, themeSelectedLabel);
      expect(unselectedLabel.style?.color, themeLabel);
    });

    testWidgets('falls back to tokens and lets explicit colors win', (
      WidgetTester tester,
    ) async {
      const AppThemeTokens tokens = AppThemeTokens(
        primary: Color(0xFF0F766E),
        onPrimary: Color(0xFFF0FDFA),
        secondary: Color(0xFF7C3AED),
        cardBackground: Color(0xFFFAFAF9),
        onCard: Color(0xFF292524),
        cardBorderColor: Color(0xFFD6D3D1),
        inputBackground: Color(0xFFF5F5F4),
        inputBorderColor: Color(0xFFE7E5E4),
        dividerColor: Color(0xFFE7E5E4),
        mutedText: Color(0xFF78716C),
      );
      const Color explicitSelected = Color(0xFFFFEDD5);
      const Color explicitUnselected = Color(0xFFECFCCB);
      const Color explicitSelectedLabel = Color(0xFF9A3412);
      const Color explicitUnselectedLabel = Color(0xFF365314);

      await tester.pumpWidget(
        MaterialApp(
          theme: _withTokens(
            JAppTheme.lightTheme.copyWith(
              chipTheme: const ChipThemeData(),
              textTheme: const TextTheme(),
            ),
            tokens,
          ),
          home: Scaffold(
            body: Column(
              children: <Widget>[
                SimpleChipBar<String>(
                  items: const <String>['all', 'open'],
                  value: 'all',
                  labelBuilder: (String item) => item,
                  onChanged: (_) {},
                ),
                SimpleChipBar<String>(
                  items: const <String>['all', 'open'],
                  value: 'open',
                  labelBuilder: (String item) => item,
                  selectedColor: explicitSelected,
                  unselectedColor: explicitUnselected,
                  selectedLabelColor: explicitSelectedLabel,
                  unselectedLabelColor: explicitUnselectedLabel,
                  onChanged: (_) {},
                ),
              ],
            ),
          ),
        ),
      );

      final List<RawChip> chips = tester
          .widgetList<RawChip>(find.byType(RawChip))
          .toList();
      final Text tokenSelectedLabel = chips[0].label as Text;
      final Text tokenUnselectedLabel = chips[1].label as Text;
      final Text explicitUnselectedText = chips[2].label as Text;
      final Text explicitSelectedText = chips[3].label as Text;

      expect(chips[0].selectedColor, tokens.primary);
      expect(chips[0].backgroundColor, tokens.cardBackground);
      expect(chips[0].side?.color, tokens.cardBorderColor);
      expect(
        tokenSelectedLabel.style?.color,
        tokens.onPrimaryResolved(JAppTheme.lightTheme),
      );
      expect(
        tokenUnselectedLabel.style?.color,
        tokens.onCardResolved(JAppTheme.lightTheme),
      );

      expect(chips[2].selectedColor, explicitSelected);
      expect(chips[2].backgroundColor, explicitUnselected);
      expect(explicitUnselectedText.style?.color, explicitUnselectedLabel);
      expect(explicitSelectedText.style?.color, explicitSelectedLabel);
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
