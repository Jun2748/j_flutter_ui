# Migration Guide

This guide covers public API removed in this change set and how downstream apps
should migrate.

## Removed Symbols

| Removed symbol | Removed from | Use instead |
|---|---|---|
| `SimpleCheckbox({ enabled })` named parameter | `lib/src/ui/widgets/controls/inputs/simple_checkbox.dart` | Remove `enabled` and use `onChanged: null` for the disabled state. |
| `SimpleMenuTile({ showChevron })` named parameter | `lib/src/ui/widgets/patterns/simple_menu_tile.dart` | Use `disclosure: SimpleMenuTileDisclosure.chevron` or `SimpleMenuTileDisclosure.none`. |
| `SimpleMenuTile({ showTopDivider })` named parameter | `lib/src/ui/widgets/patterns/simple_menu_tile.dart` | Use `dividers: SimpleMenuTileDividers.top` or `SimpleMenuTileDividers.both`. |
| `SimpleMenuTile({ showBottomDivider })` named parameter | `lib/src/ui/widgets/patterns/simple_menu_tile.dart` | Use `dividers: SimpleMenuTileDividers.bottom` or `SimpleMenuTileDividers.both`. |
| `SimpleMenuTile.chevron({ showTopDivider })` named parameter | `lib/src/ui/widgets/patterns/simple_menu_tile.dart` | Use `dividers: SimpleMenuTileDividers.top` or `SimpleMenuTileDividers.both`. |
| `SimpleMenuTile.chevron({ showBottomDivider })` named parameter | `lib/src/ui/widgets/patterns/simple_menu_tile.dart` | Use `dividers: SimpleMenuTileDividers.bottom` or `SimpleMenuTileDividers.both`. |
| `SimpleMenuTile.badge({ showChevron })` named parameter | `lib/src/ui/widgets/patterns/simple_menu_tile.dart` | Use `disclosure: SimpleMenuTileDisclosure.chevron` or `SimpleMenuTileDisclosure.none`. |
| `SimpleMenuTile.badge({ showTopDivider })` named parameter | `lib/src/ui/widgets/patterns/simple_menu_tile.dart` | Use `dividers: SimpleMenuTileDividers.top` or `SimpleMenuTileDividers.both`. |
| `SimpleMenuTile.badge({ showBottomDivider })` named parameter | `lib/src/ui/widgets/patterns/simple_menu_tile.dart` | Use `dividers: SimpleMenuTileDividers.bottom` or `SimpleMenuTileDividers.both`. |
| `SimpleMenuTile.trailingText({ showChevron })` named parameter | `lib/src/ui/widgets/patterns/simple_menu_tile.dart` | Use `disclosure: SimpleMenuTileDisclosure.chevron` or `SimpleMenuTileDisclosure.none`. |
| `SimpleMenuTile.trailingText({ showTopDivider })` named parameter | `lib/src/ui/widgets/patterns/simple_menu_tile.dart` | Use `dividers: SimpleMenuTileDividers.top` or `SimpleMenuTileDividers.both`. |
| `SimpleMenuTile.trailingText({ showBottomDivider })` named parameter | `lib/src/ui/widgets/patterns/simple_menu_tile.dart` | Use `dividers: SimpleMenuTileDividers.bottom` or `SimpleMenuTileDividers.both`. |
| `SimpleMenuTile.copyWith({ showChevron })` named parameter | `lib/src/ui/widgets/patterns/simple_menu_tile.dart` | Use `copyWith(disclosure: SimpleMenuTileDisclosure.chevron)` or `copyWith(disclosure: SimpleMenuTileDisclosure.none)`. |
| `SimpleMenuTile.copyWith({ showTopDivider })` named parameter | `lib/src/ui/widgets/patterns/simple_menu_tile.dart` | Use `copyWith(dividers: SimpleMenuTileDividers.top)` or `copyWith(dividers: SimpleMenuTileDividers.both)`. |
| `SimpleMenuTile.copyWith({ showBottomDivider })` named parameter | `lib/src/ui/widgets/patterns/simple_menu_tile.dart` | Use `copyWith(dividers: SimpleMenuTileDividers.bottom)` or `copyWith(dividers: SimpleMenuTileDividers.both)`. |
| `SimpleMenuTile.showChevron` getter | `lib/src/ui/widgets/patterns/simple_menu_tile.dart` | Check `disclosure == SimpleMenuTileDisclosure.chevron`. |
| `SimpleMenuTile.showTopDivider` getter | `lib/src/ui/widgets/patterns/simple_menu_tile.dart` | Check `dividers == SimpleMenuTileDividers.top || dividers == SimpleMenuTileDividers.both`. |
| `SimpleMenuTile.showBottomDivider` getter | `lib/src/ui/widgets/patterns/simple_menu_tile.dart` | Check `dividers == SimpleMenuTileDividers.bottom || dividers == SimpleMenuTileDividers.both`. |

## Quick Examples

Before:

```dart
const SimpleCheckbox(
  value: true,
  enabled: false,
);
```

After:

```dart
const SimpleCheckbox(
  value: true,
  onChanged: null,
);
```

Before:

```dart
const SimpleMenuTile(
  title: 'Profile',
  showChevron: false,
  showBottomDivider: true,
);
```

After:

```dart
const SimpleMenuTile(
  title: 'Profile',
  disclosure: SimpleMenuTileDisclosure.none,
  dividers: SimpleMenuTileDividers.bottom,
);
```
