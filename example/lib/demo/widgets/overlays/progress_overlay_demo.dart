import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class ProgressOverlayDemo extends StatefulWidget {
  const ProgressOverlayDemo({super.key});

  String get title => 'Progress Overlay';

  @override
  State<ProgressOverlayDemo> createState() => _ProgressOverlayDemoState();
}

enum _ProgressOverlayMode { none, defaultIndicator, customIndicator }

class _ProgressOverlayDemoState extends State<ProgressOverlayDemo> {
  _ProgressOverlayMode _mode = _ProgressOverlayMode.none;

  Future<void> _showOverlay(_ProgressOverlayMode mode) async {
    if (_mode != _ProgressOverlayMode.none) {
      return;
    }

    setState(() {
      _mode = mode;
    });

    await Future<void>.delayed(const Duration(seconds: 2));
    if (!mounted) {
      return;
    }

    setState(() {
      _mode = _ProgressOverlayMode.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isShowingOverlay = _mode != _ProgressOverlayMode.none;

    return Stack(
      children: <Widget>[
        AppScaffold(
          appBar: AppBarEx(title: widget.title),
          body: ListView(
            padding: JInsets.screenPadding,
            children: <Widget>[
              const SimpleCard(
                child: VStack(
                  gap: JDimens.dp12,
                  children: <Widget>[
                    SimpleText.heading(text: 'Stack-based loading overlay'),
                    SimpleText.body(
                      text:
                          'Render SimpleProgressOverlay above your screen content only while work is in flight. This demo auto-dismisses after two seconds.',
                      maxLines: 4,
                    ),
                  ],
                ),
              ),
              JGaps.h16,
              SimpleButton.primary(
                label: 'Show Default Overlay',
                onPressed: isShowingOverlay
                    ? null
                    : () => _showOverlay(_ProgressOverlayMode.defaultIndicator),
              ),
              JGaps.h12,
              SimpleButton.secondary(
                label: 'Show Custom Overlay',
                onPressed: isShowingOverlay
                    ? null
                    : () => _showOverlay(_ProgressOverlayMode.customIndicator),
              ),
              JGaps.h16,
              SimpleCard(
                child: VStack(
                  gap: JDimens.dp12,
                  children: <Widget>[
                    SimpleText.body(
                      text:
                          'Background content stays visible beneath the scrim.',
                      maxLines: 3,
                    ),
                    Wrap(
                      spacing: JDimens.dp8,
                      runSpacing: JDimens.dp8,
                      children: const <Widget>[
                        SimpleChip.neutral(label: 'Orders'),
                        SimpleChip.neutral(label: 'Rewards'),
                        SimpleChip.neutral(label: 'Delivery'),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      padding: JInsets.all16,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withAlpha(18),
                        borderRadius: BorderRadius.circular(JDimens.dp16),
                      ),
                      child: const SimpleText.body(
                        text:
                            'Try pressing one of the buttons above. The overlay blocks interaction while it is visible.',
                        maxLines: 4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (isShowingOverlay)
          SimpleProgressOverlay(
            indicator: _mode == _ProgressOverlayMode.customIndicator
                ? const _DemoIndicator()
                : null,
            message: _mode == _ProgressOverlayMode.customIndicator
                ? 'Syncing rewards...'
                : 'Loading account details...',
          ),
      ],
    );
  }
}

class _DemoIndicator extends StatelessWidget {
  const _DemoIndicator();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(JDimens.dp24),
      ),
      child: Padding(
        padding: JInsets.all16,
        child: Icon(
          Icons.sync_rounded,
          size: JDimens.dp32,
          color: theme.colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }
}
