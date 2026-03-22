import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class PageIndicatorDemo extends StatefulWidget {
  const PageIndicatorDemo({super.key});

  String get title => 'Page Indicator';

  @override
  State<PageIndicatorDemo> createState() => _PageIndicatorDemoState();
}

class _PageIndicatorDemoState extends State<PageIndicatorDemo> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  static const List<String> _pages = <String>[
    'Page 1 — Discover',
    'Page 2 — Order',
    'Page 3 — Track',
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppThemeTokens tokens = Theme.of(context).appThemeTokens;

    return AppScaffold(
      appBar: AppBarEx(title: widget.title),
      body: ListView(
        padding: JInsets.screenPadding,
        children: <Widget>[
          SimpleText.sectionLabel(text: 'LIVE PAGERVIEW'),
          JGaps.h8,
          SimpleCard.flush(
            padding: JInsets.zero,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: JDimens.dp120,
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: _pages.length,
                    onPageChanged: (int i) =>
                        setState(() => _currentPage = i),
                    itemBuilder: (BuildContext context, int i) {
                      return Container(
                        color: tokens.primary.withAlpha(20),
                        child: Center(
                          child: SimpleText.heading(text: _pages[i]),
                        ),
                      );
                    },
                  ),
                ),
                JGaps.h12,
                SimplePageIndicator(
                  count: _pages.length,
                  currentIndex: _currentPage,
                ),
                JGaps.h12,
              ],
            ),
          ),
          JGaps.h16,
          SimpleText.sectionLabel(text: 'STANDALONE'),
          JGaps.h8,
          SimpleCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SimpleText.label(text: '3 pages'),
                JGaps.h8,
                const SimplePageIndicator(count: 3, currentIndex: 0),
                JGaps.h12,
                const SimplePageIndicator(count: 3, currentIndex: 1),
                JGaps.h12,
                const SimplePageIndicator(count: 3, currentIndex: 2),
                JGaps.h12,
                const SimpleText.label(text: '5 pages'),
                JGaps.h8,
                const SimplePageIndicator(count: 5, currentIndex: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
