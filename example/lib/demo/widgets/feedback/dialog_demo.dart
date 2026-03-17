import 'package:flutter/material.dart' hide SimpleDialog;
import 'package:j_flutter_ui/j_flutter_ui.dart';

class DialogDemo extends StatelessWidget {
  const DialogDemo({super.key});

  String get title => 'Dialog';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: title),
      bodyPadding: JInsets.screenPadding,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SimpleButton.primary(
            label: 'Show Confirm Dialog',
            onPressed: () {
              SimpleDialog.show<void>(
                context,
                title: 'Delete item',
                message: 'Are you sure you want to delete this item?',
                cancelText: 'Cancel',
                confirmText: 'Delete',
              );
            },
          ),
          JGaps.h16,
          SimpleButton.secondary(
            label: 'Show Custom Content Dialog',
            onPressed: () {
              SimpleDialog.show<void>(
                context,
                title: 'Session details',
                cancelText: 'Close',
                confirmText: 'Continue',
                content: const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SimpleText.body(
                      text: 'Your session is about to expire in 2 minutes.',
                    ),
                    JGaps.h8,
                    SimpleBadge.warning(
                      label: 'Action needed',
                      icon: Icons.timelapse_outlined,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
