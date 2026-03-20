import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class AppLocalizations {
  const AppLocalizations._(this.locale, this._localizedValues);

  static const String _packageName = 'j_flutter_ui';
  static const String _baseAssetPath = 'assets/localization';

  static const List<Locale> supportedLocales = <Locale>[Locale('en')];
  // Mirrors the library's English JSON so widgets still render safe copy
  // when the delegate is not registered or localization assets fail to load.
  static const Map<String, String> _fallbackLocalizedValues = <String, String>{
    'common.okay': 'Okay',
    'common.search': 'Search',
    'common.save': 'Save',
    'common.view': 'View',
    'common.viewAll': 'View all',
    'common.name': 'Name',
    'common.email': 'Email',
    'common.reference': 'Reference',
    'common.home': 'Home',
    'common.menu': 'Menu',
    'common.giftCard': 'Gift card',
    'common.rewards': 'Rewards',
    'common.account': 'Account',
    'common.notifications': 'Notifications',
    'common.disabled': 'Disabled',
    'login.title': 'Welcome back',
    'login.phone': 'Phone number',
    'login.subtitle': 'Sign in to continue to your account',
    'form.submit': 'Submit',
    'form.validation.required': 'This field is required',
    'form.validation.requiredField': '{field} is required',
    'form.validation.invalidEmail': 'Please enter a valid email address',
    'form.validation.invalidPhone': 'Please enter a valid phone number',
    'form.validation.invalidFormat': 'Please enter a valid value',
    'form.validation.minLength': 'Must be at least {length} characters',
    'form.validation.maxLength': 'Must be at most {length} characters',
    'state.error.title': 'Something went wrong',
    'common.cancel': 'Cancel',
    'common.confirm': 'Confirm',
    'common.welcome': 'Welcome, {name}',
    'demo.html.localized':
        'Localized <strong>HTML</strong> from <em>library JSON</em>.',
    'demo.catalog.title': 'Widget Catalog',
    'demo.catalog.searchHint': 'Search demos',
    'demo.catalog.all': 'All',
    'demo.catalog.noResultsTitle': 'No demos found',
    'demo.catalog.noResultsMessage':
        'Try a different keyword or switch categories.',
    'demo.catalog.categoryFoundations': 'Foundations',
    'demo.catalog.categoryControls': 'Controls',
    'demo.catalog.categoryDisplay': 'Display',
    'demo.catalog.categoryScreens': 'Screens',
    'demo.catalog.categoryLayout': 'Layout',
    'demo.catalog.categoryNavigation': 'Navigation',
    'demo.catalog.categoryOverlays': 'Overlays',
    'demo.catalog.categoryForms': 'Forms',
    'demo.catalog.themeLight': 'Theme: Light',
    'demo.catalog.themeDark': 'Theme: Dark',
    'demo.catalog.themeSystem': 'Theme: System',
    'demo.text.title': 'Text',
    'demo.text.registryDescription':
        'Typography scale and color usage powered by SimpleText.',
    'demo.text.scaleTitle': 'Typography scale',
    'demo.text.colorsTitle': 'Color usage',
    'demo.text.titleSample': 'SimpleText.title',
    'demo.text.headingSample': 'SimpleText.heading',
    'demo.text.bodySample': 'SimpleText.body',
    'demo.text.captionSample': 'SimpleText.caption',
    'demo.text.labelSample': 'SimpleText.label',
    'demo.text.primaryLabel': 'Primary emphasis',
    'demo.text.successLabel': 'Success status',
    'demo.text.errorLabel': 'Error status',
    'demo.text.priceTitle': 'Price / monetary',
    'demo.text.priceAlignmentCaption':
        'Tabular figures keep decimal points aligned across rows:',
    'demo.button.title': 'Buttons',
    'demo.button.registryDescription':
        'Primary, secondary, outline, text, and loading buttons.',
    'demo.button.variantsTitle': 'Variants',
    'demo.button.statesTitle': 'States',
    'demo.button.primaryLabel': 'Primary button',
    'demo.button.secondaryLabel': 'Secondary button',
    'demo.button.outlineLabel': 'Outline button',
    'demo.button.textLabel': 'Text button',
    'demo.button.loadingPrimary': 'Saving',
    'demo.button.loadingOutline': 'Syncing',
    'demo.button.disabledLabel': 'Disabled button',
    'demo.textField.title': 'Text field',
    'demo.textField.registryDescription':
        'Text field states with labels, helper text, prefix, suffix, and errors.',
    'demo.textField.basicTitle': 'Label, hint, helper, and prefix icon',
    'demo.textField.basicHelper': 'This field uses SimpleTextField.',
    'demo.textField.nameHint': 'Enter your name',
    'demo.textField.affordancesTitle': 'Prefix and suffix widgets',
    'demo.textField.phoneHelper':
        'Use prefix and suffix for richer input affordances.',
    'demo.textField.readOnlyTitle': 'Read only',
    'demo.textField.readOnlyHint': 'Read-only value',
    'demo.textField.readOnlyHelper': 'Useful for generated or synced values.',
    'demo.textField.disabledTitle': 'Disabled',
    'demo.textField.disabledHelper':
        'Disabled fields still follow the host theme.',
    'demo.textField.errorTitle': 'Error state',
    'demo.textField.emailHint': 'name@example.com',
    'demo.textField.emailError': 'Please enter a valid email address.',
    'demo.theme.title': 'Theme adaptability',
    'demo.theme.registryDescription':
        'Shows SimpleText, SimpleButton, and SimpleTextField following ThemeData across different app themes.',
    'demo.theme.currentSectionTitle': 'Uses the active app theme',
    'demo.theme.customSectionTitle': 'Local host theme override',
    'demo.theme.summarySectionTitle': 'What this proves',
    'demo.theme.currentCardTitle': 'Current app theme',
    'demo.theme.currentCardDescription':
        'These widgets read from ThemeData, so they follow the active app theme without extra wrappers.',
    'demo.theme.currentStatus': 'Status colors still come from the theme.',
    'demo.theme.customCardTitle': 'Custom host theme',
    'demo.theme.customCardDescription':
        'The same library widgets pick up local text, button, input, and status colors from ThemeData.',
    'demo.theme.customStatus':
        'This preview uses a different primary and success color.',
    'demo.theme.summaryText':
        'SimpleText reads text styles from the host TextTheme first.',
    'demo.theme.summaryButton':
        'SimpleButton reads host button themes before falling back to library defaults.',
    'demo.theme.summaryField':
        'SimpleTextField applies the host InputDecorationTheme and fills in only the missing pieces.',
    'demo.theme.textGroupTitle': 'Text',
    'demo.theme.buttonGroupTitle': 'Buttons',
    'demo.theme.fieldGroupTitle': 'Fields',
    'demo.theme.fieldHint': 'Enter a name',
    'demo.theme.fieldHelper': 'This field reads the host InputDecorationTheme.',
    'demo.theme.fieldError': 'Please enter a valid name.',
    'demo.account.title': 'Account',
    'demo.account.registryDescription':
        'End-to-end menu patterns using SimpleMenuPage, SimpleMenuSection, and SimpleMenuTile in a realistic account screen.',
    'demo.account.headerTitle': 'Account overview',
    'demo.account.headerSubtitle':
        'A realistic composition example using SimpleMenuPage, SimpleMenuSection, and SimpleMenuTile together.',
    'demo.account.purchasesTitle': 'My purchase',
    'demo.account.ordersTitle': 'Orders',
    'demo.account.ordersSubtitle':
        'View order history and recent transactions.',
    'demo.account.registerTumblerTitle': 'Register your tumbler',
    'demo.account.perksTitle': 'Especially for you',
    'demo.account.missionsTitle': 'Missions & rewards',
    'demo.account.vouchersTitle': 'My vouchers',
    'demo.account.inviteTitle': 'Invite your friends',
    'demo.account.inviteTrailing': 'Earn voucher',
    'demo.account.helpTitle': 'Need help?',
    'demo.account.helpSubtitle':
        'Useful support and account configuration shortcuts.',
    'demo.account.helpCentreTitle': 'Help centre',
    'demo.account.feedbackTitle': 'Feedback',
    'demo.account.settingsTitle': 'Settings',
    'demo.account.rewardsTitle': 'Rewards updates',
    'demo.account.rewardsSubtitle':
        'New loyalty perks and progress updates are ready to review.',
    'demo.account.navHome': 'Home',
    'demo.account.navMenu': 'Menu',
    'demo.account.navGiftCard': 'Gift card',
    'demo.account.navRewards': 'Rewards',
    'demo.account.navAccount': 'Account',
  };

  static final Map<String, AppLocalizations> _cache =
      <String, AppLocalizations>{};
  static AppLocalizations? _lastLoaded;

  final Locale locale;
  final Map<String, String> _localizedValues;

  static Locale get fallbackLocale => supportedLocales.first;

  static AppLocalizations fallback({Locale? locale}) {
    return AppLocalizations._(
      locale ?? fallbackLocale,
      _fallbackLocalizedValues,
    );
  }

  static Future<AppLocalizations> load(Locale locale) async {
    final String languageCode = locale.languageCode;
    final AppLocalizations? cached = _cache[languageCode];
    if (cached != null) {
      _lastLoaded = cached;
      return cached;
    }

    final String packageAssetPath =
        'packages/$_packageName/$_baseAssetPath/$languageCode.json';
    final String localAssetPath = '$_baseAssetPath/$languageCode.json';

    try {
      final String jsonString = await rootBundle.loadString(packageAssetPath);
      final AppLocalizations localizations = AppLocalizations._(
        locale,
        _parseLocalizedValues(jsonString),
      );
      _cache[languageCode] = localizations;
      _lastLoaded = localizations;
      return localizations;
    } catch (_) {
      try {
        final String jsonString = await rootBundle.loadString(localAssetPath);
        final AppLocalizations localizations = AppLocalizations._(
          locale,
          _parseLocalizedValues(jsonString),
        );
        _cache[languageCode] = localizations;
        _lastLoaded = localizations;
        return localizations;
      } catch (_) {
        final AppLocalizations localizations = fallback(locale: locale);
        _cache[languageCode] = localizations;
        _lastLoaded = localizations;
        return localizations;
      }
    }
  }

  static AppLocalizations of(BuildContext context) {
    final Locale? locale = Localizations.maybeLocaleOf(context);

    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        maybeCached(locale: locale) ??
        fallback(locale: locale);
  }

  static AppLocalizations? maybeCached({Locale? locale}) {
    if (locale != null) {
      final AppLocalizations? localized = _cache[locale.languageCode];
      if (localized != null) {
        return localized;
      }
    }

    return _lastLoaded ??
        _cache[fallbackLocale.languageCode] ??
        fallback(locale: locale);
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
      resolvedValue = resolvedValue.replaceAll('{$placeholder}', replacement);
    });
    return resolvedValue;
  }
}
