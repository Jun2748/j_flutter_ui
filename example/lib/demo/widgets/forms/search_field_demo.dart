import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class SearchFieldDemo extends StatefulWidget {
  const SearchFieldDemo({super.key});

  String get title => 'Search Field';

  @override
  State<SearchFieldDemo> createState() => _SearchFieldDemoState();
}

class _SearchFieldDemoState extends State<SearchFieldDemo> {
  String _standardQuery = '';
  String _quietQuery = '';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: widget.title),
      body: ListView(
        padding: JInsets.screenPadding,
        children: <Widget>[
          const SimpleText.label(text: 'Standard'),
          JGaps.h8,
          SimpleSearchField(
            onChanged: (String value) {
              setState(() {
                _standardQuery = value;
              });
            },
          ),
          JGaps.h16,
          const SimpleText.label(text: 'Quiet / pill'),
          JGaps.h8,
          SimpleSearchField(
            variant: SimpleSearchFieldVariant.quiet,
            onChanged: (String value) {
              setState(() {
                _quietQuery = value;
              });
            },
          ),
          JGaps.h16,
          SimpleCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SimpleText.label(text: 'Current query'),
                JGaps.h8,
                SimpleText.body(
                  text: _standardQuery.isEmpty
                      ? 'Standard: nothing entered yet.'
                      : 'Standard: $_standardQuery',
                ),
                JGaps.h8,
                SimpleText.body(
                  text: _quietQuery.isEmpty
                      ? 'Quiet: nothing entered yet.'
                      : 'Quiet: $_quietQuery',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
