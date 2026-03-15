import 'package:flutter/material.dart';

import '../constants/country_codes.dart';
import '../constants/currency_codes.dart';
import '../resources/dimens.dart';
import '../resources/flags.dart';
import '../resources/images.dart';

abstract final class FlagUtils {
  const FlagUtils._();

  static const Map<String, String> _currencyToCountryCode = <String, String>{
    CurrencyCodes.sgd: CountryCodes.sg,
    CurrencyCodes.usd: CountryCodes.us,
    CurrencyCodes.cny: CountryCodes.cn,
    CurrencyCodes.cnh: CountryCodes.cn,
    CurrencyCodes.hkd: CountryCodes.hk,
    CurrencyCodes.aud: CountryCodes.au,
    CurrencyCodes.eur: CountryCodes.eu,
    CurrencyCodes.chf: CountryCodes.ch,
    CurrencyCodes.gbp: CountryCodes.gb,
    CurrencyCodes.nzd: CountryCodes.nz,
    CurrencyCodes.jpy: CountryCodes.jp,
    CurrencyCodes.cad: CountryCodes.ca,
    CurrencyCodes.myr: CountryCodes.my,
  };

  static const Map<String, String> _countryToFlagAsset = <String, String>{
    CountryCodes.sg: Flags.singapore,
    CountryCodes.us: Flags.usa,
    CountryCodes.cn: Flags.china,
    CountryCodes.hk: Flags.hongKong,
    CountryCodes.au: Flags.australia,
    CountryCodes.eu: Flags.europe,
    CountryCodes.ch: Flags.switzerland,
    CountryCodes.gb: Flags.uk,
    CountryCodes.nz: Flags.newZealand,
    CountryCodes.jp: Flags.japan,
    CountryCodes.ca: Flags.canada,
    CountryCodes.my: Flags.malaysia,
    CountryCodes.inCode: Flags.india,
    CountryCodes.id: Flags.indonesia,
    CountryCodes.kr: Flags.southKorea,
    CountryCodes.th: Flags.thailand,
    CountryCodes.tw: Flags.taiwan,
    CountryCodes.ru: Flags.russia,
  };

  static String? countryCodeFromCurrency(String? currency) {
    final String? normalizedCurrency = _normalizeCurrencyCode(currency);
    if (normalizedCurrency == null) {
      return null;
    }

    return _currencyToCountryCode[normalizedCurrency];
  }

  static String? flagAssetFromCountry(String? country) {
    final String? normalizedCountry = _normalizeCountryCode(country);
    if (normalizedCountry == null) {
      return null;
    }

    return _countryToFlagAsset[normalizedCountry];
  }

  static String? flagAssetFromCurrency(String? currency) {
    final String? countryCode = countryCodeFromCurrency(currency);
    if (countryCode == null) {
      return null;
    }

    return flagAssetFromCountry(countryCode);
  }

  static Widget flagByCurrency(
    String? currency, {
    double? size,
  }) {
    final String? asset = flagAssetFromCurrency(currency);
    final double resolvedSize = size ?? JIconSizes.md;

    if (asset == null || asset.isEmpty) {
      return SizedBox(
        width: resolvedSize,
        height: resolvedSize,
      );
    }

    return SizedBox(
      width: resolvedSize,
      height: resolvedSize,
      child: Images.svg(
        asset,
        width: size,
        height: size,
      ),
    );
  }

  static String? _normalizeCountryCode(String? value) {
    final String? normalizedValue = value?.trim().toLowerCase();
    if (normalizedValue == null || normalizedValue.isEmpty) {
      return null;
    }

    return normalizedValue;
  }

  static String? _normalizeCurrencyCode(String? value) {
    final String? normalizedValue = value?.trim().toUpperCase();
    if (normalizedValue == null || normalizedValue.isEmpty) {
      return null;
    }

    return normalizedValue;
  }
}
