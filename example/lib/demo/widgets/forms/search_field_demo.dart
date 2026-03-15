import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class SearchFieldDemo extends StatefulWidget {
  const SearchFieldDemo({super.key});

  String get title => 'Search Field';

  @override
  State<SearchFieldDemo> createState() => _SearchFieldDemoState();
}

class _SearchFieldDemoState extends State<SearchFieldDemo> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: widget.title),
      body: ListView(
        padding: JInsets.screenPadding,
        children: <Widget>[
          SimpleSearchField(
            onChanged: (String value) {
              setState(() {
                _query = value;
              });
            },
          ),
          Gap.h16,
          SimpleCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SimpleText.label(text: 'Current query'),
                Gap.h8,
                SimpleText.body(
                  text: _query.isEmpty ? 'Nothing entered yet.' : _query,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
