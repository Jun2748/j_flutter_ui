import '../widgets/buttons/button_demo.dart';
import '../widgets/cards/card_demo.dart';
import '../widgets/controls/segmented_control_demo.dart';
import '../widgets/feedback/badge_demo.dart';
import '../widgets/feedback/banner_demo.dart';
import '../widgets/feedback/chip_demo.dart';
import '../widgets/feedback/dialog_demo.dart';
import '../widgets/feedback/divider_demo.dart';
import '../widgets/feedback/snackbar_demo.dart';
import '../widgets/forms/backend_error_demo.dart';
import '../widgets/forms/checkbox_demo.dart';
import '../widgets/forms/cross_validation_demo.dart';
import '../widgets/forms/dropdown_demo.dart';
import '../widgets/forms/form_builder_demo.dart';
import '../widgets/forms/form_controller_demo.dart';
import '../widgets/forms/form_composition_demo.dart';
import '../widgets/forms/invalid_scroll_demo.dart';
import '../widgets/forms/radio_demo.dart';
import '../widgets/forms/search_field_demo.dart';
import '../widgets/forms/switch_demo.dart';
import '../widgets/forms/text_field_demo.dart';
import '../widgets/forms/validation_demo.dart';
import '../widgets/layout/gap_demo.dart';
import '../widgets/layout/scaffold_demo.dart';
import '../widgets/layout/section_demo.dart';
import '../widgets/navigation/app_bar_demo.dart';
import '../widgets/navigation/bottom_nav_bar_demo.dart';
import '../widgets/navigation/tabs_demo.dart';
import '../widgets/overlays/bottom_sheet_demo.dart';
import '../widgets/states/empty_state_demo.dart';
import '../widgets/states/error_view_demo.dart';
import '../widgets/states/loading_view_demo.dart';
import '../widgets/text/text_demo.dart';
import 'demo_category.dart';
import 'demo_item.dart';

class DemoRegistry {
  const DemoRegistry._();

  static final List<DemoItem> items = <DemoItem>[
    DemoItem(
      title: const TextDemo().title,
      category: DemoCategory.foundations,
      description: 'Typography scale and color usage powered by SimpleText.',
      builder: (_) => const TextDemo(),
    ),
    DemoItem(
      title: const ButtonDemo().title,
      category: DemoCategory.controls,
      description: 'Primary, secondary, outline, text, and loading buttons.',
      builder: (_) => const ButtonDemo(),
    ),
    DemoItem(
      title: const TextFieldDemo().title,
      category: DemoCategory.controls,
      description:
          'Text field states with labels, helper text, prefix, suffix, and errors.',
      builder: (_) => const TextFieldDemo(),
    ),
    DemoItem(
      title: const SearchFieldDemo().title,
      category: DemoCategory.controls,
      description: 'Search input with live query display and clear behavior.',
      builder: (_) => const SearchFieldDemo(),
    ),
    DemoItem(
      title: const CheckboxDemo().title,
      category: DemoCategory.controls,
      description: 'Labeled checkbox states with manual toggling.',
      builder: (_) => const CheckboxDemo(),
    ),
    DemoItem(
      title: const RadioDemo().title,
      category: DemoCategory.controls,
      description: 'Working radio group with current selection preview.',
      builder: (_) => const RadioDemo(),
    ),
    DemoItem(
      title: const SwitchDemo().title,
      category: DemoCategory.controls,
      description: 'Labeled switches for settings-style interactions.',
      builder: (_) => const SwitchDemo(),
    ),
    DemoItem(
      title: const DropdownDemo().title,
      category: DemoCategory.controls,
      description: 'Dropdown selection with current value display.',
      builder: (_) => const DropdownDemo(),
    ),
    DemoItem(
      title: const SegmentedControlDemo().title,
      category: DemoCategory.controls,
      description: 'Segmented selection with equal-width and compact layouts.',
      builder: (_) => const SegmentedControlDemo(),
    ),
    DemoItem(
      title: const CardDemo().title,
      category: DemoCategory.display,
      description: 'Basic and tappable card examples.',
      builder: (_) => const CardDemo(),
    ),
    DemoItem(
      title: const BadgeDemo().title,
      category: DemoCategory.display,
      description: 'Compact inline badges with semantic variants.',
      builder: (_) => const BadgeDemo(),
    ),
    DemoItem(
      title: const BannerDemo().title,
      category: DemoCategory.display,
      description: 'Inline status banners with action and dismiss options.',
      builder: (_) => const BannerDemo(),
    ),
    DemoItem(
      title: const DividerDemo().title,
      category: DemoCategory.display,
      description: 'Default and custom divider usage between content blocks.',
      builder: (_) => const DividerDemo(),
    ),
    DemoItem(
      title: const ChipDemo().title,
      category: DemoCategory.display,
      description: 'Status and category chip variants.',
      builder: (_) => const ChipDemo(),
    ),
    DemoItem(
      title: const EmptyStateDemo().title,
      category: DemoCategory.display,
      description:
          'Empty-state layouts with icon, custom illustration, and actions.',
      builder: (_) => const EmptyStateDemo(),
    ),
    DemoItem(
      title: const LoadingViewDemo().title,
      category: DemoCategory.display,
      description: 'Loading states for full pages and inline sections.',
      builder: (_) => const LoadingViewDemo(),
    ),
    DemoItem(
      title: const ErrorViewDemo().title,
      category: DemoCategory.display,
      description: 'Error states with retry actions and inline usage.',
      builder: (_) => const ErrorViewDemo(),
    ),
    DemoItem(
      title: const GapDemo().title,
      category: DemoCategory.layout,
      description: 'Spacing helpers using the shared Gap tokens.',
      builder: (_) => const GapDemo(),
    ),
    DemoItem(
      title: const SectionDemo().title,
      category: DemoCategory.layout,
      description: 'Titled sections wrapping related content.',
      builder: (_) => const SectionDemo(),
    ),
    DemoItem(
      title: const ScaffoldDemo().title,
      category: DemoCategory.layout,
      description:
          'AppScaffold usage with app bar, padding, and floating action button.',
      builder: (_) => const ScaffoldDemo(),
    ),
    DemoItem(
      title: const AppBarDemo().title,
      category: DemoCategory.navigation,
      description: 'Simple app bar configurations using AppBarEx.',
      builder: (_) => const AppBarDemo(),
    ),
    DemoItem(
      title: const BottomNavBarDemo().title,
      category: DemoCategory.navigation,
      description: 'Working bottom navigation with local selection state.',
      builder: (_) => const BottomNavBarDemo(),
    ),
    DemoItem(
      title: const TabsDemo().title,
      category: DemoCategory.navigation,
      description: 'DefaultTabController wrapper with styled tabs.',
      builder: (_) => const TabsDemo(),
    ),
    DemoItem(
      title: const DialogDemo().title,
      category: DemoCategory.overlays,
      description: 'Reusable alert and confirm dialog examples.',
      builder: (_) => const DialogDemo(),
    ),
    DemoItem(
      title: const SnackbarDemo().title,
      category: DemoCategory.overlays,
      description:
          'Snackbar helpers with info, success, warning, and error variants.',
      builder: (_) => const SnackbarDemo(),
    ),
    DemoItem(
      title: const BottomSheetDemo().title,
      category: DemoCategory.overlays,
      description: 'Reusable modal bottom sheets with title and content.',
      builder: (_) => const BottomSheetDemo(),
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
          'Schema-driven forms with initial values, field types, and submit handling.',
      builder: (_) => const FormBuilderDemo(),
    ),
    DemoItem(
      title: const FormControllerDemo().title,
      category: DemoCategory.forms,
      description:
          'External controller actions updating a builder-backed form.',
      builder: (_) => const FormControllerDemo(),
    ),
    DemoItem(
      title: const ValidationDemo().title,
      category: DemoCategory.forms,
      description:
          'Required and email validation with rendered error messages.',
      builder: (_) => const ValidationDemo(),
    ),
    DemoItem(
      title: const CrossValidationDemo().title,
      category: DemoCategory.forms,
      description: 'Cross-field validation for confirm password matching.',
      builder: (_) => const CrossValidationDemo(),
    ),
    DemoItem(
      title: const BackendErrorDemo().title,
      category: DemoCategory.forms,
      description: 'Backend field errors through SimpleFormController.',
      builder: (_) => const BackendErrorDemo(),
    ),
    DemoItem(
      title: const InvalidScrollDemo().title,
      category: DemoCategory.forms,
      description:
          'Long forms auto-scroll to the first invalid field on submit.',
      builder: (_) => const InvalidScrollDemo(),
    ),
  ];
}
