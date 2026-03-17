import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class DemoItem {
  const DemoItem({
    this.title,
    this.titleKey,
    required this.category,
    required this.builder,
    this.description,
    this.descriptionKey,
  }) : assert(
         title != null || titleKey != null,
         'Provide a title or titleKey.',
       );

  final String? title;
  final String? titleKey;
  final String category;
  final String? description;
  final String? descriptionKey;
  final WidgetBuilder builder;

  String resolvedTitle(BuildContext context) {
    if (titleKey != null && titleKey!.trim().isNotEmpty) {
      return Intl.text(titleKey!, context: context);
    }

    return title ?? '';
  }

  String? resolvedDescription(BuildContext context) {
    if (descriptionKey != null && descriptionKey!.trim().isNotEmpty) {
      return Intl.text(descriptionKey!, context: context);
    }

    return description;
  }
}
