import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

void main() {
  group('SimpleBottomNavBar', () {
    testWidgets('active icon background is opt-in', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: JAppTheme.lightTheme,
          home: Scaffold(
            bottomNavigationBar: SimpleBottomNavBar(
              currentIndex: 0,
              onTap: (_) {},
              items: const <SimpleBottomNavItem>[
                SimpleBottomNavItem(icon: Icons.home_outlined, label: 'Home'),
                SimpleBottomNavItem(
                  icon: Icons.person_outline,
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      );

      expect(_activeIconBackgroundFinder(), findsNothing);
    });

    testWidgets('wraps the active icon in a circular background when set', (
      WidgetTester tester,
    ) async {
      const Color activeBackground = Color(0xFFDBEAFE);

      await tester.pumpWidget(
        MaterialApp(
          theme: JAppTheme.lightTheme,
          home: Scaffold(
            bottomNavigationBar: SimpleBottomNavBar(
              currentIndex: 1,
              activeIconBackgroundColor: activeBackground,
              onTap: (_) {},
              items: const <SimpleBottomNavItem>[
                SimpleBottomNavItem(icon: Icons.home_outlined, label: 'Home'),
                SimpleBottomNavItem(
                  icon: Icons.person_outline,
                  activeIcon: Icons.person,
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      );

      final DecoratedBox decoratedBox = tester.widget<DecoratedBox>(
        _activeIconBackgroundFinder(),
      );
      final BoxDecoration decoration = decoratedBox.decoration as BoxDecoration;

      expect(decoration.color, activeBackground);
      expect(decoration.shape, BoxShape.circle);
      expect(_activeIconBackgroundFinder(), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('renders a badge when badgeLabel is non-null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: JAppTheme.lightTheme,
          home: Scaffold(
            bottomNavigationBar: SimpleBottomNavBar(
              currentIndex: 0,
              onTap: (_) {},
              items: const <SimpleBottomNavItem>[
                SimpleBottomNavItem(
                  icon: Icons.home_outlined,
                  label: 'Home',
                  badgeLabel: '3',
                ),
                SimpleBottomNavItem(
                  icon: Icons.person_outline,
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(SimpleBadge), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(_badgeAnchorFinder(), findsOneWidget);
    });

    testWidgets('renders no badge when badgeLabel is null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: JAppTheme.lightTheme,
          home: Scaffold(
            bottomNavigationBar: SimpleBottomNavBar(
              currentIndex: 0,
              onTap: (_) {},
              items: const <SimpleBottomNavItem>[
                SimpleBottomNavItem(icon: Icons.home_outlined, label: 'Home'),
                SimpleBottomNavItem(
                  icon: Icons.person_outline,
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(SimpleBadge), findsNothing);
      expect(find.text('3'), findsNothing);
    });
  });
}

Finder _activeIconBackgroundFinder() {
  return find.byWidgetPredicate((Widget widget) {
    if (widget is! DecoratedBox || widget.decoration is! BoxDecoration) {
      return false;
    }

    final BoxDecoration decoration = widget.decoration as BoxDecoration;
    return decoration.shape == BoxShape.circle;
  });
}

Finder _badgeAnchorFinder() {
  return find.byWidgetPredicate((Widget widget) {
    return widget is Stack && widget.clipBehavior == Clip.none;
  });
}
