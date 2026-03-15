import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

import 'core/demo_category.dart';
import 'core/demo_item.dart';
import 'core/demo_registry.dart';
import 'widget_demo_page.dart';

class WidgetCatalog extends StatefulWidget {
  const WidgetCatalog({super.key});

  @override
  State<WidgetCatalog> createState() => _WidgetCatalogState();
}

class _WidgetCatalogState extends State<WidgetCatalog> {
  static const String _allCategory = 'All';

  String _searchQuery = '';
  String _selectedCategory = _allCategory;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<DemoItem> filteredItems = _filteredItems;
    final Map<String, List<DemoItem>> groupedItems = _groupByCategory(
      filteredItems,
    );
    final List<String> availableCategories = <String>[
      _allCategory,
      ...DemoCategory.ordered.where(
        (String category) => DemoRegistry.items.any(
          (DemoItem item) => item.category == category,
        ),
      ),
    ];

    return AppScaffold(
      appBar: const AppBarEx(title: 'Widget Catalog'),
      body: Column(
        children: <Widget>[
          Padding(
            padding: JInsets.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SimpleSearchField(
                  controller: _searchController,
                  onChanged: (String value) {
                    setState(() {
                      _searchQuery = value.trim();
                    });
                  },
                ),
                Gap.h16,
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: availableCategories
                        .map(
                          (String category) => Padding(
                            padding: const EdgeInsets.only(right: JDimens.dp8),
                            child: ChoiceChip(
                              label: Text(category),
                              selected: _selectedCategory == category,
                              onSelected: (_) {
                                setState(() {
                                  _selectedCategory = category;
                                });
                              },
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          const SimpleDivider(height: 1),
          Expanded(
            child: filteredItems.isEmpty
                ? const _EmptyResults()
                : ListView(
                    children: <Widget>[
                      for (final String category in DemoCategory.ordered)
                        if (groupedItems.containsKey(category)) ...<Widget>[
                          Padding(
                            padding: JInsets.screenPadding,
                            child: SimpleText.heading(text: category),
                          ),
                          ...groupedItems[category]!.map(
                            (DemoItem item) => _DemoTile(item: item),
                          ),
                          const SimpleDivider(height: JDimens.dp24),
                        ],
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  List<DemoItem> get _filteredItems {
    return DemoRegistry.items.where((DemoItem item) {
      final bool matchesCategory =
          _selectedCategory == _allCategory ||
          item.category == _selectedCategory;
      final String searchableText =
          '${item.title} ${item.category} ${item.description ?? ''}'
              .toLowerCase();
      final bool matchesQuery =
          _searchQuery.isEmpty ||
          searchableText.contains(_searchQuery.toLowerCase());

      return matchesCategory && matchesQuery;
    }).toList();
  }

  Map<String, List<DemoItem>> _groupByCategory(List<DemoItem> items) {
    final Map<String, List<DemoItem>> grouped = <String, List<DemoItem>>{};
    for (final DemoItem item in items) {
      grouped.putIfAbsent(item.category, () => <DemoItem>[]).add(item);
    }
    return grouped;
  }
}

class _EmptyResults extends StatelessWidget {
  const _EmptyResults();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: JInsets.screenPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            Icon(Icons.search_off, size: JIconSizes.xl),
            Gap.h16,
            SimpleText.heading(text: 'No demos found'),
            Gap.h8,
            SimpleText.body(
              text: 'Try a different keyword or switch categories.',
              align: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _DemoTile extends StatelessWidget {
  const _DemoTile({required this.item});

  final DemoItem item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: JInsets.screenPadding,
      title: Text(item.title),
      subtitle: item.description == null ? null : Text(item.description!),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(builder: (_) => WidgetDemoPage(item: item)),
        );
      },
    );
  }
}
