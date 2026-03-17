import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

void main() {
  group('J theme support', () {
    testWidgets('JColors reads status colors from the host theme', (
      WidgetTester tester,
    ) async {
      Color? successColor;

      await tester.pumpWidget(
        MaterialApp(
          theme: JAppTheme.lightTheme.copyWith(
            extensions: <ThemeExtension<dynamic>>[
              const JStatusColors(
                success: Color(0xFF0E9F6E),
                warning: Color(0xFFF59E0B),
                info: Color(0xFF0284C7),
              ),
            ],
          ),
          home: Builder(
            builder: (BuildContext context) {
              successColor = JColors.getColor(context, lightKey: 'success');
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(successColor, const Color(0xFF0E9F6E));
    });

    testWidgets('SimpleText uses host text styles but allows explicit color', (
      WidgetTester tester,
    ) async {
      final ThemeData theme = JAppTheme.lightTheme.copyWith(
        textTheme: JAppTheme.lightTheme.textTheme.copyWith(
          bodyMedium: const TextStyle(fontSize: 14, color: Color(0xFF0369A1)),
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: Column(
              children: <Widget>[
                SimpleText.caption(text: 'Theme caption'),
                SimpleText.caption(
                  text: 'Override caption',
                  color: Color(0xFFB42318),
                ),
              ],
            ),
          ),
        ),
      );

      final List<Text> texts = tester
          .widgetList<Text>(find.byType(Text))
          .toList();

      expect(texts[0].style?.color, const Color(0xFF0369A1));
      expect(texts[1].style?.color, const Color(0xFFB42318));
    });

    testWidgets('SimpleTextField falls back safely without AppThemeTokens', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(useMaterial3: true),
          home: const Scaffold(
            body: SimpleTextField(
              labelText: 'Email',
              hintText: 'name@example.com',
            ),
          ),
        ),
      );

      final InputDecorator decorator = tester.widget<InputDecorator>(
        find.byType(InputDecorator),
      );
      final InputDecoration decoration = decorator.decoration;
      final OutlineInputBorder enabledBorder =
          decoration.enabledBorder! as OutlineInputBorder;

      expect(decoration.fillColor, JColors.lightPalette['card']);
      expect(enabledBorder.borderSide.color, JColors.lightPalette['border']);
    });

    testWidgets('AppThemeTokens partial override updates core widgets', (
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
      final ThemeData theme = _withTokens(JAppTheme.lightTheme, tokens);

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: Column(
              children: <Widget>[
                SimpleButton.primary(label: 'Save', onPressed: () {}),
                const SimpleCard(child: SizedBox(width: 20, height: 20)),
                const SimpleTextField(
                  labelText: 'Email',
                  hintText: 'name@example.com',
                ),
                const SimpleMenuTile(
                  title: 'Profile',
                  subtitle: 'Manage your account',
                  showBottomDivider: true,
                ),
              ],
            ),
          ),
        ),
      );

      final ElevatedButton button = tester.widget<ElevatedButton>(
        find.byType(ElevatedButton),
      );
      final Card card = tester.widget<Card>(find.byType(Card).first);
      final RoundedRectangleBorder cardShape =
          card.shape! as RoundedRectangleBorder;
      final InputDecorator decorator = tester.widget<InputDecorator>(
        find.byType(InputDecorator),
      );
      final InputDecoration decoration = decorator.decoration;
      final OutlineInputBorder enabledBorder =
          decoration.enabledBorder! as OutlineInputBorder;
      final Text subtitle = tester.widget<Text>(
        find.text('Manage your account'),
      );

      expect(
        button.style!.backgroundColor!.resolve(<WidgetState>{}),
        const Color(0xFF0F766E),
      );
      expect(card.color, const Color(0xFFFDFBF4));
      expect(cardShape.side.color, const Color(0xFFD97706));
      expect(decoration.fillColor, const Color(0xFFECFEFF));
      expect(enabledBorder.borderSide.color, const Color(0xFF0891B2));
      expect(subtitle.style?.color, const Color(0xFF92400E));
    });

    testWidgets(
      'AppThemeTokens full override updates feedback and navigation',
      (WidgetTester tester) async {
        const AppThemeTokens tokens = AppThemeTokens(
          primary: Color(0xFFBE123C),
          secondary: Color(0xFF7E22CE),
          cardBackground: Color(0xFF1F172A),
          cardBorderColor: Color(0xFFF472B6),
          inputBackground: Color(0xFF2E1065),
          inputBorderColor: Color(0xFFA855F7),
          dividerColor: Color(0xFF6D28D9),
          mutedText: Color(0xFFF5D0FE),
        );
        final ThemeData theme = _withTokens(
          JAppTheme.darkTheme.copyWith(
            colorScheme: JAppTheme.darkTheme.colorScheme.copyWith(
              onPrimary: Colors.white,
            ),
          ),
          tokens,
        );

        await tester.pumpWidget(
          MaterialApp(
            theme: theme,
            home: Scaffold(
              body: const Column(
                children: <Widget>[
                  SimpleBanner.info(
                    title: 'Notice',
                    message: 'Important update',
                  ),
                  SimpleBadge.neutral(label: 'Draft'),
                ],
              ),
              bottomNavigationBar: SimpleBottomNavBar(
                currentIndex: 0,
                items: const <SimpleBottomNavItem>[
                  SimpleBottomNavItem(icon: Icons.home_outlined, label: 'Home'),
                  SimpleBottomNavItem(icon: Icons.person_outline, label: 'Me'),
                ],
                onTap: _noopTap,
              ),
            ),
          ),
        );

        final BottomNavigationBar nav = tester.widget<BottomNavigationBar>(
          find.byType(BottomNavigationBar),
        );
        final DecoratedBox badgeBox = tester.widget<DecoratedBox>(
          find.descendant(
            of: find.byType(SimpleBadge),
            matching: find.byType(DecoratedBox),
          ),
        );
        final BoxDecoration badgeDecoration =
            badgeBox.decoration as BoxDecoration;

        expect(nav.backgroundColor, const Color(0xFF1F172A));
        expect(nav.selectedItemColor, const Color(0xFFBE123C));
        expect(badgeDecoration.color, const Color(0xFF1F172A));
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

void _noopTap(int _) {}
