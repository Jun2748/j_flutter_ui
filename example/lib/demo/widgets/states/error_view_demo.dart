import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class ErrorViewDemo extends StatelessWidget {
  const ErrorViewDemo({super.key});

  String get title => 'Error View';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: title),
      body: ListView(
        padding: JInsets.screenPadding,
        children: <Widget>[
          const SimpleCard(
            child: SimpleErrorView(message: 'We could not load your bookings.'),
          ),
          Gap.h16,
          SimpleCard(
            child: SimpleErrorView(
              title: 'Unable to refresh',
              message: 'Please check your connection and try again.',
              retryLabel: 'Try Again',
              onRetry: () {},
            ),
          ),
          Gap.h16,
          Section(
            title: 'Inline section error',
            child: SimpleCard(
              child: SimpleErrorView(
                icon: Icons.cloud_off_outlined,
                message: 'This section failed to load.',
                retryLabel: 'Reload Section',
                onRetry: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
