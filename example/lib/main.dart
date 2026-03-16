import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';
import 'package:provider/provider.dart';

import 'demo/widget_catalog.dart';
import 'theme/theme_controller.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeController>(
      create: (_) => ThemeController(),
      child: Consumer<ThemeController>(
        builder: (BuildContext context, ThemeController controller, _) {
          return MaterialApp(
            title: 'j_flutter_ui Catalog',
            debugShowCheckedModeBanner: false,
            theme: JAppTheme.lightTheme,
            darkTheme: JAppTheme.darkTheme,
            themeMode: controller.themeMode,
            home: const WidgetCatalog(),
          );
        },
      ),
    );
  }
}
