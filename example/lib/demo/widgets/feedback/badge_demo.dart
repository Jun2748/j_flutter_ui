import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class BadgeDemo extends StatelessWidget {
  const BadgeDemo({super.key});

  String get title => 'Badge';

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
              SimpleBadge.neutral(label: 'Draft'),
              SimpleBadge.primary(label: 'Featured', icon: Icons.star_outline),
              SimpleBadge.success(
                label: 'Active',
                icon: Icons.check_circle_outline,
              ),
              SimpleBadge.warning(
                label: 'Pending',
                icon: Icons.schedule_outlined,
              ),
              SimpleBadge.error(label: 'Blocked', icon: Icons.error_outline),
            ],
          ),
        ],
      ),
    );
  }
}
