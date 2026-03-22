import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class MultiSelectChipBarDemo extends StatefulWidget {
  const MultiSelectChipBarDemo({super.key});

  String get title => 'Multi-Select Chip Bar';

  @override
  State<MultiSelectChipBarDemo> createState() => _MultiSelectChipBarDemoState();
}

class _MultiSelectChipBarDemoState extends State<MultiSelectChipBarDemo> {
  static const List<String> _toppings = <String>[
    'Caramel',
    'Vanilla',
    'Chocolate',
    'Hazelnut',
    'Cinnamon',
  ];

  Set<String> _selected = const <String>{'Caramel'};
  Set<String> _limited = const <String>{};

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: widget.title),
      body: ListView(
        padding: JInsets.screenPadding,
        children: <Widget>[
          SimpleText.sectionLabel(text: 'MULTI-SELECT (unlimited)'),
          JGaps.h8,
          SimpleCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SimpleMultiSelectChipBar<String>(
                  items: _toppings,
                  values: _selected,
                  onChanged: (Set<String> v) => setState(() => _selected = v),
                  labelBuilder: (String item) => item,
                ),
                JGaps.h12,
                SimpleText.label(
                  text: _selected.isEmpty ? 'None selected' : _selected.join(', '),
                ),
              ],
            ),
          ),
          JGaps.h16,
          SimpleText.sectionLabel(text: 'MAX 2 SELECTIONS'),
          JGaps.h8,
          SimpleCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SimpleMultiSelectChipBar<String>(
                  items: _toppings,
                  values: _limited,
                  maxSelections: 2,
                  onChanged: (Set<String> v) => setState(() => _limited = v),
                  labelBuilder: (String item) => item,
                ),
                JGaps.h12,
                SimpleText.label(
                  text: _limited.isEmpty ? 'None selected' : _limited.join(', '),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
