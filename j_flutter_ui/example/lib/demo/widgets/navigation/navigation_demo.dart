import 'package:flutter/material.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

class NavigationDemo extends StatefulWidget {
  const NavigationDemo({super.key});

  String get title => 'Navigation';

  @override
  State<NavigationDemo> createState() => _NavigationDemoState();
}

class _NavigationDemoState extends State<NavigationDemo> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    const List<String> labels = <String>['Home', 'Explore', 'Profile'];

    return AppScaffold(
      appBar: AppBarEx(
        title: widget.title,
        centerTitle: true,
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz)),
        ],
      ),
      bottomNavigationBar: BottomNavBarEx(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const <BottomNavItem>[
          BottomNavItem(icon: Icons.home_outlined, label: 'Home'),
          BottomNavItem(icon: Icons.explore_outlined, label: 'Explore'),
          BottomNavItem(icon: Icons.person_outline, label: 'Profile'),
        ],
      ),
      body: Center(
        child: SimpleCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SimpleText.label(text: 'Current tab'),
              Gap.h8,
              SimpleText.heading(text: labels[_currentIndex]),
              Gap.h16,
              const SimpleText.body(
                text: 'This page demonstrates AppBarEx and BottomNavBarEx.',
                align: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
