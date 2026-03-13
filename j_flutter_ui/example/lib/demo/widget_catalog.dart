import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

import 'animations/animations_demo.dart';
import 'widgets/buttons/button_demo.dart';
import 'widgets/cards/card_demo.dart';
import 'widgets/layout/gap_demo.dart';
import 'widgets/layout/section_demo.dart';
import 'widgets/text/text_demo.dart';

class WidgetCatalog extends StatelessWidget {
  const WidgetCatalog({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_CatalogItem> items = <_CatalogItem>[
      _CatalogItem(
        title: const ButtonDemo().title,
        builder: (_) => const ButtonDemo(),
      ),
      _CatalogItem(
        title: const CardDemo().title,
        builder: (_) => const CardDemo(),
      ),
      _CatalogItem(
        title: const TextDemo().title,
        builder: (_) => const TextDemo(),
      ),
      _CatalogItem(
        title: const GapDemo().title,
        builder: (_) => const GapDemo(),
      ),
      _CatalogItem(
        title: const SectionDemo().title,
        builder: (_) => const SectionDemo(),
      ),
      _CatalogItem(
        title: const AnimationsDemo().title,
        builder: (_) => const AnimationsDemo(),
      ),
    ];

    return Scaffold(
      appBar: const AppBarEx(title: 'Widget Catalog'),
      body: ListView.separated(
        itemCount: items.length,
        separatorBuilder: (_, _) => const Divider(height: 1),
        itemBuilder: (BuildContext context, int index) {
          final _CatalogItem item = items[index];
          return ListTile(
            title: Text(item.title),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute<void>(builder: item.builder));
            },
          );
        },
      ),
    );
  }
}

class _CatalogItem {
  const _CatalogItem({required this.title, required this.builder});

  final String title;
  final WidgetBuilder builder;
}
