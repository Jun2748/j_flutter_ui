import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class StackDemo extends StatelessWidget {
  const StackDemo({super.key});

  String get title => 'Stack Demo';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: title),
      body: ListView(
        padding: JInsets.screenPadding,
        children: <Widget>[
          Section(
            title: 'VStack basic example',
            child: SimpleCard(
              child: VStack(
                gap: JDimens.dp16,
                children: const <Widget>[
                  SimpleText.body(text: 'First item'),
                  SimpleText.body(text: 'Second item'),
                  SimpleText.body(text: 'Third item'),
                ],
              ),
            ),
          ),
          Gap.h16,
          Section(
            title: 'HStack basic example',
            child: SimpleCard(
              child: HStack(
                gap: JDimens.dp8,
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  Icon(Icons.search, size: JIconSizes.md),
                  AppText(text: 'Search'),
                  SimpleBadge.primary(label: 'New'),
                ],
              ),
            ),
          ),
          Gap.h16,
          Section(
            title: 'VStack form-like example',
            child: SimpleCard(
              child: VStack(
                gap: JDimens.dp16,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SimpleText.title(text: 'Welcome back'),
                  const AppText(
                    text: 'Use VStack to keep related form content readable.',
                    style: JTextStyles.body2,
                  ),
                  const SimpleTextField(
                    labelText: 'Email address',
                    hintText: 'name@example.com',
                  ),
                  SimpleButton.primary(
                    label: 'Continue',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          Gap.h16,
          Section(
            title: 'HStack action row example',
            child: SimpleCard(
              child: HStack(
                gap: JDimens.dp12,
                children: <Widget>[
                  Expanded(
                    child: SimpleButton.outline(
                      label: 'Cancel',
                      onPressed: () {},
                    ),
                  ),
                  Expanded(
                    child: SimpleButton.primary(
                      label: 'Save',
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
