import 'package:flutter/material.dart';

import 'core/demo_item.dart';

class WidgetDemoPage extends StatelessWidget {
  const WidgetDemoPage({super.key, required this.item});

  final DemoItem item;

  @override
  Widget build(BuildContext context) {
    return item.builder(context);
  }
}
