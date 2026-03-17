import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class AccountMenuDemo extends StatefulWidget {
  const AccountMenuDemo({super.key});

  @override
  State<AccountMenuDemo> createState() => _AccountMenuDemoState();
}

class _AccountMenuDemoState extends State<AccountMenuDemo> {
  int _currentIndex = 4;

  @override
  Widget build(BuildContext context) {
    String tr(String key) => Intl.text(key, context: context);
    final Color primary = Theme.of(context).colorScheme.primary;
    final List<SimpleBottomNavItem> navItems = <SimpleBottomNavItem>[
      SimpleBottomNavItem(icon: Icons.home_outlined, label: tr(L.commonHome)),
      SimpleBottomNavItem(
        icon: Icons.restaurant_menu_outlined,
        label: tr(L.commonMenu),
      ),
      SimpleBottomNavItem(
        icon: Icons.card_giftcard_outlined,
        label: tr(L.commonGiftCard),
      ),
      SimpleBottomNavItem(
        icon: Icons.stars_outlined,
        label: tr(L.commonRewards),
      ),
      SimpleBottomNavItem(
        icon: Icons.person_outline,
        label: tr(L.commonAccount),
      ),
    ];

    return SimpleMenuPage(
      title: tr(L.demoAccountTitle),
      trailing: IconButton(
        tooltip: tr(L.commonNotifications),
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
        items: navItems,
      ),
      sections: <Widget>[
        Padding(
          padding: JInsets.screenPadding,
          child: SimpleCard(
            margin: JInsets.zero,
            child: HStack(
              gap: JDimens.dp16,
              children: <Widget>[
                Container(
                  width: JDimens.dp48,
                  height: JDimens.dp48,
                  decoration: BoxDecoration(
                    color: primary.withAlpha(16),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.person_outline,
                    size: JIconSizes.lg,
                    color: primary,
                  ),
                ),
                Expanded(
                  child: VStack(
                    gap: JDimens.dp8,
                    children: <Widget>[
                      SimpleText.heading(text: tr(L.demoAccountHeaderTitle)),
                      SimpleText.caption(
                        text: tr(L.demoAccountHeaderSubtitle),
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
          title: tr(L.demoAccountPurchasesTitle),
          tiles: <SimpleMenuTile>[
            SimpleMenuTile.chevron(
              leading: const Icon(Icons.receipt_long_outlined),
              title: tr(L.demoAccountOrdersTitle),
              subtitle: tr(L.demoAccountOrdersSubtitle),
            ),
            SimpleMenuTile.chevron(
              leading: const Icon(Icons.local_cafe_outlined),
              title: tr(L.demoAccountRegisterTumblerTitle),
            ),
          ],
        ),
        SimpleMenuSection(
          title: tr(L.demoAccountPerksTitle),
          tiles: <SimpleMenuTile>[
            SimpleMenuTile.badge(
              leading: const Icon(Icons.stars_outlined),
              title: tr(L.demoAccountMissionsTitle),
              badgeLabel: '1',
            ),
            SimpleMenuTile.chevron(
              leading: const Icon(Icons.confirmation_number_outlined),
              title: tr(L.demoAccountVouchersTitle),
            ),
            SimpleMenuTile.chevron(
              leading: const Icon(Icons.card_giftcard_outlined),
              title: tr(L.commonGiftCard),
            ),
            SimpleMenuTile.trailingText(
              leading: const Icon(Icons.people_outline),
              title: tr(L.demoAccountInviteTitle),
              trailingText: tr(L.demoAccountInviteTrailing),
            ),
          ],
        ),
        SimpleMenuSection(
          title: tr(L.demoAccountHelpTitle),
          subtitle: tr(L.demoAccountHelpSubtitle),
          action: SimpleButton.text(
            label: tr(L.commonViewAll),
            padding: JInsets.zero,
            onPressed: () {},
          ),
          tiles: <SimpleMenuTile>[
            SimpleMenuTile.chevron(
              leading: const Icon(Icons.help_outline),
              title: tr(L.demoAccountHelpCentreTitle),
            ),
            SimpleMenuTile.chevron(
              leading: const Icon(Icons.chat_bubble_outline),
              title: tr(L.demoAccountFeedbackTitle),
            ),
            SimpleMenuTile.chevron(
              leading: const Icon(Icons.settings_outlined),
              title: tr(L.demoAccountSettingsTitle),
            ),
          ],
        ),
        Padding(
          padding: JInsets.screenPadding,
          child: SimpleCard(
            margin: JInsets.zero,
            child: HStack(
              gap: JDimens.dp12,
              children: <Widget>[
                Expanded(
                  child: VStack(
                    gap: JDimens.dp4,
                    children: <Widget>[
                      SimpleText.body(
                        text: tr(L.demoAccountRewardsTitle),
                        weight: FontWeight.w600,
                      ),
                      SimpleText.caption(
                        text: tr(L.demoAccountRewardsSubtitle),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                const SimpleBadge.warning(label: '1'),
                SimpleButton.text(
                  label: tr(L.commonView),
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
