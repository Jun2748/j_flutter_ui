import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class ChipDemo extends StatelessWidget {
  const ChipDemo({super.key});

  String get title => 'Chip';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: title),
      body: ListView(
        padding: JInsets.screenPadding,
        children: const <Widget>[
          Wrap(
            spacing: JDimens.dp12,
            runSpacing: JDimens.dp12,
            children: <Widget>[
              SimpleChip.neutral(label: 'Neutral'),
              SimpleChip.primary(label: 'Primary'),
              SimpleChip.success(label: 'Success'),
              SimpleChip.warning(label: 'Warning'),
              SimpleChip.error(label: 'Error'),
            ],
          ),
        ],
      ),
    );
  }
}
