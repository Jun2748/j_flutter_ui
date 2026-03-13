import '../widgets/buttons/button_demo.dart';
import '../widgets/cards/card_demo.dart';
import '../widgets/layout/gap_demo.dart';
import '../widgets/layout/section_demo.dart';
import '../widgets/text/text_demo.dart';
import 'demo_category.dart';
import 'demo_item.dart';

class DemoRegistry {
  const DemoRegistry._();

  static final List<DemoItem> items = <DemoItem>[
    DemoItem(
      title: const ButtonDemo().title,
      category: DemoCategory.widgets,
      description: 'Primary, secondary, outline, and text button variants.',
      builder: (_) => const ButtonDemo(),
    ),
    DemoItem(
      title: const CardDemo().title,
      category: DemoCategory.widgets,
      description: 'Basic and tappable card examples.',
      builder: (_) => const CardDemo(),
    ),
    DemoItem(
      title: const TextDemo().title,
      category: DemoCategory.foundations,
      description: 'Typography scale powered by SimpleText.',
      builder: (_) => const TextDemo(),
    ),
    DemoItem(
      title: const GapDemo().title,
      category: DemoCategory.layout,
      description: 'Vertical spacing helpers using Gap tokens.',
      builder: (_) => const GapDemo(),
    ),
    DemoItem(
      title: const SectionDemo().title,
      category: DemoCategory.layout,
      description: 'Section header and content composition.',
      builder: (_) => const SectionDemo(),
    ),
  ];
}
