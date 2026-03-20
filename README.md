## j_flutter_ui

`j_flutter_ui` is a reusable Flutter UI library (a lightweight design system) intended to be shared across multiple apps.

It focuses on:
- **Design tokens** (spacing, typography, sizes) so apps avoid "magic numbers"
- **Themeable primitives** (thin wrappers over Material semantics)
- **Composable patterns** built from primitives (menus, navigation, states, overlays)
- **Form infrastructure** (builder + controller + validators)
- **Asset helpers** (SVG/images/flags/illustrations)
- **Demo-driven documentation** via the `example/` catalog app

---

## What's included

### Foundations (resources)
- **Tokens**: `JGaps`, `JInsets`, `JDimens`, `JHeights`, `JIconSizes`, `JFontSizes`, `JLineHeights`, `JTextStyles`
- **Theming**:
  - `JAppTheme.lightTheme` / `JAppTheme.darkTheme` (ready-to-use `ThemeData`)
  - `AppThemeTokens` (`ThemeExtension`) for library-owned semantic colors (card/input/divider/muted text, etc.)

### Widgets (public API)
Consumers should import only `package:j_flutter_ui/j_flutter_ui.dart`. The public entrypoint exports:
- **Controls**: `SimpleButton`, `SimpleDropdown`, `SimpleTextField`, `SimpleSwitch`, `SimpleCheckbox`, etc.
- **Display**: `SimpleCard`, `SimpleChip`, `SimpleDivider`, `SimpleListItem`, menus (`SimpleMenuTile`, `SimpleMenuSection`, `SimpleMenuPage`)
- **Feedback**: `SimpleBanner`, `SimpleBadge`, `SimpleAlertDialog`, `SimpleSnackbar`
- **Forms**: `SimpleForm`, `SimpleFormBuilder`, `SimpleFormController`, validation helpers
- **Layout**: `AppScaffold`, `VStack`, `HStack`, `Section`
- **Navigation**: `AppBarEx`, `SimpleBottomNavBar`, `SimpleTabs`, `SimpleVerticalRail`
- **Overlays**: `SimpleBottomSheet`
- **States**: `SimpleLoadingView`, `SimpleEmptyState`, `SimpleErrorView`
- **Typography**: `SimpleText`, `AppText`
- **Flags & helpers**: `SimpleFlag`, `FlagUtils`, `CountryCodes`, `CurrencyCodes`

### Localization (library-owned copy)
- `AppLocalizations` loads JSON translations from this package (`assets/localization/*.json`)
- `AppLocalizationBridge` allows host apps to override any library key at runtime
- `Intl.text(...)` is the string lookup used inside the library

---

## Install

This repo is currently configured as non-published (`publish_to: none`). In an app, add it via **path** or **git**.

### Path dependency (local development)

```yaml
dependencies:
  j_flutter_ui:
    path: ../j_flutter_ui
```

### Git dependency

```yaml
dependencies:
  j_flutter_ui:
    git:
      url: <your-repo-url>
      ref: <tag-or-commit>
```

---

## Import rule (important)

Always import **only** the public entrypoint:

```dart
import 'package:j_flutter_ui/j_flutter_ui.dart';
```

Avoid importing anything under `src/` from an app.

---

## Quick start

### Use the built-in themes

```dart
MaterialApp(
  theme: JAppTheme.lightTheme,
  darkTheme: JAppTheme.darkTheme,
  // ...
);
```

### Customize via `AppThemeTokens` (recommended)

`AppThemeTokens` is a `ThemeExtension` used as the library's semantic override mechanism.

```dart
final base = JAppTheme.lightTheme;

final theme = base.copyWith(
  extensions: <ThemeExtension<dynamic>>[
    ...?base.extensions.values,
    const AppThemeTokens(
      primary: Color(0xFF2563EB),
      secondary: Color(0xFF06B6D4),
      cardBackground: Color(0xFFFFFFFF),
      cardBorderColor: Color(0xFFE5E7EB),
      inputBackground: Color(0xFFF9FAFB),
      inputBorderColor: Color(0xFFE5E7EB),
      dividerColor: Color(0xFFE5E7EB),
      mutedText: Color(0xFF6B7280),
    ),
  ],
);
```

Inside widgets, tokens are read via:
- `Theme.of(context).appThemeTokens`

### Use tokens instead of magic numbers

Avoid:

```dart
const SizedBox(height: 13);
const EdgeInsets.all(15);
const TextStyle(fontSize: 17);
```

Prefer:

```dart
JGaps.h16;
JInsets.all16;
JTextStyles.body1;
```

---

## Assets (SVG/images/flags/illustrations)

This package bundles its assets under `assets/`. In your app you typically just use the helpers/constants:

```dart
Images.svg(UiIcons.search);
Images.svg(Flags.malaysia);
Images.svg(Illustrations.emptyState);
```

Flags are **country-first**:

```dart
SimpleFlag.countryCode(CountryCodes.my);
FlagUtils.flagByCountry(CountryCodes.my);
```

---

## Localization setup (apps)

### Add the delegate and supported locales

`j_flutter_ui` currently ships `en` under `assets/localization/en.json`.

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
  // ...
);
```

### Override library strings from the host app

Use `AppLocalizationBridge.configure(...)` once at app startup to supply product/business copy (or to override any library key):

```dart
AppLocalizationBridge.configure((context, key, {args}) {
  // Return null to fall back to the library JSON.
  if (key == L.commonOkay) return 'OK';
  return null;
});
```

The library resolves strings in this order:
- caller override (widget parameter)
- `AppLocalizationBridge`
- library JSON (`assets/localization/<lang>.json`)
- key fallback (returns the key string)

---

## Vertical Rail

`SimpleVerticalRail` is a compact scrollable left-edge navigation rail: icon + label items stacked vertically, with active/inactive color driven by tokens. Common in food ordering, marketplace, and catalog apps (think Grab, Chagee).

```dart
SimpleVerticalRail(
  items: const <SimpleVerticalRailItem>[
    SimpleVerticalRailItem(icon: Icons.local_cafe_outlined, label: 'Milk Tea'),
    SimpleVerticalRailItem(icon: Icons.shopping_bag_outlined, label: 'Bundles'),
    SimpleVerticalRailItem(icon: Icons.redeem_outlined, label: 'Merch'),
  ],
  selectedIndex: _selectedIndex,
  onSelected: (int i) => setState(() => _selectedIndex = i),
)
```

**Sizing variants** — defaults are compact (76dp items, `lg` icons, `label` style). Pass overrides for a larger rail:

```dart
SimpleVerticalRail(
  items: ...,
  selectedIndex: _selectedIndex,
  onSelected: ...,
  itemHeight: 104,
  iconSize: JIconSizes.xl,
  labelStyle: JTextStyles.body1,
)
```

**Active indicator** — the widget provides color-change only (active: `colorScheme.onSurface`, inactive: `tokens.mutedText`). App-specific overlays (animated dots, accent bars) are intentionally kept in app-layer composition. Example using a `Stack`:

```dart
Stack(
  clipBehavior: Clip.none,
  children: [
    SimpleVerticalRail(items: ..., selectedIndex: ..., onSelected: ...),
    // App-local animated dot on the rail/content border line
    AnimatedPositioned(
      right: -5,
      top: selectedIndex * 76.0 + (76.0 / 2 - 5),
      child: /* dot widget */,
    ),
  ],
)
```

---

## Forms (overview)

If you're building non-trivial forms, prefer the controller-driven form system:
- `SimpleForm`
- `SimpleFormBuilder`
- `SimpleFormController`
- `SimpleFormValidator` and `SimpleCrossFieldValidator`

---

## Example app (catalog / QA)

The demo catalog lives in `example/`. It's the best way to:
- discover what widgets exist and how they're intended to be composed
- visually QA light/dark themes
- verify token overrides

Run it like a normal Flutter app:

```bash
cd example
flutter run
```

---

## Project structure (for contributors)

```text
lib/
  j_flutter_ui.dart        # public API exports (consumer entrypoint)
  src/ui/
    constants/             # country/currency codes, etc.
    localization/          # JSON localization + override bridge
    resources/             # tokens, theme infrastructure, asset helpers
    utils/                 # small reusable utilities
    widgets/               # primitives + composed patterns
example/                   # catalog app
assets/                    # svg/png/jpg + localization json
test/                      # regression tests (fallbacks, theming, rendering)
```

---

## Contribution guidelines (high level)

- **Keep it app-agnostic**: no app routing/state/business models inside the library.
- **Prefer composition**: patterns should reuse primitives; avoid duplicating styling logic.
- **Theming contract**: resolve styles as widget parameter → `AppThemeTokens` → Material semantics → fallback constants.
- **Localization-safe**: no hardcoded business copy; use keys and overrides; don't concatenate translated fragments.
