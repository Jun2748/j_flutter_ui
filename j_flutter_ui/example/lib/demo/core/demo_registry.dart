import '../widgets/buttons/button_demo.dart';
import '../widgets/cards/card_demo.dart';
import '../widgets/controls/segmented_control_demo.dart';
import '../widgets/feedback/badge_demo.dart';
import '../widgets/feedback/banner_demo.dart';
import '../widgets/feedback/chip_demo.dart';
import '../widgets/feedback/dialog_demo.dart';
import '../widgets/feedback/divider_demo.dart';
import '../widgets/forms/dropdown_demo.dart';
import '../widgets/forms/form_builder_demo.dart';
import '../widgets/forms/form_composition_demo.dart';
import '../widgets/forms/search_field_demo.dart';
import '../widgets/forms/selection_controls_demo.dart';
import '../widgets/forms/text_field_demo.dart';
import '../widgets/layout/gap_demo.dart';
import '../widgets/layout/section_demo.dart';
import '../widgets/navigation/navigation_demo.dart';
import '../widgets/navigation/tabs_demo.dart';
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
      title: const SegmentedControlDemo().title,
      category: DemoCategory.widgets,
      description: 'Segmented selection with equal-width and compact layouts.',
      builder: (_) => const SegmentedControlDemo(),
    ),
    DemoItem(
      title: const TextDemo().title,
      category: DemoCategory.text,
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
    DemoItem(
      title: const TextFieldDemo().title,
      category: DemoCategory.forms,
      description: 'Text input states built with SimpleTextField.',
      builder: (_) => const TextFieldDemo(),
    ),
    DemoItem(
      title: const SearchFieldDemo().title,
      category: DemoCategory.forms,
      description: 'Search input with prefix icon and clear action.',
      builder: (_) => const SearchFieldDemo(),
    ),
    DemoItem(
      title: const DropdownDemo().title,
      category: DemoCategory.forms,
      description: 'Dropdown selection with SimpleDropdown.',
      builder: (_) => const DropdownDemo(),
    ),
    DemoItem(
      title: const SelectionControlsDemo().title,
      category: DemoCategory.forms,
      description: 'Checkbox, radio, and switch controls.',
      builder: (_) => const SelectionControlsDemo(),
    ),
    DemoItem(
      title: const FormCompositionDemo().title,
      category: DemoCategory.forms,
      description: 'SimpleForm, FormSection, and FormFieldWrapper in one flow.',
      builder: (_) => const FormCompositionDemo(),
    ),
    DemoItem(
      title: const FormBuilderDemo().title,
      category: DemoCategory.forms,
      description:
          'Schema-driven forms with initialValues and submit handling.',
      builder: (_) => const FormBuilderDemo(),
    ),
    DemoItem(
      title: const BadgeDemo().title,
      category: DemoCategory.feedback,
      description: 'Compact inline badges with semantic variants.',
      builder: (_) => const BadgeDemo(),
    ),
    DemoItem(
      title: const BannerDemo().title,
      category: DemoCategory.feedback,
      description: 'Inline status banners with action and dismiss options.',
      builder: (_) => const BannerDemo(),
    ),
    DemoItem(
      title: const ChipDemo().title,
      category: DemoCategory.feedback,
      description: 'Status and category chips.',
      builder: (_) => const ChipDemo(),
    ),
    DemoItem(
      title: const DialogDemo().title,
      category: DemoCategory.feedback,
      description: 'Reusable confirm and custom-content dialogs.',
      builder: (_) => const DialogDemo(),
    ),
    DemoItem(
      title: const DividerDemo().title,
      category: DemoCategory.feedback,
      description: 'Default and custom divider styles.',
      builder: (_) => const DividerDemo(),
    ),
    DemoItem(
      title: const NavigationDemo().title,
      category: DemoCategory.navigation,
      description: 'AppBarEx and BottomNavBarEx working together.',
      builder: (_) => const NavigationDemo(),
    ),
    DemoItem(
      title: const TabsDemo().title,
      category: DemoCategory.navigation,
      description: 'DefaultTabController wrapper with styled tabs.',
      builder: (_) => const TabsDemo(),
    ),
  ];
}
