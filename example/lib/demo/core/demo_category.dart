import 'package:flutter/widgets.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class DemoCategory {
  const DemoCategory._();

  static const String foundations = 'Foundations';
  static const String controls = 'Controls';
  static const String display = 'Display';
  static const String screens = 'Screens';
  static const String layout = 'Layout';
  static const String navigation = 'Navigation';
  static const String overlays = 'Overlays';
  static const String forms = 'Forms';

  static const List<String> ordered = <String>[
    foundations,
    controls,
    display,
    screens,
    layout,
    navigation,
    overlays,
    forms,
  ];

  static String label(BuildContext context, String category) {
    switch (category) {
      case foundations:
        return Intl.text(L.demoCatalogCategoryFoundations, context: context);
      case controls:
        return Intl.text(L.demoCatalogCategoryControls, context: context);
      case display:
        return Intl.text(L.demoCatalogCategoryDisplay, context: context);
      case screens:
        return Intl.text(L.demoCatalogCategoryScreens, context: context);
      case layout:
        return Intl.text(L.demoCatalogCategoryLayout, context: context);
      case navigation:
        return Intl.text(L.demoCatalogCategoryNavigation, context: context);
      case overlays:
        return Intl.text(L.demoCatalogCategoryOverlays, context: context);
      case forms:
        return Intl.text(L.demoCatalogCategoryForms, context: context);
    }

    return category;
  }
}
