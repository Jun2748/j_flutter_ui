import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class BannerDemo extends StatefulWidget {
  const BannerDemo({super.key});

  String get title => 'Banner';

  @override
  State<BannerDemo> createState() => _BannerDemoState();
}

class _BannerDemoState extends State<BannerDemo> {
  bool _showDismissibleBanner = true;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: widget.title),
      body: ListView(
        padding: JInsets.screenPadding,
        children: <Widget>[
          const SimpleBanner.info(
            title: 'Heads up',
            message: 'This is a lightweight inline banner for contextual info.',
          ),
          Gap.h16,
          const SimpleBanner.success(
            title: 'Profile updated',
            message: 'Your account details were saved successfully.',
          ),
          Gap.h16,
          SimpleBanner.warning(
            title: 'Incomplete profile',
            message: 'Please complete your profile before continuing.',
            action: SimpleButton.text(
              label: 'Review',
              padding: JInsets.zero,
              onPressed: () {},
            ),
          ),
          Gap.h16,
          if (_showDismissibleBanner)
            SimpleBanner.error(
              title: 'Payment failed',
              message: 'We could not process your payment method just now.',
              onDismiss: () {
                setState(() {
                  _showDismissibleBanner = false;
                });
              },
            )
          else
            SimpleButton.secondary(
              label: 'Restore Dismissible Banner',
              onPressed: () {
                setState(() {
                  _showDismissibleBanner = true;
                });
              },
            ),
        ],
      ),
    );
  }
}
