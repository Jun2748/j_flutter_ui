import 'package:flutter/material.dart';

import '../../resources/dimens.dart';
import '../layout/app_scaffold.dart';
import '../navigation/app_bar_ex.dart';

class SimpleMenuPage extends StatelessWidget {
  const SimpleMenuPage({
    super.key,
    required this.title,
    required this.sections,
    this.trailing,
    this.bottomNavigationBar,
    this.contentPadding,
  });

  final String title;
  final List<Widget> sections;
  final Widget? trailing;
  final Widget? bottomNavigationBar;
  final EdgeInsets? contentPadding;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(
        title: title,
        actions: trailing == null ? null : <Widget>[trailing!],
      ),
      bottomNavigationBar: bottomNavigationBar,
      body: ListView.separated(
        padding:
            contentPadding ??
            const EdgeInsets.only(top: JDimens.dp16, bottom: JDimens.dp24),
        itemCount: sections.length,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox.shrink();
        },
        itemBuilder: (BuildContext context, int index) {
          return sections[index];
        },
      ),
    );
  }
}
