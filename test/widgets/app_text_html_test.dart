import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

import '../test_helpers.dart';

void main() {
  group('AppText useHtml', () {
    // flutter_html applies the `body` style through CSS selector matching and
    // returns "no match" on any error, so a broken matcher drops the style
    // silently instead of throwing. Checking the colour guards that path.
    testWidgets('renders HTML and applies the body style', (
      WidgetTester tester,
    ) async {
      const Color colour = Color(0xFF123456);

      await pumpTestApp(
        tester,
        const AppText(
          text: '<p>Hello <b>world</b></p>',
          useHtml: true,
          style: TextStyle(color: colour),
        ),
      );

      final Iterable<RenderParagraph> paragraphs = tester
          .renderObjectList<RenderParagraph>(find.byType(RichText));
      final RenderParagraph paragraph = paragraphs.firstWhere(
        (RenderParagraph p) => p.text.toPlainText().contains('Hello'),
      );

      expect(paragraph.text.toPlainText(), contains('Hello world'));

      final List<Color?> colours = <Color?>[];
      paragraph.text.visitChildren((InlineSpan span) {
        if (span is TextSpan && (span.text ?? '').contains('Hello')) {
          colours.add(span.style?.color);
        }
        return true;
      });
      expect(colours, contains(colour));
    });
  });
}
