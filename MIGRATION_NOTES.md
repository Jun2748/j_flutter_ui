# Migration Notes

## `SimpleCheckbox.enabled` removed

- `SimpleCheckbox` no longer accepts an `enabled` parameter.
- To render a disabled checkbox, pass `onChanged: null`.
- Update any previous `enabled: false` usage to remove `enabled` and rely on the null callback contract instead.

## `SimpleMenuTile` legacy boolean API removed

- `SimpleMenuTile.showChevron`, `SimpleMenuTile.showTopDivider`, and `SimpleMenuTile.showBottomDivider` were removed.
- The matching constructor and `copyWith` parameters were also removed.
- Use `disclosure: SimpleMenuTileDisclosure.chevron|none` instead of `showChevron`.
- Use `dividers: SimpleMenuTileDividers.none|top|bottom|both` instead of `showTopDivider` and `showBottomDivider`.
