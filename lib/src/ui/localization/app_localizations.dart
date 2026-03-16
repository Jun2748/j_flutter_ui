import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class AppLocalizations {
  const AppLocalizations._(this.locale, this._localizedValues);

  static const String _packageName = 'j_flutter_ui';
  static const String _baseAssetPath = 'assets/localization';

  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
  ];

  final Locale locale;
  final Map<String, String> _localizedValues;

  static Future<AppLocalizations> load(Locale locale) async {
    final String languageCode = locale.languageCode;
    final String packageAssetPath =
        'packages/$_packageName/$_baseAssetPath/$languageCode.json';
    final String localAssetPath = '$_baseAssetPath/$languageCode.json';

    try {
      final String jsonString = await rootBundle.loadString(packageAssetPath);
      return AppLocalizations._(
        locale,
        _parseLocalizedValues(jsonString),
      );
    } catch (_) {
      final String jsonString = await rootBundle.loadString(localAssetPath);
      return AppLocalizations._(
        locale,
        _parseLocalizedValues(jsonString),
      );
    }
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        const AppLocalizations._(Locale('en'), <String, String>{});
  }

  String? maybeTr(String key, {Map<String, String>? args}) {
    final String? rawValue = _localizedValues[key];
    if (rawValue == null) {
      return null;
    }

    return _replaceArgs(rawValue, args);
  }

  String tr(String key, {Map<String, String>? args}) {
    return maybeTr(key, args: args) ?? key;
  }

  static Map<String, String> _parseLocalizedValues(String jsonString) {
    final Map<String, dynamic> decodedJson =
        jsonDecode(jsonString) as Map<String, dynamic>;
    return decodedJson.map(
      (String key, dynamic value) => MapEntry(key, value.toString()),
    );
  }

  static String _replaceArgs(String value, Map<String, String>? args) {
    if (args == null || args.isEmpty) {
      return value;
    }

    String resolvedValue = value;
    args.forEach((String placeholder, String replacement) {
      resolvedValue = resolvedValue.replaceAll(
        '{$placeholder}',
        replacement,
      );
    });
    return resolvedValue;
  }
}
