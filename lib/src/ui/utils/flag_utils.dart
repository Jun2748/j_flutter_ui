import 'package:flutter/material.dart';

import '../constants/country_codes.dart';
import '../constants/currency_codes.dart';
import '../resources/dimens.dart';
import '../resources/flags.dart';
import '../resources/images.dart';

abstract final class FlagUtils {
  const FlagUtils._();

  static const Map<String, String> _countryFlagMap = <String, String>{
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

  static const Map<String, String> _currencyCountryMap = <String, String>{
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

  static String? flagAssetFromCountry(String? countryCode) {
    final String? normalizedCountry = _normalizeCountryCode(countryCode);
    if (normalizedCountry == null) {
      return null;
    }

    return _countryFlagMap[normalizedCountry];
  }

  static Widget flagByCountry(String? countryCode, {double? size}) {
    final String? asset = flagAssetFromCountry(countryCode);
    final double resolvedSize = size ?? JIconSizes.md;

    if (asset == null || asset.isEmpty) {
      return SizedBox(width: resolvedSize, height: resolvedSize);
    }

    return SizedBox(
      width: resolvedSize,
      height: resolvedSize,
      child: Images.svg(asset, width: resolvedSize, height: resolvedSize),
    );
  }

  static String? countryCodeFromCurrency(String? currencyCode) {
    final String? normalizedCurrency = _normalizeCurrencyCode(currencyCode);
    if (normalizedCurrency == null) {
      return null;
    }

    return _currencyCountryMap[normalizedCurrency];
  }

  static String? flagAssetFromCurrency(String? currencyCode) {
    final String? countryCode = countryCodeFromCurrency(currencyCode);
    if (countryCode == null) {
      return null;
    }

    return flagAssetFromCountry(countryCode);
  }

  static Widget flagByCurrency(String? currencyCode, {double? size}) {
    final String? countryCode = countryCodeFromCurrency(currencyCode);
    return flagByCountry(countryCode, size: size);
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
