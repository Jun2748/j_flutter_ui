import 'package:j_flutter_ui/j_flutter_ui.dart';

import '../widgets/buttons/button_demo.dart';
import '../widgets/cards/card_demo.dart';
import '../widgets/controls/chip_bar_demo.dart';
import '../widgets/controls/multi_select_chip_bar_demo.dart';
import '../widgets/controls/quantity_stepper_demo.dart';
import '../widgets/controls/segmented_control_demo.dart';
import '../widgets/display/page_indicator_demo.dart';
import '../widgets/display/rating_bar_demo.dart';
import '../widgets/display/skeleton_box_demo.dart';
import '../widgets/display/step_indicator_demo.dart';
import '../widgets/display/strikethrough_price_demo.dart';
import '../widgets/display/summary_row_demo.dart';
import '../widgets/display/voucher_card_demo.dart';
import '../widgets/foundations/theme_demo.dart';
import '../widgets/images_display/flag_demo.dart';
import '../widgets/images_display/image_helper_demo.dart';
import '../widgets/feedback/badge_demo.dart';
import '../widgets/feedback/banner_demo.dart';
import '../widgets/feedback/chip_demo.dart';
import '../widgets/feedback/dialog_demo.dart';
import '../widgets/feedback/divider_demo.dart';
import '../widgets/feedback/snackbar_demo.dart';
import '../list_item_demo.dart';
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
import '../widgets/layout/grid_demo.dart';
import '../widgets/layout/scaffold_demo.dart';
import '../widgets/layout/section_demo.dart';
import '../widgets/navigation/app_bar_demo.dart';
import '../widgets/navigation/bottom_nav_bar_demo.dart';
import '../widgets/navigation/tabs_demo.dart';
import '../widgets/navigation/vertical_rail_demo.dart';
import '../widgets/overlays/bottom_sheet_demo.dart';
import '../widgets/overlays/floating_banner_demo.dart';
import '../widgets/overlays/progress_overlay_demo.dart';
import '../widgets/screens/account_menu_demo.dart';
import '../widgets/screens/bottom_action_bar_demo.dart';
import '../widgets/states/empty_state_demo.dart';
import '../widgets/states/error_view_demo.dart';
import '../widgets/states/loading_view_demo.dart';
import '../widgets/text/app_text_demo.dart';
import '../widgets/text/text_demo.dart';
import '../stack_demo.dart';
import 'demo_category.dart';
import 'demo_item.dart';

class DemoRegistry {
  const DemoRegistry._();

  static final List<DemoItem> items = <DemoItem>[
    DemoItem(
      titleKey: L.demoTextTitle,
      category: DemoCategory.foundations,
      descriptionKey: L.demoTextRegistryDescription,
      builder: (_) => const TextDemo(),
    ),
    DemoItem(
      title: const AppTextDemo().title,
      category: DemoCategory.foundations,
      description:
          'Higher-level text widget with localization and optional auto-fit support.',
      builder: (_) => const AppTextDemo(),
    ),
    DemoItem(
      titleKey: L.demoThemeTitle,
      category: DemoCategory.foundations,
      descriptionKey: L.demoThemeRegistryDescription,
      builder: (_) => const ThemeDemo(),
    ),
    DemoItem(
      title: const FlagDemo().title,
      category: DemoCategory.foundations,
      description:
          'Flag rendering by country code, asset, and currency mapping.',
      builder: (_) => const FlagDemo(),
    ),
    DemoItem(
      title: const ImageHelperDemo().title,
      category: DemoCategory.foundations,
      description:
          'Examples of loading icon, flag, and illustration SVG assets with Images.svg.',
      builder: (_) => const ImageHelperDemo(),
    ),

    DemoItem(
      titleKey: L.demoButtonTitle,
      category: DemoCategory.controls,
      descriptionKey: L.demoButtonRegistryDescription,
      builder: (_) => const ButtonDemo(),
    ),
    DemoItem(
      titleKey: L.demoTextFieldTitle,
      category: DemoCategory.controls,
      descriptionKey: L.demoTextFieldRegistryDescription,
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
      title: const ChipBarDemo().title,
      category: DemoCategory.controls,
      description:
          'Horizontal single-select chip bar for category and filter choices.',
      builder: (_) => const ChipBarDemo(),
    ),
    DemoItem(
      title: const MultiSelectChipBarDemo().title,
      category: DemoCategory.controls,
      description:
          'Multi-select chip bar with optional max-selection limit.',
      builder: (_) => const MultiSelectChipBarDemo(),
    ),
    DemoItem(
      title: const QuantityStepperDemo().title,
      category: DemoCategory.controls,
      description:
          'Token-aware increment/decrement stepper for cart and order quantities.',
      builder: (_) => const QuantityStepperDemo(),
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
      title: const ListItemDemo().title,
      category: DemoCategory.display,
      description:
          'Low-level list row primitive for navigation, settings, and info layouts.',
      builder: (_) => const ListItemDemo(),
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
      title: const SummaryRowDemo().title,
      category: DemoCategory.display,
      description: 'Label-value row for order summaries and checkout totals.',
      builder: (_) => const SummaryRowDemo(),
    ),
    DemoItem(
      title: const StrikethroughPriceDemo().title,
      category: DemoCategory.display,
      description: 'Original + discounted price pair with lineThrough decoration.',
      builder: (_) => const StrikethroughPriceDemo(),
    ),
    DemoItem(
      title: const RatingBarDemo().title,
      category: DemoCategory.display,
      description: 'Star rating bar with half-star support and review count.',
      builder: (_) => const RatingBarDemo(),
    ),
    DemoItem(
      title: const StepIndicatorDemo().title,
      category: DemoCategory.display,
      description: 'Linear step progress for checkout flows and order tracking.',
      builder: (_) => const StepIndicatorDemo(),
    ),
    DemoItem(
      title: const SkeletonBoxDemo().title,
      category: DemoCategory.display,
      description: 'Animated shimmer placeholder for loading states.',
      builder: (_) => const SkeletonBoxDemo(),
    ),
    DemoItem(
      title: const PageIndicatorDemo().title,
      category: DemoCategory.display,
      description: 'Animated pill-dot page indicator for carousels and onboarding.',
      builder: (_) => const PageIndicatorDemo(),
    ),
    DemoItem(
      title: const VoucherCardDemo().title,
      category: DemoCategory.display,
      description: 'Card with animated dashed border for voucher and promo display.',
      builder: (_) => const VoucherCardDemo(),
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
      titleKey: L.demoAccountTitle,
      category: DemoCategory.screens,
      descriptionKey: L.demoAccountRegistryDescription,
      builder: (_) => const AccountMenuDemo(),
    ),
    DemoItem(
      title: const BottomActionBarDemo().title,
      category: DemoCategory.screens,
      description:
          'Sticky bottom action bar with label, price, and primary CTA. Standard layout for detail and checkout screens.',
      builder: (_) => const BottomActionBarDemo(),
    ),
    DemoItem(
      title: const GapDemo().title,
      category: DemoCategory.layout,
      description:
          'Spacing helpers (JGaps) and RTL-safe directional padding (JInsets.onlyStart / onlyEnd).',
      builder: (_) => const GapDemo(),
    ),
    DemoItem(
      title: const GridDemo().title,
      category: DemoCategory.layout,
      description:
          'Fixed-column grid layout with equal-width cells and aligned partial last rows.',
      builder: (_) => const GridDemo(),
    ),
    DemoItem(
      title: const SectionDemo().title,
      category: DemoCategory.layout,
      description: 'Titled sections wrapping related content.',
      builder: (_) => const SectionDemo(),
    ),
    DemoItem(
      title: const StackDemo().title,
      category: DemoCategory.layout,
      description:
          'Vertical and horizontal stack primitives that add spacing between children.',
      builder: (_) => const StackDemo(),
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
      description:
          'Working bottom navigation with local selection state and item badges.',
      builder: (_) => const BottomNavBarDemo(),
    ),
    DemoItem(
      title: const TabsDemo().title,
      category: DemoCategory.navigation,
      description: 'DefaultTabController wrapper with styled tabs.',
      builder: (_) => const TabsDemo(),
    ),
    DemoItem(
      title: const VerticalRailDemo().title,
      category: DemoCategory.navigation,
      description:
          'Compact vertical icon-label rail for left-edge category navigation.',
      builder: (_) => const VerticalRailDemo(),
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
      title: const FloatingBannerDemo().title,
      category: DemoCategory.overlays,
      description:
          'Centered floating promo-style overlay with optional media and dismiss controls.',
      builder: (_) => const FloatingBannerDemo(),
    ),
    DemoItem(
      title: const ProgressOverlayDemo().title,
      category: DemoCategory.overlays,
      description:
          'Full-screen dimmed loading overlay with a host-provided indicator slot.',
      builder: (_) => const ProgressOverlayDemo(),
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
