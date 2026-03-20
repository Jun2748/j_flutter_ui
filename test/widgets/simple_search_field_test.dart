import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

void main() {
  group('SimpleSearchField', () {
    testWidgets('switches to a new external controller cleanly', (
      WidgetTester tester,
    ) async {
      final TextEditingController firstController = TextEditingController(
        text: 'Alpha',
      );
      final TextEditingController secondController = TextEditingController(
        text: 'Beta',
      );
      addTearDown(firstController.dispose);
      addTearDown(secondController.dispose);

      await tester.pumpWidget(
        MaterialApp(
          theme: JAppTheme.lightTheme,
          home: Scaffold(
            body: _SearchFieldHarness(
              firstController: firstController,
              secondController: secondController,
            ),
          ),
        ),
      );
      await tester.pump();

      EditableText editable = tester.widget<EditableText>(
        find.byType(EditableText),
      );
      expect(editable.controller, same(firstController));
      expect(editable.controller.text, 'Alpha');
      expect(find.byIcon(Icons.close), findsOneWidget);

      await tester.tap(find.text('Swap'));
      await tester.pump();

      editable = tester.widget<EditableText>(find.byType(EditableText));
      expect(editable.controller, same(secondController));
      expect(editable.controller.text, 'Beta');

      firstController.text = 'Stale';
      await tester.pump();

      editable = tester.widget<EditableText>(find.byType(EditableText));
      expect(editable.controller, same(secondController));
      expect(editable.controller.text, 'Beta');

      secondController.clear();
      await tester.pump();

      expect(find.byIcon(Icons.close), findsNothing);
    });

    testWidgets(
      'quiet variant uses search bar theme styling with pill borders',
      (WidgetTester tester) async {
        const Color searchBarFill = Color(0xFFE0F2FE);
        const Color searchBarBorder = Color(0xFF0EA5E9);

        await tester.pumpWidget(
          MaterialApp(
            theme: JAppTheme.lightTheme.copyWith(
              searchBarTheme: SearchBarThemeData(
                backgroundColor: const WidgetStatePropertyAll<Color>(
                  searchBarFill,
                ),
                side: const WidgetStatePropertyAll<BorderSide>(
                  BorderSide(color: searchBarBorder),
                ),
                shape: WidgetStatePropertyAll<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(JDimens.dp20),
                  ),
                ),
              ),
            ),
            home: const Scaffold(
              body: SimpleSearchField(variant: SimpleSearchFieldVariant.quiet),
            ),
          ),
        );

        final InputDecoration decoration = tester
            .widget<InputDecorator>(find.byType(InputDecorator))
            .decoration;
        final OutlineInputBorder enabledBorder =
            decoration.enabledBorder! as OutlineInputBorder;

        expect(decoration.fillColor, searchBarFill);
        expect(enabledBorder.borderSide.color, searchBarBorder);
        expect(enabledBorder.borderRadius, BorderRadius.circular(JDimens.dp20));
      },
    );

    testWidgets(
      'quiet variant falls back to tokens and respects explicit colors',
      (WidgetTester tester) async {
        const AppThemeTokens tokens = AppThemeTokens(
          primary: Color(0xFF2563EB),
          secondary: Color(0xFF0891B2),
          cardBackground: Color(0xFFFFFFFF),
          cardBorderColor: Color(0xFFD1D5DB),
          inputBackground: Color(0xFFF1F5F9),
          inputBorderColor: Color(0xFFCBD5E1),
          dividerColor: Color(0xFFE2E8F0),
          mutedText: Color(0xFF64748B),
        );
        const Color explicitFill = Color(0xFFDCFCE7);
        const Color explicitBorder = Color(0xFF16A34A);

        await tester.pumpWidget(
          MaterialApp(
            theme: _withTokens(
              JAppTheme.lightTheme.copyWith(
                inputDecorationTheme: const InputDecorationTheme(),
              ),
              tokens,
            ),
            home: const Scaffold(
              body: Column(
                children: <Widget>[
                  SimpleSearchField(variant: SimpleSearchFieldVariant.quiet),
                  SimpleSearchField(
                    variant: SimpleSearchFieldVariant.quiet,
                    fillColor: explicitFill,
                    borderColor: explicitBorder,
                  ),
                ],
              ),
            ),
          ),
        );

        final List<InputDecorator> fields = tester
            .widgetList<InputDecorator>(find.byType(InputDecorator))
            .toList();
        final InputDecoration tokenDecoration = fields.first.decoration;
        final InputDecoration explicitDecoration = fields.last.decoration;

        expect(tokenDecoration.fillColor, tokens.inputBackground);
        expect(
          (tokenDecoration.enabledBorder! as OutlineInputBorder)
              .borderSide
              .color,
          Colors.transparent,
        );
        expect(explicitDecoration.fillColor, explicitFill);
        expect(
          (explicitDecoration.enabledBorder! as OutlineInputBorder)
              .borderSide
              .color,
          explicitBorder,
        );
        expect(
          (explicitDecoration.enabledBorder! as OutlineInputBorder)
              .borderRadius,
          BorderRadius.circular(JHeights.input / 2),
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

class _SearchFieldHarness extends StatefulWidget {
  const _SearchFieldHarness({
    required this.firstController,
    required this.secondController,
  });

  final TextEditingController firstController;
  final TextEditingController secondController;

  @override
  State<_SearchFieldHarness> createState() => _SearchFieldHarnessState();
}

class _SearchFieldHarnessState extends State<_SearchFieldHarness> {
  bool _useFirstController = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SimpleSearchField(
          controller: _useFirstController
              ? widget.firstController
              : widget.secondController,
        ),
        TextButton(
          onPressed: () {
            setState(() {
              _useFirstController = false;
            });
          },
          child: const Text('Swap'),
        ),
      ],
    );
  }
}
