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
      final ThemeData theme = ThemeData.light(useMaterial3: true);

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
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

      expect(
        decoration.fillColor,
        theme.inputDecorationTheme.fillColor ??
            theme.cardTheme.color ??
            theme.colorScheme.surface,
      );
      expect(enabledBorder.borderSide.color, theme.colorScheme.outline);
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
      final ThemeData theme = _withTokens(
        JAppTheme.lightTheme.copyWith(
          textTheme: JAppTheme.lightTheme.textTheme.copyWith(
            bodyMedium: const TextStyle(fontSize: 14),
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

    testWidgets('AppThemeTokens update dropdown input styling', (
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
            body: SimpleDropdown<String>(
              hintText: 'Select an option',
              items: const <DropdownMenuItem<String>>[
                DropdownMenuItem<String>(value: 'one', child: Text('One')),
              ],
              onChanged: _noopDropdownChanged,
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

      expect(decoration.fillColor, const Color(0xFFECFEFF));
      expect(enabledBorder.borderSide.color, const Color(0xFF0891B2));
      expect(decoration.hintStyle?.color, const Color(0xFF92400E));
    });

    testWidgets('AppThemeTokens update switch and checkbox colors', (
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
          home: const Scaffold(
            body: Column(
              children: <Widget>[
                SimpleSwitch(
                  value: false,
                  label: 'Notifications',
                  description: 'Stay informed',
                ),
                SimpleCheckbox(value: true, label: 'Accept terms'),
              ],
            ),
          ),
        ),
      );

      final Switch switchWidget = tester.widget<Switch>(find.byType(Switch));
      final Checkbox checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
      final Text descriptionText = tester.widget<Text>(
        find.text('Stay informed'),
      );

      expect(
        switchWidget.thumbColor?.resolve(<WidgetState>{}),
        const Color(0xFFFDFBF4),
      );
      expect(
        switchWidget.trackColor?.resolve(<WidgetState>{}),
        const Color(0xFFECFEFF),
      );
      expect(
        switchWidget.trackOutlineColor?.resolve(<WidgetState>{}),
        const Color(0xFF0891B2),
      );
      expect(
        checkbox.fillColor?.resolve(<WidgetState>{WidgetState.selected}),
        const Color(0xFF0F766E),
      );
      expect(descriptionText.style?.color, const Color(0xFF92400E));
    });

    testWidgets('AppThemeTokens update segmented control and tabs', (
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
                SimpleSegmentedControl<int>(
                  items: const <SimpleSegmentedItem<int>>[
                    SimpleSegmentedItem<int>(value: 0, label: 'One'),
                    SimpleSegmentedItem<int>(value: 1, label: 'Two'),
                  ],
                  value: 0,
                  onChanged: _noopSegmentedChanged,
                ),
                const SizedBox(height: 240, child: _TabsHarness()),
              ],
            ),
          ),
        ),
      );

      final AnimatedContainer selectedSegment = tester
          .widget<AnimatedContainer>(find.byType(AnimatedContainer).first);
      final BoxDecoration segmentDecoration =
          selectedSegment.decoration! as BoxDecoration;
      final TabBar tabBar = tester.widget<TabBar>(find.byType(TabBar));

      expect(segmentDecoration.color, const Color(0xFF0F766E));
      expect(tabBar.labelColor, const Color(0xFF0F766E));
      expect(tabBar.unselectedLabelColor, const Color(0xFF92400E));
      expect(tabBar.dividerColor, const Color(0xFFF59E0B));
    });

    testWidgets('Material navigation themes override token defaults', (
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
      final ThemeData theme = _withTokens(
        JAppTheme.lightTheme.copyWith(
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Color(0xFF0F172A),
            selectedItemColor: Color(0xFF22C55E),
            unselectedItemColor: Color(0xFF94A3B8),
            selectedLabelStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            selectedIconTheme: IconThemeData(size: 26),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 6,
          ),
          tabBarTheme: const TabBarThemeData(
            labelColor: Color(0xFF2563EB),
            unselectedLabelColor: Color(0xFF64748B),
            indicatorColor: Color(0xFFDC2626),
            dividerColor: Color(0xFF0EA5E9),
            labelPadding: EdgeInsets.symmetric(horizontal: 20),
          ),
        ),
        tokens,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: const SizedBox(height: 240, child: _TabsHarness()),
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
      final TabBar tabBar = tester.widget<TabBar>(find.byType(TabBar));

      expect(nav.backgroundColor, const Color(0xFF0F172A));
      expect(nav.selectedItemColor, const Color(0xFF22C55E));
      expect(nav.unselectedItemColor, const Color(0xFF94A3B8));
      expect(nav.selectedLabelStyle?.fontSize, 15);
      expect(nav.unselectedLabelStyle?.fontSize, 13);
      expect(nav.showSelectedLabels, isFalse);
      expect(nav.showUnselectedLabels, isFalse);
      expect(nav.elevation, 6);
      expect(nav.iconSize, 26);
      expect(tabBar.labelColor, const Color(0xFF2563EB));
      expect(tabBar.unselectedLabelColor, const Color(0xFF64748B));
      expect(tabBar.indicatorColor, const Color(0xFFDC2626));
      expect(tabBar.dividerColor, const Color(0xFF0EA5E9));
      expect(tabBar.labelPadding, const EdgeInsets.symmetric(horizontal: 20));
    });

    testWidgets('Checkbox and switch respect Material component themes', (
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
      final ThemeData theme = _withTokens(
        JAppTheme.lightTheme.copyWith(
          checkboxTheme: CheckboxThemeData(
            fillColor: const WidgetStatePropertyAll<Color>(Color(0xFF2563EB)),
            checkColor: const WidgetStatePropertyAll<Color>(Color(0xFFF8FAFC)),
            side: const BorderSide(color: Color(0xFF1D4ED8), width: 2),
          ),
          switchTheme: SwitchThemeData(
            thumbColor: const WidgetStatePropertyAll<Color>(Color(0xFFDC2626)),
            trackColor: const WidgetStatePropertyAll<Color>(Color(0xFFFCA5A5)),
            trackOutlineColor: const WidgetStatePropertyAll<Color>(
              Color(0xFF991B1B),
            ),
            trackOutlineWidth: const WidgetStatePropertyAll<double>(2),
          ),
        ),
        tokens,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: Column(
              children: <Widget>[
                SimpleSwitch(value: true, label: 'Notifications'),
                SimpleCheckbox(value: true, label: 'Accept terms'),
              ],
            ),
          ),
        ),
      );

      final Switch switchWidget = tester.widget<Switch>(find.byType(Switch));
      final Checkbox checkbox = tester.widget<Checkbox>(find.byType(Checkbox));

      expect(
        switchWidget.thumbColor?.resolve(<WidgetState>{}),
        const Color(0xFFDC2626),
      );
      expect(
        switchWidget.trackColor?.resolve(<WidgetState>{}),
        const Color(0xFFFCA5A5),
      );
      expect(
        switchWidget.trackOutlineColor?.resolve(<WidgetState>{}),
        const Color(0xFF991B1B),
      );
      expect(switchWidget.trackOutlineWidth?.resolve(<WidgetState>{}), 2);
      expect(
        checkbox.fillColor?.resolve(<WidgetState>{WidgetState.selected}),
        const Color(0xFF2563EB),
      );
      expect(checkbox.checkColor, const Color(0xFFF8FAFC));
      expect(checkbox.side?.color, const Color(0xFF1D4ED8));
      expect(checkbox.side?.width, 2);
    });

    testWidgets(
      'SimpleAlertDialog uses tokens and localized default confirm text',
      (WidgetTester tester) async {
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
            home: const Scaffold(
              body: SimpleAlertDialog(
                title: 'Delete item',
                message: 'This action cannot be undone.',
              ),
            ),
          ),
        );

        final AlertDialog dialog = tester.widget<AlertDialog>(
          find.byType(AlertDialog),
        );
        final RoundedRectangleBorder shape =
            dialog.shape! as RoundedRectangleBorder;
        final Text messageText = tester.widget<Text>(
          find.text('This action cannot be undone.'),
        );

        expect(dialog.backgroundColor, const Color(0xFFFDFBF4));
        expect(shape.side.color, const Color(0xFFD97706));
        expect(messageText.style?.color, const Color(0xFF92400E));
        expect(find.text('Okay'), findsOneWidget);
      },
    );

    testWidgets('SimpleAlertDialog respects DialogTheme styling', (
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
      final ThemeData theme = _withTokens(
        JAppTheme.lightTheme.copyWith(
          dialogTheme: DialogThemeData(
            backgroundColor: const Color(0xFF111827),
            surfaceTintColor: const Color(0xFF22C55E),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(JDimens.dp24),
              side: const BorderSide(color: Color(0xFF38BDF8), width: 2),
            ),
          ),
        ),
        tokens,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: SimpleAlertDialog(
              title: 'Delete item',
              message: 'This action cannot be undone.',
            ),
          ),
        ),
      );

      final AlertDialog dialog = tester.widget<AlertDialog>(
        find.byType(AlertDialog),
      );
      final RoundedRectangleBorder shape =
          dialog.shape! as RoundedRectangleBorder;

      expect(dialog.backgroundColor, const Color(0xFF111827));
      expect(dialog.surfaceTintColor, const Color(0xFF22C55E));
      expect(shape.side.color, const Color(0xFF38BDF8));
      expect(shape.side.width, 2);
      expect(shape.borderRadius, BorderRadius.circular(JDimens.dp24));
    });

    testWidgets('AppThemeTokens update shared muted text and divider', (
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
          home: const Scaffold(
            body: Column(
              children: <Widget>[
                FormFieldWrapper(
                  helperText: 'Helper text',
                  child: SizedBox.shrink(),
                ),
                SimpleDivider(),
              ],
            ),
          ),
        ),
      );

      final Text caption = tester.widget<Text>(find.text('Helper text'));
      final Divider divider = tester.widget<Divider>(find.byType(Divider));

      expect(caption.style?.color, const Color(0xFF92400E));
      expect(divider.color, const Color(0xFFF59E0B));
    });

    testWidgets('AppBarEx falls back to AppThemeTokens surface styling', (
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
      final ThemeData theme = _withTokens(
        JAppTheme.lightTheme.copyWith(
          appBarTheme: const AppBarTheme(backgroundColor: null),
        ),
        tokens,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(appBar: AppBarEx(title: 'Profile')),
        ),
      );

      final Material appBarMaterial = tester.widget<Material>(
        find.descendant(
          of: find.byType(AppBarEx),
          matching: find.byType(Material),
        ),
      );
      final DecoratedBox decoratedBox = tester.widget<DecoratedBox>(
        find.descendant(
          of: find.byType(AppBarEx),
          matching: find.byType(DecoratedBox),
        ),
      );
      final BoxDecoration decoration = decoratedBox.decoration as BoxDecoration;

      expect(appBarMaterial.color, const Color(0xFFFDFBF4));
      expect(decoration.border?.bottom.color, const Color(0xFFF59E0B));
    });

    testWidgets(
      'AppBarEx respects AppBarTheme background and foreground colors',
      (WidgetTester tester) async {
        const Color backgroundColor = Color(0xFF123456);
        const Color foregroundColor = Color(0xFFF8FAFC);
        final ThemeData theme = JAppTheme.lightTheme.copyWith(
          appBarTheme: const AppBarTheme(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            titleTextStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            iconTheme: IconThemeData(size: JIconSizes.lg),
          ),
        );

        await tester.pumpWidget(
          MaterialApp(
            theme: theme,
            home: const Scaffold(
              appBar: AppBarEx(title: 'Profile', leading: Icon(Icons.menu)),
            ),
          ),
        );

        final Material appBarMaterial = tester.widget<Material>(
          find.descendant(
            of: find.byType(AppBarEx),
            matching: find.byType(Material),
          ),
        );
        final Finder titleText = find.descendant(
          of: find.byType(AppBarEx),
          matching: find.byWidgetPredicate(
            (Widget widget) =>
                widget is RichText &&
                widget.text.toPlainText() == 'Profile' &&
                widget.text.style?.color == foregroundColor,
          ),
        );
        final Finder foregroundIconTheme = find.descendant(
          of: find.byType(AppBarEx),
          matching: find.byWidgetPredicate(
            (Widget widget) =>
                widget is IconTheme && widget.data.color == foregroundColor,
          ),
        );

        expect(appBarMaterial.color, backgroundColor);
        expect(titleText, findsOneWidget);
        expect(foregroundIconTheme, findsWidgets);
      },
    );

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

void _noopDropdownChanged(String? _) {}

void _noopSegmentedChanged(int _) {}

class _TabsHarness extends StatelessWidget {
  const _TabsHarness();

  @override
  Widget build(BuildContext context) {
    return SimpleTabs(
      tabs: <Tab>[
        Tab(text: 'One'),
        Tab(text: 'Two'),
      ],
      children: <Widget>[SizedBox.expand(), SizedBox.expand()],
    );
  }
}
