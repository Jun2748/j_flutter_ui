import 'dart:async';

import 'package:flutter/widgets.dart';

import 'app_localization_bridge.dart';
import 'app_localizations.dart';

abstract final class Intl {
  const Intl._();

  static Future<AppLocalizations>? _fallbackLoad;

  static String text(
    String key, {
    BuildContext? context,
    Map<String, String>? args,
  }) {
    if (context != null) {
      final String? override = AppLocalizationBridge.translate(
        context,
        key,
        args: args,
      );
      if (override != null && override.isNotEmpty) {
        return override;
      }

      return AppLocalizations.of(context).maybeTr(key, args: args) ?? key;
    }

    final AppLocalizations? cachedLocalizations = AppLocalizations.maybeCached();
    if (cachedLocalizations != null) {
      return cachedLocalizations.maybeTr(key, args: args) ?? key;
    }

    _fallbackLoad ??= AppLocalizations.load(AppLocalizations.fallbackLocale);
    unawaited(_fallbackLoad);

    return key;
  }
}
