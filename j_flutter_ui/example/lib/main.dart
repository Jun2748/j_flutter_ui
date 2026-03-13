import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

import 'demo/widget_catalog.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'j_flutter_ui Catalog',
      debugShowCheckedModeBanner: false,
      theme: JAppTheme.lightTheme,
      home: const WidgetCatalog(),
    );
  }
}
