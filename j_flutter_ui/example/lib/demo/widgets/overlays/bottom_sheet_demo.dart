import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class BottomSheetDemo extends StatelessWidget {
  const BottomSheetDemo({super.key});

  String get title => 'Bottom Sheet';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: title),
      body: ListView(
        padding: JInsets.screenPadding,
        children: <Widget>[
          SimpleButton.primary(
            label: 'Open Simple Bottom Sheet',
            onPressed: () {
              SimpleBottomSheet.show<void>(
                context,
                title: 'Quick Actions',
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SimpleText.body(text: 'Simple bottom sheet content'),
                  ],
                ),
              );
            },
          ),
          Gap.h16,
          SimpleButton.secondary(
            label: 'Open Action List Sheet',
            onPressed: () {
              SimpleBottomSheet.show<void>(
                context,
                title: 'Choose an option',
                message: 'Select one of the actions below.',
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.edit_outlined),
                      title: const Text('Edit item'),
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.share_outlined),
                      title: const Text('Share item'),
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.delete_outline),
                      title: const Text('Delete item'),
                      onTap: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              );
            },
          ),
          Gap.h16,
          SimpleButton.outline(
            label: 'Open Scrollable Sheet',
            onPressed: () {
              SimpleBottomSheet.show<void>(
                context,
                title: 'Scrollable content',
                message: 'This example uses a fixed-height list.',
                child: SizedBox(
                  height: 260,
                  child: ListView.builder(
                    itemCount: 12,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text('Item ${index + 1}'),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
