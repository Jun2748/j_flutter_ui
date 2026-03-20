import 'package:flutter/material.dart';

/// A fixed n-column grid that distributes children into equal-width columns.
///
/// Children are laid out left-to-right, top-to-bottom. If the total number of
/// children is not evenly divisible by [columnCount], the last row is
/// left-aligned and empty cells are filled with invisible placeholders so
/// column widths stay consistent.
///
/// ```dart
/// SimpleGrid(
///   columnCount: 2,
///   columnGap: JDimens.dp16,
///   rowGap: JDimens.dp20,
///   children: products.map((p) => ProductTile(p)).toList(),
/// )
/// ```
class SimpleGrid extends StatelessWidget {
  const SimpleGrid({
    super.key,
    required this.columnCount,
    required this.children,
    this.columnGap = 0,
    this.rowGap = 0,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  }) : assert(columnCount > 0, 'columnCount must be at least 1');

  /// Number of columns per row.
  final int columnCount;

  /// Horizontal gap between columns.
  final double columnGap;

  /// Vertical gap between rows.
  final double rowGap;

  /// How each cell aligns its child vertically within a row.
  final CrossAxisAlignment crossAxisAlignment;

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final List<Widget> rows = <Widget>[];

    for (int i = 0; i < children.length; i += columnCount) {
      if (rows.isNotEmpty && rowGap > 0) {
        rows.add(SizedBox(height: rowGap));
      }

      final List<Widget> cells = <Widget>[];
      for (int col = 0; col < columnCount; col++) {
        if (cells.isNotEmpty && columnGap > 0) {
          cells.add(SizedBox(width: columnGap));
        }
        final int childIndex = i + col;
        cells.add(
          Expanded(
            child: childIndex < children.length
                ? children[childIndex]
                : const SizedBox.shrink(),
          ),
        );
      }

      rows.add(
        Row(
          crossAxisAlignment: crossAxisAlignment,
          children: cells,
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows,
    );
  }
}
