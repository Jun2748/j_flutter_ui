import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../tool/widget_index.dart';

void main() {
  test('WIDGETS.md is up to date with the package exports', () {
    final expected = buildIndex(Directory.current.path);
    final actual = File(outputFile).readAsStringSync();
    expect(
      actual,
      expected,
      reason: 'Run `dart run tool/widget_index.dart` and commit WIDGETS.md.',
    );
  });

  test('index lists core widgets and tokens', () {
    final index = buildIndex(Directory.current.path);
    expect(index, contains('`SimpleButton`'));
    expect(index, contains('`JDimens`'));
  });
}
