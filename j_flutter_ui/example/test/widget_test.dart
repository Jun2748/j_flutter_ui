import 'package:flutter_test/flutter_test.dart';

import 'package:j_flutter_ui_example/main.dart';

void main() {
  testWidgets('renders widget catalog', (WidgetTester tester) async {
    await tester.pumpWidget(const ExampleApp());

    expect(find.text('Widget Catalog'), findsOneWidget);
    expect(find.text('Buttons'), findsOneWidget);
    expect(find.text('Cards'), findsOneWidget);
    expect(find.text('Text'), findsOneWidget);
  });
}
