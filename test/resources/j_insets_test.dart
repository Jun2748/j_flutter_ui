import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

void main() {
  group('JInsets — directional variants', () {
    group('onlyStart', () {
      test('constants are EdgeInsetsDirectional', () {
        expect(JInsets.onlyStart8, isA<EdgeInsetsDirectional>());
        expect(JInsets.onlyStart12, isA<EdgeInsetsDirectional>());
        expect(JInsets.onlyStart16, isA<EdgeInsetsDirectional>());
        expect(JInsets.onlyStart20, isA<EdgeInsetsDirectional>());
        expect(JInsets.onlyStart24, isA<EdgeInsetsDirectional>());
      });

      test('start values match JDimens steps', () {
        expect(JInsets.onlyStart8.start, JDimens.dp8);
        expect(JInsets.onlyStart12.start, JDimens.dp12);
        expect(JInsets.onlyStart16.start, JDimens.dp16);
        expect(JInsets.onlyStart20.start, JDimens.dp20);
        expect(JInsets.onlyStart24.start, JDimens.dp24);
      });

      test('end, top, and bottom are zero', () {
        for (final EdgeInsetsDirectional inset in <EdgeInsetsDirectional>[
          JInsets.onlyStart8,
          JInsets.onlyStart16,
          JInsets.onlyStart24,
        ]) {
          expect(inset.end, 0);
          expect(inset.top, 0);
          expect(inset.bottom, 0);
        }
      });
    });

    group('onlyEnd', () {
      test('constants are EdgeInsetsDirectional', () {
        expect(JInsets.onlyEnd8, isA<EdgeInsetsDirectional>());
        expect(JInsets.onlyEnd12, isA<EdgeInsetsDirectional>());
        expect(JInsets.onlyEnd16, isA<EdgeInsetsDirectional>());
        expect(JInsets.onlyEnd20, isA<EdgeInsetsDirectional>());
        expect(JInsets.onlyEnd24, isA<EdgeInsetsDirectional>());
      });

      test('end values match JDimens steps', () {
        expect(JInsets.onlyEnd8.end, JDimens.dp8);
        expect(JInsets.onlyEnd12.end, JDimens.dp12);
        expect(JInsets.onlyEnd16.end, JDimens.dp16);
        expect(JInsets.onlyEnd20.end, JDimens.dp20);
        expect(JInsets.onlyEnd24.end, JDimens.dp24);
      });

      test('start, top, and bottom are zero', () {
        for (final EdgeInsetsDirectional inset in <EdgeInsetsDirectional>[
          JInsets.onlyEnd8,
          JInsets.onlyEnd16,
          JInsets.onlyEnd24,
        ]) {
          expect(inset.start, 0);
          expect(inset.top, 0);
          expect(inset.bottom, 0);
        }
      });
    });
  });
}
