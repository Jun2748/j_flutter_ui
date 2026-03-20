import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class GridDemo extends StatelessWidget {
  const GridDemo({super.key});

  String get title => 'SimpleGrid';

  static const List<String> _labels = <String>[
    'Espresso',
    'Latte',
    'Mocha',
    'Matcha',
    'Tea',
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: title),
      body: ListView(
        padding: JInsets.screenPadding,
        children: <Widget>[
          Section(
            title: 'Two-column grid',
            child: SimpleGrid(
              columnCount: 2,
              columnGap: JDimens.dp12,
              rowGap: JDimens.dp12,
              children: _labels
                  .map(
                    (String label) => _GridTile(
                      title: label,
                      subtitle: 'Balanced card sizing',
                    ),
                  )
                  .toList(),
            ),
          ),
          JGaps.h24,
          Section(
            title: 'Three-column grid',
            child: SimpleGrid(
              columnCount: 3,
              columnGap: JDimens.dp12,
              rowGap: JDimens.dp12,
              children: _labels
                  .map(
                    (String label) => _GridTile(
                      title: label,
                      subtitle: 'Last row stays aligned',
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _GridTile extends StatelessWidget {
  const _GridTile({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return SimpleCard(
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: JDimens.dp40,
            height: JDimens.dp40,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withAlpha(24),
              borderRadius: BorderRadius.circular(JDimens.dp12),
            ),
            child: Icon(
              Icons.grid_view_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          JGaps.h12,
          SimpleText.label(text: title),
          JGaps.h4,
          SimpleText.caption(text: subtitle, maxLines: 2),
        ],
      ),
    );
  }
}
