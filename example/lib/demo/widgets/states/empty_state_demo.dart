import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class EmptyStateDemo extends StatelessWidget {
  const EmptyStateDemo({super.key});

  String get title => 'Empty State';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: title),
      body: ListView(
        padding: JInsets.screenPadding,
        children: <Widget>[
          const SimpleCard(
            child: SimpleEmptyState(
              icon: Icons.inbox_outlined,
              title: 'No bookings yet',
              message: 'New bookings will appear here.',
            ),
          ),
          Gap.h16,
          SimpleCard(
            child: SimpleEmptyState(
              icon: Icons.search_off_outlined,
              title: 'No search results',
              message: 'Try another keyword or refresh your filters.',
              actionLabel: 'Refresh',
              onActionPressed: () {},
            ),
          ),
          Gap.h16,
          SimpleCard(
            child: SimpleEmptyState(
              title: 'Nothing saved',
              message: 'Tap the bookmark icon to save items for later.',
              illustration: Container(
                width: JDimens.dp64,
                height: JDimens.dp64,
                decoration: BoxDecoration(
                  color: JColors.getColor(
                    context,
                    lightKey: 'primary',
                  ).withAlpha(16),
                  borderRadius: BorderRadius.circular(JDimens.dp16),
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.bookmark_border,
                  size: JIconSizes.xl,
                  color: JColors.getColor(context, lightKey: 'primary'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
