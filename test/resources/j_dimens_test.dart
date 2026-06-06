import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

void main() {
  group('JDimens', () {
    test('exposes a complete even-step core scale from 0 to 64', () {
      expect(<double>[
        JDimens.dp0,
        JDimens.dp2,
        JDimens.dp4,
        JDimens.dp6,
        JDimens.dp8,
        JDimens.dp10,
        JDimens.dp12,
        JDimens.dp14,
        JDimens.dp16,
        JDimens.dp18,
        JDimens.dp20,
        JDimens.dp22,
        JDimens.dp24,
        JDimens.dp26,
        JDimens.dp28,
        JDimens.dp30,
        JDimens.dp32,
        JDimens.dp34,
        JDimens.dp36,
        JDimens.dp38,
        JDimens.dp40,
        JDimens.dp42,
        JDimens.dp44,
        JDimens.dp46,
        JDimens.dp48,
        JDimens.dp50,
        JDimens.dp52,
        JDimens.dp54,
        JDimens.dp56,
        JDimens.dp58,
        JDimens.dp60,
        JDimens.dp62,
        JDimens.dp64,
      ], orderedEquals(List<double>.generate(33, (int index) => index * 2.0)));
    });

    test('retains fractional tokens for stroke and typography adjustments', () {
      expect(JDimens.dp0_6, 0.6);
      expect(JDimens.dp1_5, 1.5);
      expect(JDimens.dp16_8, 16.8);
      expect(JDimens.dp33_6, 33.6);
    });
  });
}
