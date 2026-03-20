import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class FloatingBannerDemo extends StatelessWidget {
  const FloatingBannerDemo({super.key});

  String get title => 'Floating Banner';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: title),
      bodyPadding: JInsets.screenPadding,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SimpleButton.primary(
            label: 'Show Floating Banner',
            onPressed: () {
              showSimpleFloatingBanner<void>(
                context,
                media: const _BannerArtwork(),
                child: Builder(
                  builder: (BuildContext overlayContext) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SimpleText.heading(text: 'Seasonal announcement'),
                        JGaps.h8,
                        const SimpleText.body(
                          text:
                              'Use this overlay for promos, announcements, onboarding callouts, or image-led notices.',
                          maxLines: 4,
                        ),
                        JGaps.h16,
                        SimpleButton.primary(
                          label: 'Dismiss',
                          onPressed: () {
                            Navigator.of(overlayContext).pop();
                          },
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          ),
          JGaps.h16,
          const SimpleText.body(
            text:
                'The helper presents a centered promotional surface over a dimmed backdrop with optional media, close affordance, and safe-area-aware sizing.',
            maxLines: 5,
          ),
        ],
      ),
    );
  }
}

class _BannerArtwork extends StatelessWidget {
  const _BannerArtwork();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AspectRatio(
      aspectRatio: 4 / 5,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              theme.colorScheme.primary.withAlpha(230),
              theme.colorScheme.secondary.withAlpha(204),
            ],
          ),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: JDimens.dp20,
              left: JDimens.dp20,
              child: Container(
                padding: JInsets.horizontal12Vertical8,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface.withAlpha(235),
                  borderRadius: BorderRadius.circular(JDimens.dp24),
                ),
                child: const SimpleText.label(text: 'Limited-time update'),
              ),
            ),
            Center(
              child: Container(
                width: JDimens.dp120,
                height: JDimens.dp120,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface.withAlpha(220),
                  borderRadius: BorderRadius.circular(JDimens.dp24),
                ),
                child: Icon(
                  Icons.campaign_outlined,
                  size: JDimens.dp64,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            const Positioned(
              bottom: JDimens.dp20,
              left: JDimens.dp20,
              right: JDimens.dp20,
              child: SimpleText.body(
                text: 'Image-heavy promotional content can be dropped in here.',
                color: Colors.white,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
