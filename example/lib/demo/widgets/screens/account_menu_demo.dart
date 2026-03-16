import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class AccountMenuDemo extends StatefulWidget {
  const AccountMenuDemo({super.key});

  String get title => 'Menu Patterns';

  @override
  State<AccountMenuDemo> createState() => _AccountMenuDemoState();
}

class _AccountMenuDemoState extends State<AccountMenuDemo> {
  int _currentIndex = 4;

  @override
  Widget build(BuildContext context) {
    return SimpleMenuPage(
      title: widget.title,
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.notifications_none_outlined),
      ),
      bottomNavigationBar: SimpleBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const <SimpleBottomNavItem>[
          SimpleBottomNavItem(icon: Icons.home_outlined, label: 'Home'),
          SimpleBottomNavItem(
            icon: Icons.restaurant_menu_outlined,
            label: 'Menu',
          ),
          SimpleBottomNavItem(
            icon: Icons.card_giftcard_outlined,
            label: 'Gift Card',
          ),
          SimpleBottomNavItem(icon: Icons.stars_outlined, label: 'Rewards'),
          SimpleBottomNavItem(icon: Icons.person_outline, label: 'Account'),
        ],
      ),
      sections: <Widget>[
        Padding(
          padding: JInsets.screenPadding,
          child: SimpleCard(
            margin: JInsets.zero,
            child: Row(
              children: <Widget>[
                Container(
                  width: JDimens.dp48,
                  height: JDimens.dp48,
                  decoration: BoxDecoration(
                    color: JColors.getColor(
                      context,
                      lightKey: 'primary',
                    ).withAlpha(16),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.person_outline,
                    size: JIconSizes.lg,
                    color: JColors.getColor(context, lightKey: 'primary'),
                  ),
                ),
                Gap.w16,
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SimpleText.heading(text: 'Account Overview'),
                      Gap.h8,
                      SimpleText.caption(
                        text:
                            'A realistic composition example using SimpleMenuPage, SimpleMenuSection, and SimpleMenuTile together.',
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SimpleMenuSection(
          title: 'My Purchase',
          tiles: <SimpleMenuTile>[
            SimpleMenuTile.chevron(
              leading: Icon(Icons.receipt_long_outlined),
              title: 'Orders',
              subtitle: 'View order history and recent transactions.',
            ),
            SimpleMenuTile.chevron(
              leading: Icon(Icons.local_cafe_outlined),
              title: 'Register Your Tumbler',
            ),
          ],
        ),
        SimpleMenuSection(
          title: 'Especially For You',
          tiles: <SimpleMenuTile>[
            SimpleMenuTile.badge(
              leading: Icon(Icons.stars_outlined),
              title: 'Missions & Rewards',
              badgeLabel: '1',
            ),
            SimpleMenuTile.chevron(
              leading: Icon(Icons.confirmation_number_outlined),
              title: 'My Vouchers',
            ),
            SimpleMenuTile.chevron(
              leading: Icon(Icons.card_giftcard_outlined),
              title: 'Gift Cards',
            ),
            SimpleMenuTile.trailingText(
              leading: Icon(Icons.people_outline),
              title: 'Invite Your Friends',
              trailingText: 'Earn Voucher',
            ),
          ],
        ),
        SimpleMenuSection(
          title: 'Need Help?',
          subtitle: 'Useful support and account configuration shortcuts.',
          action: SimpleButton.text(
            label: 'View All',
            padding: JInsets.zero,
            onPressed: () {},
          ),
          tiles: const <SimpleMenuTile>[
            SimpleMenuTile.chevron(
              leading: Icon(Icons.help_outline),
              title: 'Help Centre',
            ),
            SimpleMenuTile.chevron(
              leading: Icon(Icons.chat_bubble_outline),
              title: 'Feedback',
            ),
            SimpleMenuTile.chevron(
              leading: Icon(Icons.settings_outlined),
              title: 'Settings',
            ),
          ],
        ),
        Padding(
          padding: JInsets.screenPadding,
          child: SimpleCard(
            margin: JInsets.zero,
            child: Row(
              children: <Widget>[
                const SimpleText.body(
                  text: 'Rewards updates',
                  weight: FontWeight.w600,
                ),
                const Gap.w(JDimens.dp8),
                const SimpleBadge.warning(label: '1'),
                const Spacer(),
                SimpleButton.text(
                  label: 'View',
                  padding: JInsets.zero,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
