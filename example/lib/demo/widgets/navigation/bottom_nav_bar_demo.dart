import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class BottomNavBarDemo extends StatefulWidget {
  const BottomNavBarDemo({super.key});

  String get title => 'Bottom Nav Bar';

  @override
  State<BottomNavBarDemo> createState() => _BottomNavBarDemoState();
}

class _BottomNavBarDemoState extends State<BottomNavBarDemo> {
  static const List<String> _labels = <String>['Home', 'Explore', 'Profile'];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBarEx(title: widget.title),
      bottomNavigationBar: SimpleBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const <SimpleBottomNavItem>[
          SimpleBottomNavItem(icon: Icons.home_outlined, label: 'Home'),
          SimpleBottomNavItem(icon: Icons.explore_outlined, label: 'Explore'),
          SimpleBottomNavItem(icon: Icons.person_outline, label: 'Profile'),
        ],
      ),
      body: Center(
        child: Padding(
          padding: JInsets.screenPadding,
          child: SimpleCard(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SimpleText.label(text: 'Current destination'),
                JGaps.h8,
                SimpleText.heading(text: _labels[_currentIndex]),
                JGaps.h12,
                const SimpleText.body(
                  text:
                      'Tap the bottom navigation items to verify state updates.',
                  align: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
