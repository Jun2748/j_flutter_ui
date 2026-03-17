import 'package:flutter/material.dart';

import '../../resources/dimens.dart';
import '../typography/simple_text.dart';
import 'simple_card.dart';
import 'simple_menu_tile.dart';

class SimpleMenuSection extends StatelessWidget {
  const SimpleMenuSection({
    super.key,
    this.title,
    this.subtitle,
    this.action,
    this.tiles = const <SimpleMenuTile>[],
    this.children,
    this.padding,
    this.spacing = JDimens.dp12,
  }) : assert(
         tiles.length > 0 || (children != null && children.length > 0),
         'Provide either tiles or children.',
       );

  final String? title;
  final String? subtitle;
  final Widget? action;
  final List<SimpleMenuTile> tiles;
  final List<Widget>? children;
  final EdgeInsets? padding;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final bool hasTitle = title != null && title!.trim().isNotEmpty;
    final bool hasSubtitle = subtitle != null && subtitle!.trim().isNotEmpty;
    final bool hasHeader = hasTitle || hasSubtitle;
    final List<Widget> content = _buildContent();

    return Padding(
      padding: padding ?? JInsets.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (hasHeader) ...<Widget>[
            if (hasTitle)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: SimpleText.heading(text: title!, maxLines: 2),
                  ),
                  if (action != null) ...<Widget>[JGaps.w12, action!],
                ],
              ),
            if (hasSubtitle) ...<Widget>[
              if (hasTitle) JGaps.h8,
              SimpleText.caption(text: subtitle!, maxLines: 3),
            ],
            SizedBox(height: spacing),
          ],
          ...content,
        ],
      ),
    );
  }

  List<Widget> _buildContent() {
    if (children != null && children!.isNotEmpty) {
      return <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children!,
        ),
      ];
    }

    final int lastIndex = tiles.length - 1;
    final List<SimpleMenuTile> normalizedTiles = tiles.asMap().entries.map((
      MapEntry<int, SimpleMenuTile> entry,
    ) {
      return entry.value.copyWith(
        showTopDivider: false,
        showBottomDivider: entry.key != lastIndex,
      );
    }).toList();

    return <Widget>[
      SimpleCard(
        margin: JInsets.zero,
        padding: JInsets.zero,
        child: Column(children: normalizedTiles),
      ),
    ];
  }
}
