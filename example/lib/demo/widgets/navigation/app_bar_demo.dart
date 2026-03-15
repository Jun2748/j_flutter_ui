import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class AppBarDemo extends StatelessWidget {
  const AppBarDemo({super.key});

  String get title => 'App Bar';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: title),
      body: ListView(
        padding: JInsets.screenPadding,
        children: <Widget>[
          const _AppBarPreviewCard(
            title: 'Default app bar',
            child: AppBarEx(title: 'Bookings'),
          ),
          Gap.h16,
          const _AppBarPreviewCard(
            title: 'Centered title',
            child: AppBarEx(title: 'Explore', centerTitle: true),
          ),
          Gap.h16,
          const _AppBarPreviewCard(
            title: 'Leading and actions',
            child: AppBarEx(
              title: 'Profile',
              leading: BackButton(),
              actions: <Widget>[
                IconButton(onPressed: null, icon: Icon(Icons.search_outlined)),
                IconButton(onPressed: null, icon: Icon(Icons.more_vert)),
              ],
            ),
          ),
          Gap.h16,
          _AppBarPreviewCard(
            title: 'Lightweight auth header',
            child: AppBarEx(
              title: 'Login or Sign Up',
              centerTitle: true,
              backgroundColor: Colors.transparent,
              padding: JInsets.horizontal16,
              trailing: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: JColors.getColor(context, lightKey: 'card'),
                  borderRadius: BorderRadius.circular(JDimens.dp12),
                  border: Border.all(
                    color: JColors.getColor(context, lightKey: 'border'),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: JDimens.dp12,
                    vertical: JDimens.dp8,
                  ),
                  child: SimpleText.label(text: 'EN', weight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AppBarPreviewCard extends StatelessWidget {
  const _AppBarPreviewCard({required this.title, required this.child});

  final String title;
  final PreferredSizeWidget child;

  @override
  Widget build(BuildContext context) {
    return SimpleCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SimpleText.label(text: title),
          const Gap.h(JDimens.dp12),
          ClipRRect(
            borderRadius: BorderRadius.circular(JDimens.dp12),
            child: SizedBox(
              height: child.preferredSize.height,
              child: Material(
                color: Theme.of(context).colorScheme.surface,
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
