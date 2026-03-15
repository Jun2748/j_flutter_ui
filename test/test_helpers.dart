import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

Widget buildTestApp(Widget child) {
  return MaterialApp(
    theme: JAppTheme.lightTheme,
    home: Scaffold(body: child),
  );
}

Future<void> pumpTestApp(WidgetTester tester, Widget child) async {
  await tester.pumpWidget(buildTestApp(child));
  await tester.pump();
}
