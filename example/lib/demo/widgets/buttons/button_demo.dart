import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class ButtonDemo extends StatelessWidget {
  const ButtonDemo({super.key});

  String get title => 'Buttons';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: title),
      body: ListView(
        padding: JInsets.screenPadding,
        children: <Widget>[
          Section(
            title: 'Variants',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SimpleButton.primary(
                  label: 'Primary Button',
                  icon: Icons.check_circle_outline,
                  onPressed: () {},
                ),
                Gap.h16,
                SimpleButton.secondary(
                  label: 'Secondary Button',
                  onPressed: () {},
                ),
                Gap.h16,
                SimpleButton.outline(label: 'Outline Button', onPressed: () {}),
                Gap.h16,
                SimpleButton.text(label: 'Text Button', onPressed: () {}),
              ],
            ),
          ),
          Gap.h16,
          Section(
            title: 'Loading state',
            child: Row(
              children: <Widget>[
                Expanded(
                  child: SimpleButton.primary(
                    label: 'Saving',
                    loading: true,
                    onPressed: () {},
                  ),
                ),
                const Gap.w(JDimens.dp12),
                Expanded(
                  child: SimpleButton.outline(
                    label: 'Syncing',
                    loading: true,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
