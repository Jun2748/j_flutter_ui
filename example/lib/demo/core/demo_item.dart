import 'package:flutter/material.dart';

class DemoItem {
  const DemoItem({
    required this.title,
    required this.category,
    required this.builder,
    this.description,
  });

  final String title;
  final String category;
  final String? description;
  final WidgetBuilder builder;
}
