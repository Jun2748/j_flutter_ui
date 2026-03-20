# j_flutter_ui

## Hero
j_flutter_ui is a reusable Flutter UI library and design system for building consistent production mobile apps.
- Gives teams a shared visual foundation for forms, navigation, overlays, status screens, and everyday layout pieces.
- Keeps branding flexible with theme-ready colors, spacing, typography, and light/dark support.
- Helps apps stay consistent without rebuilding the same interface patterns over and over.
- Includes localization-ready copy flows and safe fallbacks for multi-app environments.
Built for Flutter teams shipping multiple apps and for clients who want to see production-grade system design, not one-off screens.
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## What's included

**Controls**
- `SimpleButton` — button family with primary, secondary, outline, and text variants.
- `SimpleIconButton` — compact icon action button for toolbars, cards, and list rows.
- `SimpleDropdown` — dropdown field that follows the library input styling and validation patterns.
- `SimpleCheckbox` — checkbox control with optional inline label content.
- `SimpleRadio` — radio option control for mutually exclusive choices.
- `SimpleSearchField` — search input with standard and quiet variants.
- `SimpleSwitch` — theme-aware on/off switch for preferences and settings.
- `SimpleTextField` — text field wrapper with labels, helpers, errors, and icon slots.
- `SimpleChipBar` — horizontally scrollable chip selector for quick filters and categories.
- `SimpleSegmentedControl` — segmented selector for a small set of mutually exclusive options.

**Display**
- `SimpleCard` — reusable card surface for grouped content and summary blocks.
- `SimpleChip` — small pill surface for labels, states, and lightweight tagging.
- `SimpleDivider` — separator line that respects the active theme.
- `SimpleListItem` — compact row layout for leading, title, subtitle, and trailing content.
- `SimpleMenuPage` — menu-style screen wrapper for account and settings pages.
- `SimpleMenuSection` — grouped menu block with optional section header content.
- `SimpleMenuTile` — tappable menu row for settings, account, and support flows.
- `SimpleFlag` — country flag widget rendered from bundled SVG assets.

**Feedback**
- `SimpleAlertDialog` — alert dialog wrapper with theme-aware defaults.
- `SimpleBadge` — small badge for counts, states, and highlighted labels.
- `SimpleBanner` — inline feedback banner for notices, warnings, and guidance.
- `SimpleSnackbar` — snackbar helper for short confirmation and error messages.

**Forms**
- `SimpleForm` — form shell with optional keyboard-dismiss behavior.
- `SimpleFormBuilder` — config-driven form builder with validation and submit handling.
- `FormFieldWrapper` — consistent label, helper, and error wrapper around a field.
- `FormSection` — titled grouping widget for related form inputs.

Supporting form API:
`SimpleFormController`, `SimpleFormFieldConfig`, `SimpleFormFieldType`, `SimpleFormStateSnapshot`, `SimpleFormValidator`, `SimpleCrossFieldValidator`, `SimpleValidationMessages`, `SimpleRegexPatterns`, and `SimpleFormUtil` support controller-driven flows and validation logic.

**Layout**
- `AppScaffold` — app page scaffold wrapper for standard screen composition.
- `HStack` — horizontal stack helper with built-in gap handling.
- `Section` — titled content section with optional header action.
- `SimpleGrid` — responsive grid for cards, tiles, and catalog layouts.
- `VStack` — vertical stack helper with built-in gap handling.

**Navigation**
- `AppBarEx` — app bar wrapper with optional title widget, actions, and safe defaults.
- `SimpleBottomNavBar` — bottom navigation bar with token-driven colors and active icon highlight support.
- `SimpleTabs` — tab bar wrapper that respects Material tab theming.
- `SimpleVerticalRail` — compact vertical category rail for catalog, ordering, and marketplace screens.

**Overlays**
- `SimpleBottomSheet` — modal bottom sheet helper with optional built-in title and message.
- `SimpleFloatingBanner` — centered overlay surface for promos, announcements, and media-led messages.

**States**
- `SimpleEmptyState` — empty-state block with title, message, and optional action.
- `SimpleErrorView` — error-state block with retry support.
- `SimpleLoadingView` — loading state with spinner and optional message.

**Typography**
- `AppText` — advanced text helper for localization, HTML rendering, semantics, and auto-fit.
- `SimpleText` — everyday text primitive mapped to the library typography scale.

## Install and setup

This package is currently consumed through a local path or Git reference rather than pub.dev.

### Path dependency (local dev)

```yaml
dependencies:
  j_flutter_ui:
    path: ../j_flutter_ui
```

### Git dependency (production)

```yaml
dependencies:
  j_flutter_ui:
    git:
      url: https://github.com/your-org/j_flutter_ui.git
      ref: main
```

### Import rule: one import only

```dart
import 'package:j_flutter_ui/j_flutter_ui.dart';
```

### Theme setup

```dart
MaterialApp(
  theme: JAppTheme.lightTheme,
  darkTheme: JAppTheme.darkTheme,
  home: const MyHomePage(),
);
```

### Token customization

```dart
final base = JAppTheme.lightTheme;

final theme = base.copyWith(
  extensions: <ThemeExtension<dynamic>>[
    ...base.extensions.values.where((extension) => extension is! AppThemeTokens),
    base.appThemeTokens.copyWith(
      primary: const Color(0xFF0F766E),
      secondary: const Color(0xFF7C3AED),
      cardBackground: const Color(0xFFFFFFFF),
      inputBackground: const Color(0xFFF8FAFC),
      mutedText: const Color(0xFF64748B),
    ),
  ],
);
```

### Localization delegate setup

```dart
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:j_flutter_ui/j_flutter_ui.dart';

MaterialApp(
  localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
    AppLocalizationsDelegate(),
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: AppLocalizations.supportedLocales,
  home: const MyHomePage(),
);
```

## Key widgets with examples

Use `SimpleVerticalRail` when you need a compact left-edge category navigator for catalog, ordering, or marketplace screens.

```dart
class RailExample extends StatefulWidget {
  const RailExample({super.key});
  @override State<RailExample> createState() => _RailExampleState();
}

class _RailExampleState extends State<RailExample> {
  int selectedIndex = 0;
  @override Widget build(BuildContext context) => SizedBox(
    width: 96,
    child: SimpleVerticalRail(
      selectedIndex: selectedIndex,
      onSelected: (index) => setState(() => selectedIndex = index),
      items: const <SimpleVerticalRailItem>[
        SimpleVerticalRailItem(icon: Icons.local_cafe_outlined, label: 'Tea'),
        SimpleVerticalRailItem(icon: Icons.cookie_outlined, label: 'Snacks'),
        SimpleVerticalRailItem(icon: Icons.card_giftcard_outlined, label: 'Gifts'),
      ],
    ),
  );
}
```

Use `SimpleBottomNavBar` when a screen needs a standard bottom navigation experience with an optional active icon circle.

```dart
class BottomNavExample extends StatefulWidget {
  const BottomNavExample({super.key});
  @override State<BottomNavExample> createState() => _BottomNavExampleState();
}

class _BottomNavExampleState extends State<BottomNavExample> {
  int currentIndex = 0;
  @override Widget build(BuildContext context) => SimpleBottomNavBar(
    currentIndex: currentIndex,
    activeIconBackgroundColor: Theme.of(context).colorScheme.primaryContainer,
    onTap: (index) => setState(() => currentIndex = index),
    items: const <SimpleBottomNavItem>[
      SimpleBottomNavItem(icon: Icons.home_outlined, activeIcon: Icons.home, label: 'Home'),
      SimpleBottomNavItem(icon: Icons.search_outlined, activeIcon: Icons.search, label: 'Browse'),
      SimpleBottomNavItem(icon: Icons.person_outline, activeIcon: Icons.person, label: 'Account'),
    ],
  );
}
```

Use the quiet `SimpleSearchField` when you want a softer search bar that blends into cards, filters, or catalog headers.

```dart
class QuietSearchExample extends StatelessWidget {
  const QuietSearchExample({super.key});
  @override Widget build(BuildContext context) => const Padding(
    padding: JInsets.screenPadding,
    child: SimpleSearchField(
      variant: SimpleSearchFieldVariant.quiet,
      hintText: 'Search products',
    ),
  );
}
```

Use `showSimpleFloatingBanner` for generic promotional, onboarding, or announcement overlays that need both media and custom content.

```dart
class FloatingBannerExample extends StatelessWidget {
  const FloatingBannerExample({super.key});
  @override Widget build(BuildContext context) => Center(
    child: SimpleButton.primary(
      label: 'Open banner',
      onPressed: () => showSimpleFloatingBanner<void>(
        context,
        media: const AspectRatio(
          aspectRatio: 16 / 9,
          child: ColoredBox(color: Color(0xFFE0F2FE), child: Center(child: Icon(Icons.campaign_outlined, size: 56))),
        ),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[SimpleText.heading(text: 'Seasonal update'), JGaps.h8, SimpleText.body(text: 'Use this surface for promotions, onboarding, or app-wide notices.', maxLines: 4)],
        ),
      ),
    ),
  );
}
```

Use `SimpleFormBuilder` when you want a small form without hand-wiring every field, label, helper, and submit button.

```dart
class ProfileFormExample extends StatelessWidget {
  const ProfileFormExample({super.key});
  @override Widget build(BuildContext context) => SimpleFormBuilder(
    showSubmitButton: true,
    submitLabel: 'Save profile',
    onSubmit: (values) async => debugPrint(values.toString()),
    fields: <SimpleFormFieldConfig<dynamic>>[
      SimpleFormFieldConfig.text(name: 'name', label: 'Name'),
      SimpleFormFieldConfig.text(
        name: 'email',
        label: 'Email',
        keyboardType: TextInputType.emailAddress,
      ),
    ],
  );
}
```

## Theming and tokens

The library is designed so local, deliberate choices win first and shared branding fills the gaps underneath. In practice, a widget uses an explicit parameter when you pass one, then checks the matching Material theme, then reads your library tokens, and only falls back to safe defaults when nothing else is configured. That makes it easy to brand once at the app level without fighting per-widget overrides.

Use the theme extension to customize shared library colors, then read them inside widgets with the canonical accessor `Theme.of(context).appThemeTokens`.

```dart
final base = JAppTheme.lightTheme;

final theme = base.copyWith(
  extensions: <ThemeExtension<dynamic>>[
    ...base.extensions.values.where((extension) => extension is! AppThemeTokens),
    base.appThemeTokens.copyWith(
      primary: const Color(0xFF0F766E),
      cardBackground: const Color(0xFFFFFFFF),
      cardBorderColor: const Color(0xFFE2E8F0),
      inputBorderColor: const Color(0xFFCBD5E1),
      mutedText: const Color(0xFF64748B),
    ),
  ],
);
```

| Token | Type | Purpose |
|---|---|---|
| `primary` | `Color` | Primary action and emphasis color used by the library. |
| `onPrimary` | `Color?` | Preferred foreground for `primary` surfaces. |
| `secondary` | `Color` | Secondary semantic action color. |
| `onSecondary` | `Color?` | Preferred foreground for `secondary` surfaces. |
| `cardBackground` | `Color` | Card, sheet, and dialog surface color. |
| `onCard` | `Color?` | Preferred foreground for `cardBackground` surfaces. |
| `cardBorderColor` | `Color` | Border color for card-like surfaces. |
| `inputBackground` | `Color` | Fill color for text inputs and similar controls. |
| `onInput` | `Color?` | Preferred foreground for `inputBackground` surfaces. |
| `inputBorderColor` | `Color` | Border color for text inputs and related controls. |
| `dividerColor` | `Color` | Divider and separator color across components. |
| `mutedText` | `Color` | Secondary, supporting, and low-emphasis text color. |

## Project structure

```text
lib/
  j_flutter_ui.dart        # public API exports
  src/ui/
    constants/             # country and currency constants
    localization/          # package localization and host override bridge
    resources/             # tokens, themes, styles, and bundled asset helpers
    utils/                 # small reusable utility helpers
    widgets/               # reusable UI primitives and composed patterns
example/                   # demo app for visual QA and usage reference
assets/                    # bundled images, flags, illustrations, and localization JSON
test/                      # regression tests for theming, behavior, and rendering
```

## Built with j_flutter_ui
> Demo screens and production apps coming soon.
