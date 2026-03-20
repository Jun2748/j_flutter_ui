import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class ChipBarDemo extends StatefulWidget {
  const ChipBarDemo({super.key});

  String get title => 'Chip Bar';

  @override
  State<ChipBarDemo> createState() => _ChipBarDemoState();
}

class _ChipBarDemoState extends State<ChipBarDemo> {
  String _selectedFilter = 'all';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: widget.title),
      body: ListView(
        padding: JInsets.screenPadding,
        children: <Widget>[
          SimpleChipBar<String>(
            items: const <String>[
              'all',
              'popular',
              'breakfast',
              'desserts',
              'drinks',
            ],
            value: _selectedFilter,
            labelBuilder: _labelFor,
            onChanged: (String value) {
              setState(() {
                _selectedFilter = value;
              });
            },
          ),
          JGaps.h16,
          SimpleCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SimpleText.label(text: 'Current selection'),
                JGaps.h8,
                SimpleText.heading(text: _labelFor(_selectedFilter)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _labelFor(String value) {
    switch (value) {
      case 'all':
        return 'All';
      case 'popular':
        return 'Popular';
      case 'breakfast':
        return 'Breakfast';
      case 'desserts':
        return 'Desserts';
      case 'drinks':
        return 'Drinks';
    }

    return value;
  }
}
