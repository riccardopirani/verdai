import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'supported_locales.dart';

const _kLocaleKey = 'verdant_locale_tag';

/// Resolves [deviceLocale] to a supported [Locale] (language + optional country).
Locale resolveDeviceLocale(Locale deviceLocale) {
  final lang = deviceLocale.languageCode.toLowerCase();
  final country = deviceLocale.countryCode?.toUpperCase();
  for (final o in kSupportedLocaleOptions) {
    if (o.locale.languageCode.toLowerCase() != lang) continue;
    if (o.locale.countryCode != null &&
        country != null &&
        o.locale.countryCode!.toUpperCase() != country) {
      continue;
    }
    return o.locale;
  }
  for (final o in kSupportedLocaleOptions) {
    if (o.locale.languageCode.toLowerCase() == lang) return o.locale;
  }
  return kDefaultLocale;
}

Future<Locale> loadSavedOrDeviceLocale() async {
  final prefs = await SharedPreferences.getInstance();
  final tag = prefs.getString(_kLocaleKey);
  if (tag != null) {
    final parsed = localeFromTag(tag);
    if (parsed != null) return parsed;
  }
  final device = ui.PlatformDispatcher.instance.locale;
  return resolveDeviceLocale(device);
}

Locale? localeFromTag(String tag) {
  final parts = tag.split(RegExp(r'[-_]'));
  if (parts.isEmpty) return null;
  final lang = parts[0].toLowerCase();
  if (parts.length >= 2) {
    final country = parts[1].toUpperCase();
    final withCountry = Locale(lang, country);
    if (kSupportedLocaleOptions.any(
      (o) =>
          o.locale.languageCode == withCountry.languageCode &&
          o.locale.countryCode == withCountry.countryCode,
    )) {
      return withCountry;
    }
  }
  for (final o in kSupportedLocaleOptions) {
    if (o.locale.languageCode.toLowerCase() == lang) return o.locale;
  }
  return null;
}

Future<void> persistLocale(Locale locale) async {
  final prefs = await SharedPreferences.getInstance();
  final tag = locale.countryCode != null
      ? '${locale.languageCode}_${locale.countryCode}'
      : locale.languageCode;
  await prefs.setString(_kLocaleKey, tag);
}
