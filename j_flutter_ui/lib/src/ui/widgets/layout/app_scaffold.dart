import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.bodyPadding,
    this.useSafeArea = true,
  });

  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final EdgeInsets? bodyPadding;
  final bool useSafeArea;

  @override
  Widget build(BuildContext context) {
    Widget resolvedBody = body ?? const SizedBox.shrink();

    if (bodyPadding != null) {
      resolvedBody = Padding(padding: bodyPadding!, child: resolvedBody);
    }

    if (useSafeArea) {
      resolvedBody = SafeArea(child: resolvedBody);
    }

    return Scaffold(
      appBar: appBar,
      body: resolvedBody,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }
}
