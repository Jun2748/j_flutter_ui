import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

import '../test_helpers.dart';

/// Colours of the spans whose text contains [needle], across every paragraph.
List<Color?> _coloursOf(WidgetTester tester, String needle) {
  final List<Color?> colours = <Color?>[];
  for (final RenderParagraph paragraph
      in tester.renderObjectList<RenderParagraph>(find.byType(RichText))) {
    paragraph.text.visitChildren((InlineSpan span) {
      if (span is TextSpan && (span.text ?? '').contains(needle)) {
        colours.add(span.style?.color);
      }
      return true;
    });
  }
  return colours;
}

void main() {
  group('AppText useHtml', () {
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

      expect(find.textContaining('Hello world', findRichText: true), findsOne);
      expect(_coloursOf(tester, 'Hello'), contains(colour));
    });
  });

  group('flutter_html with the resolved html package', () {
    // A tag selector also matches by element name, so only a non-tag selector
    // reaches html's selector matcher. flutter_html turns matcher errors into
    // "no match", so a broken matcher shows up as a missing style, not a throw.
    testWidgets('class selectors still style elements', (
      WidgetTester tester,
    ) async {
      const Color colour = Color(0xFF654321);

      await pumpTestApp(
        tester,
        Html(
          data: '<p>Plain <span class="mark">marked</span></p>',
          style: <String, Style>{'.mark': Style(color: colour)},
        ),
      );

      expect(_coloursOf(tester, 'marked'), contains(colour));
    });
  });
}
