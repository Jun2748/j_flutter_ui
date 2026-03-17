import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class SnackbarDemo extends StatelessWidget {
  const SnackbarDemo({super.key});

  String get title => 'Snackbar';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: title),
      body: ListView(
        padding: JInsets.screenPadding,
        children: <Widget>[
          SimpleButton.primary(
            label: 'Show Info Snackbar',
            onPressed: () {
              SimpleSnackbar.showInfo(
                context,
                message: 'A helpful update is available.',
              );
            },
          ),
          JGaps.h16,
          SimpleButton.secondary(
            label: 'Show Success Snackbar',
            onPressed: () {
              SimpleSnackbar.showSuccess(
                context,
                message: 'Profile updated successfully.',
              );
            },
          ),
          JGaps.h16,
          SimpleButton.outline(
            label: 'Show Warning Snackbar',
            onPressed: () {
              SimpleSnackbar.showWarning(
                context,
                message: 'Your profile is still incomplete.',
                actionLabel: 'Review',
                onAction: () {},
              );
            },
          ),
          JGaps.h16,
          SimpleButton.text(
            label: 'Show Error Snackbar',
            onPressed: () {
              SimpleSnackbar.showError(
                context,
                message: 'We could not save your changes.',
              );
            },
          ),
        ],
      ),
    );
  }
}
