import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class SkeletonBoxDemo extends StatefulWidget {
  const SkeletonBoxDemo({super.key});

  String get title => 'Skeleton Box';

  @override
  State<SkeletonBoxDemo> createState() => _SkeletonBoxDemoState();
}

class _SkeletonBoxDemoState extends State<SkeletonBoxDemo> {
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: widget.title),
      body: ListView(
        padding: JInsets.screenPadding,
        children: <Widget>[
          SimpleText.sectionLabel(text: 'SHIMMER VARIANTS'),
          JGaps.h8,
          SimpleCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SimpleSkeletonBox(height: JDimens.dp120),
                JGaps.h12,
                const SimpleSkeletonBox(height: JDimens.dp16, width: JDimens.dp200),
                JGaps.h8,
                const SimpleSkeletonBox(height: JDimens.dp12, width: JDimens.dp140),
                JGaps.h8,
                const SimpleSkeletonBox(height: JDimens.dp12, width: JDimens.dp100),
                JGaps.h12,
                Row(
                  children: const <Widget>[
                    SimpleSkeletonBox(
                      width: JDimens.dp48,
                      height: JDimens.dp48,
                      borderRadius: JDimens.dp24,
                    ),
                    JGaps.w12,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SimpleSkeletonBox(height: JDimens.dp12, width: JDimens.dp120),
                          JGaps.h6,
                          SimpleSkeletonBox(height: JDimens.dp10, width: JDimens.dp80),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          JGaps.h16,
          SimpleText.sectionLabel(text: 'LOADING TOGGLE'),
          JGaps.h8,
          SimpleCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (_loading)
                  const Column(
                    children: <Widget>[
                      SimpleSkeletonBox(height: JDimens.dp64),
                      JGaps.h12,
                      SimpleSkeletonBox(height: JDimens.dp16, width: JDimens.dp160),
                      JGaps.h8,
                      SimpleSkeletonBox(height: JDimens.dp12, width: JDimens.dp100),
                    ],
                  )
                else
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SimpleText.heading(text: 'Cold Brew'),
                      SimpleText.body(text: 'Bold and slow-steeped.'),
                    ],
                  ),
                JGaps.h16,
                SimpleButton.smallOutline(
                  label: _loading ? 'Show Content' : 'Show Skeleton',
                  onPressed: () => setState(() => _loading = !_loading),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
