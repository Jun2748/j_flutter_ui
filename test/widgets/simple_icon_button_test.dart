import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

void main() {
  group('SimpleIconButton', () {
    testWidgets('defaults follow AppThemeTokens primary pair', (
      WidgetTester tester,
    ) async {
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
            body: Row(
              children: <Widget>[
                SimpleIconButton.filled(
                  icon: Icons.add,
                  tooltip: 'Add',
                  onPressed: () {},
                ),
                SimpleIconButton.outline(
                  icon: Icons.remove,
                  tooltip: 'Remove',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );

      final IconButton filled = tester.widget<IconButton>(
        find.widgetWithIcon(IconButton, Icons.add),
      );
      final IconButton outline = tester.widget<IconButton>(
        find.widgetWithIcon(IconButton, Icons.remove),
      );

      expect(
        filled.style?.backgroundColor?.resolve(<WidgetState>{}),
        const Color(0xFF102030),
      );
      expect(
        filled.style?.foregroundColor?.resolve(<WidgetState>{}),
        const Color(0xFFFEDCBA),
      );
      expect(
        outline.style?.foregroundColor?.resolve(<WidgetState>{}),
        const Color(0xFF102030),
      );
      expect(
        outline.style?.side?.resolve(<WidgetState>{})?.color,
        const Color(0xFF102030),
      );
    });

    testWidgets('icon button theme style overrides token defaults', (
      WidgetTester tester,
    ) async {
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
          iconButtonTheme: IconButtonThemeData(
            style: ButtonStyle(
              backgroundColor: const WidgetStatePropertyAll<Color>(
                Color(0xFF1D4ED8),
              ),
              foregroundColor: const WidgetStatePropertyAll<Color>(
                Color(0xFFF8FAFC),
              ),
              side: const WidgetStatePropertyAll<BorderSide>(
                BorderSide(color: Color(0xFF0F172A), width: 2),
              ),
              fixedSize: const WidgetStatePropertyAll<Size>(
                Size.square(JDimens.dp48),
              ),
              iconSize: const WidgetStatePropertyAll<double>(JIconSizes.sm),
            ),
          ),
        ),
        tokens,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: Row(
              children: <Widget>[
                SimpleIconButton.filled(
                  icon: Icons.add_shopping_cart_outlined,
                  tooltip: 'Cart',
                  onPressed: () {},
                ),
                SimpleIconButton.outline(
                  icon: Icons.remove_shopping_cart_outlined,
                  tooltip: 'Remove cart',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );

      final IconButton filled = tester.widget<IconButton>(
        find.widgetWithIcon(IconButton, Icons.add_shopping_cart_outlined),
      );
      final IconButton outline = tester.widget<IconButton>(
        find.widgetWithIcon(IconButton, Icons.remove_shopping_cart_outlined),
      );

      expect(
        filled.style?.backgroundColor?.resolve(<WidgetState>{}),
        const Color(0xFF1D4ED8),
      );
      expect(
        filled.style?.foregroundColor?.resolve(<WidgetState>{}),
        const Color(0xFFF8FAFC),
      );
      expect(filled.constraints?.minWidth, JDimens.dp48);
      expect(filled.constraints?.minHeight, JDimens.dp48);
      expect(filled.iconSize, JIconSizes.sm);
      expect(
        outline.style?.side?.resolve(<WidgetState>{})?.color,
        const Color(0xFF0F172A),
      );
      expect(outline.style?.side?.resolve(<WidgetState>{})?.width, JDimens.dp2);
    });

    testWidgets('explicit params override theme and token styling', (
      WidgetTester tester,
    ) async {
      final ThemeData theme = JAppTheme.lightTheme.copyWith(
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            backgroundColor: const WidgetStatePropertyAll<Color>(
              Color(0xFF1D4ED8),
            ),
            foregroundColor: const WidgetStatePropertyAll<Color>(
              Color(0xFFF8FAFC),
            ),
            side: const WidgetStatePropertyAll<BorderSide>(
              BorderSide(color: Color(0xFF0F172A), width: 2),
            ),
            fixedSize: const WidgetStatePropertyAll<Size>(
              Size.square(JDimens.dp48),
            ),
            iconSize: const WidgetStatePropertyAll<double>(JIconSizes.sm),
          ),
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: SimpleIconButton.outline(
              icon: Icons.add,
              tooltip: 'Add',
              onPressed: () {},
              size: JDimens.dp32,
              iconSize: JIconSizes.xs,
              backgroundColor: const Color(0xFFF8FAFC),
              foregroundColor: const Color(0xFF0F172A),
              borderColor: const Color(0xFFE11D48),
            ),
          ),
        ),
      );

      final IconButton button = tester.widget<IconButton>(
        find.widgetWithIcon(IconButton, Icons.add),
      );

      expect(
        button.style?.backgroundColor?.resolve(<WidgetState>{}),
        const Color(0xFFF8FAFC),
      );
      expect(
        button.style?.foregroundColor?.resolve(<WidgetState>{}),
        const Color(0xFF0F172A),
      );
      expect(
        button.style?.side?.resolve(<WidgetState>{})?.color,
        const Color(0xFFE11D48),
      );
      expect(button.style?.side?.resolve(<WidgetState>{})?.width, JDimens.dp2);
      expect(button.constraints?.minWidth, JDimens.dp32);
      expect(button.constraints?.minHeight, JDimens.dp32);
      expect(button.iconSize, JIconSizes.xs);
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
