import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class SegmentedControlDemo extends StatefulWidget {
  const SegmentedControlDemo({super.key});

  String get title => 'Segmented Control';

  @override
  State<SegmentedControlDemo> createState() => _SegmentedControlDemoState();
}

class _SegmentedControlDemoState extends State<SegmentedControlDemo> {
  String _selectedStatus = 'upcoming';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: widget.title),
      body: ListView(
        padding: JInsets.screenPadding,
        children: <Widget>[
          SimpleSegmentedControl<String>(
            value: _selectedStatus,
            items: const <SimpleSegmentedItem<String>>[
              SimpleSegmentedItem(
                value: 'upcoming',
                label: 'Upcoming',
                icon: Icons.calendar_today_outlined,
              ),
              SimpleSegmentedItem(
                value: 'past',
                label: 'Past',
                icon: Icons.history,
              ),
              SimpleSegmentedItem(
                value: 'saved',
                label: 'Saved',
                icon: Icons.bookmark_border,
              ),
            ],
            onChanged: (String value) {
              setState(() {
                _selectedStatus = value;
              });
            },
          ),
          Gap.h16,
          SimpleCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SimpleText.label(text: 'Current selection'),
                Gap.h8,
                SimpleText.heading(text: _selectedStatus),
              ],
            ),
          ),
          Gap.h16,
          SimpleSegmentedControl<String>(
            value: _selectedStatus,
            expanded: false,
            items: const <SimpleSegmentedItem<String>>[
              SimpleSegmentedItem(value: 'upcoming', label: 'Upcoming'),
              SimpleSegmentedItem(value: 'past', label: 'Past'),
              SimpleSegmentedItem(value: 'saved', label: 'Saved'),
            ],
            onChanged: (String value) {
              setState(() {
                _selectedStatus = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
