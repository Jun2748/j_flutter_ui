import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class LoadingViewDemo extends StatelessWidget {
  const LoadingViewDemo({super.key});

  String get title => 'Loading View';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: title),
      body: ListView(
        padding: JInsets.screenPadding,
        children: const <Widget>[
          SimpleCard(child: SimpleLoadingView(message: 'Loading bookings...')),
          Gap.h16,
          SimpleCard(child: SimpleLoadingView()),
        ],
      ),
    );
  }
}
