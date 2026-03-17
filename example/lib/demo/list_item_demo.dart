import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class ListItemDemo extends StatefulWidget {
  const ListItemDemo({super.key});

  String get title => 'List Item';

  @override
  State<ListItemDemo> createState() => _ListItemDemoState();
}

class _ListItemDemoState extends State<ListItemDemo> {
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: widget.title),
      body: ListView(
        padding: JInsets.screenPadding,
        children: <Widget>[
          SimpleListItem(
            leading: const CircleAvatar(
              radius: JIconSizes.lg,
              child: Icon(Icons.person_outline),
            ),
            title: const SimpleText.body(
              text: 'Profile',
              weight: FontWeight.w600,
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          JGaps.h16,
          SimpleListItem(
            title: const SimpleText.body(
              text: 'Notifications',
              weight: FontWeight.w600,
            ),
            subtitle: const SimpleText.caption(
              text: 'Push alerts and account activity',
            ),
            trailing: SimpleSwitch(
              value: notificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  notificationsEnabled = value;
                });
              },
            ),
          ),
          JGaps.h16,
          const SimpleListItem(
            title: SimpleText.body(text: 'Email', weight: FontWeight.w600),
            subtitle: SimpleText.caption(text: 'user@email.com'),
          ),
        ],
      ),
    );
  }
}
