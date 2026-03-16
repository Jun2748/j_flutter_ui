import 'package:flutter/widgets.dart';

typedef AppLocalizationResolver =
    String? Function(
      BuildContext context,
      String key, {
      Map<String, String>? args,
    });

abstract final class AppLocalizationBridge {
  const AppLocalizationBridge._();

  static AppLocalizationResolver? _resolver;

  static void configure(AppLocalizationResolver? resolver) {
    _resolver = resolver;
  }

  static void clear() {
    _resolver = null;
  }

  static String? translate(
    BuildContext context,
    String key, {
    Map<String, String>? args,
  }) {
    return _resolver?.call(context, key, args: args);
  }
}
