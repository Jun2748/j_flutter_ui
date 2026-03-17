import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';
import 'package:provider/provider.dart';

import 'core/demo_category.dart';
import 'core/demo_item.dart';
import 'core/demo_registry.dart';
import '../theme/theme_controller.dart';
import 'widget_demo_page.dart';

class WidgetCatalog extends StatefulWidget {
  const WidgetCatalog({super.key});

  @override
  State<WidgetCatalog> createState() => _WidgetCatalogState();
}

class _WidgetCatalogState extends State<WidgetCatalog> {
  static const String _allCategory = '_all';

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
    final ThemeMode themeMode = context.watch<ThemeController>().themeMode;
    final List<DemoItem> filteredItems = _filteredItems(context);
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
      appBar: AppBarEx(
        title: Intl.text(L.demoCatalogTitle, context: context),
        actions: <Widget>[
          IconButton(
            tooltip: _themeTooltip(context, themeMode),
            onPressed: () => context.read<ThemeController>().toggle(),
            icon: Icon(_themeIcon(themeMode)),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: JInsets.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SimpleSearchField(
                  controller: _searchController,
                  hintText: Intl.text(
                    L.demoCatalogSearchHint,
                    context: context,
                  ),
                  onChanged: (String value) {
                    setState(() {
                      _searchQuery = value.trim();
                    });
                  },
                ),
                JGaps.h16,
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    spacing: JDimens.dp8,
                    children: availableCategories
                        .map(
                          (String category) => ChoiceChip(
                            label: Text(_categoryLabel(context, category)),
                            selected: _selectedCategory == category,
                            onSelected: (_) {
                              setState(() {
                                _selectedCategory = category;
                              });
                            },
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          const SimpleDivider(height: JDimens.dp1),
          Expanded(
            child: filteredItems.isEmpty
                ? const _EmptyResults()
                : ListView(
                    children: <Widget>[
                      for (final String category in DemoCategory.ordered)
                        if (groupedItems.containsKey(category)) ...<Widget>[
                          Padding(
                            padding: JInsets.screenPadding,
                            child: SimpleText.heading(
                              text: DemoCategory.label(context, category),
                            ),
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

  List<DemoItem> _filteredItems(BuildContext context) {
    return DemoRegistry.items.where((DemoItem item) {
      final bool matchesCategory =
          _selectedCategory == _allCategory ||
          item.category == _selectedCategory;
      final String searchableText =
          '${item.resolvedTitle(context)} '
                  '${DemoCategory.label(context, item.category)} '
                  '${item.resolvedDescription(context) ?? ''}'
              .toLowerCase();
      final bool matchesQuery =
          _searchQuery.isEmpty ||
          searchableText.contains(_searchQuery.toLowerCase());

      return matchesCategory && matchesQuery;
    }).toList();
  }

  String _categoryLabel(BuildContext context, String category) {
    if (category == _allCategory) {
      return Intl.text(L.demoCatalogAll, context: context);
    }

    return DemoCategory.label(context, category);
  }

  Map<String, List<DemoItem>> _groupByCategory(List<DemoItem> items) {
    final Map<String, List<DemoItem>> grouped = <String, List<DemoItem>>{};
    for (final DemoItem item in items) {
      grouped.putIfAbsent(item.category, () => <DemoItem>[]).add(item);
    }
    return grouped;
  }

  IconData _themeIcon(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.system:
        return Icons.brightness_auto;
    }
  }

  String _themeTooltip(BuildContext context, ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return Intl.text(L.demoCatalogThemeLight, context: context);
      case ThemeMode.dark:
        return Intl.text(L.demoCatalogThemeDark, context: context);
      case ThemeMode.system:
        return Intl.text(L.demoCatalogThemeSystem, context: context);
    }
  }
}

class _EmptyResults extends StatelessWidget {
  const _EmptyResults();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: JInsets.screenPadding,
        child: VStack(
          gap: JDimens.dp8,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(Icons.search_off, size: JIconSizes.xl),
            SimpleText.heading(
              text: Intl.text(L.demoCatalogNoResultsTitle, context: context),
            ),
            SimpleText.body(
              text: Intl.text(L.demoCatalogNoResultsMessage, context: context),
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
    final String? description = item.resolvedDescription(context);

    return ListTile(
      contentPadding: JInsets.screenPadding,
      title: Text(item.resolvedTitle(context)),
      subtitle: description == null ? null : Text(description),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(builder: (_) => WidgetDemoPage(item: item)),
        );
      },
    );
  }
}
