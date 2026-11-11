# Changelog

All notable changes to `j_flutter_ui`. Versions follow semantic versioning
(see `agent_rules/API_DESIGN_RULES.md`): breaking change = major, new widget
or option = minor, fix = patch. Every release is tagged `vX.Y.Z` on `main`,
and apps pin a tag, never `main`.

Each entry says what changed and what a consuming app must do.

## Unreleased

No public API change. Apps need no action except for the dependency fix below.

- Stop tracking generated `.dart_tool/` files; remove unused root platform folders.
- Apply `dart format` across the package; remove an unused import.
- Add `WIDGETS.md`, a generated index of every exported widget and token, with a test that keeps it current.
- Add CI (format, analyze, test) on pull requests and pushes to `main`.
- Add this changelog.

### Fixed

- Apps that resolve dependencies without a lockfile no longer fail to compile.
  `flutter_html` 3.0.0 calls a function that `html` 0.15.7 removed, and pub
  picked 0.15.7 for any fresh resolve. The library now caps `html` below 0.15.7.
  Apps: move to the release that carries this fix and run `flutter pub get`;
  any `html` pin of their own can then go. An app that itself requires
  `html` 0.15.7 or later now gets a resolve error instead of a broken build.

### Planned for 3.0.0 (breaking)

- Move the example app's `demo.*` strings and `L.demo*` keys out of the library into `example/`.
- Move HTML rendering out of `AppText(useHtml:)` into its own widget, so apps that never show HTML don't carry `flutter_html`.

Both will be deprecated first, then removed, per the library's migration rules.

## 2.8.1

First tagged release. Earlier history is in the git log. API removed before
this tag, and how to migrate, is listed in `MIGRATION_NOTES.md`.
