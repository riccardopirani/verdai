import 'package:flutter/material.dart';

/// Supported UI locales with flag emoji (Unicode regional sequence).
const kDefaultLocale = Locale('en');

class LocaleOption {
  const LocaleOption({
    required this.locale,
    required this.flag,
    required this.labelKey,
  });

  final Locale locale;
  final String flag;

  /// Maps to getters on [AppLocalizations] — see [AppLocalizationsLanguageLabels].
  final String labelKey;
}

/// Order: major world + requested (IT, EN, FR, DE, ZH, RU, UK, HE, FA, …).
const kSupportedLocaleOptions = <LocaleOption>[
  LocaleOption(locale: Locale('en'), flag: '🇬🇧', labelKey: 'langName_en'),
  LocaleOption(locale: Locale('it'), flag: '🇮🇹', labelKey: 'langName_it'),
  LocaleOption(locale: Locale('fr'), flag: '🇫🇷', labelKey: 'langName_fr'),
  LocaleOption(locale: Locale('de'), flag: '🇩🇪', labelKey: 'langName_de'),
  LocaleOption(locale: Locale('zh'), flag: '🇨🇳', labelKey: 'langName_zh'),
  LocaleOption(locale: Locale('ru'), flag: '🇷🇺', labelKey: 'langName_ru'),
  LocaleOption(locale: Locale('uk'), flag: '🇺🇦', labelKey: 'langName_uk'),
  LocaleOption(locale: Locale('he'), flag: '🇮🇱', labelKey: 'langName_he'),
  LocaleOption(locale: Locale('fa'), flag: '🇮🇷', labelKey: 'langName_fa'),
  LocaleOption(locale: Locale('es'), flag: '🇪🇸', labelKey: 'langName_es'),
  LocaleOption(locale: Locale('pt'), flag: '🇵🇹', labelKey: 'langName_pt'),
  LocaleOption(locale: Locale('ar'), flag: '🇸🇦', labelKey: 'langName_ar'),
  LocaleOption(locale: Locale('ja'), flag: '🇯🇵', labelKey: 'langName_ja'),
  LocaleOption(locale: Locale('ko'), flag: '🇰🇷', labelKey: 'langName_ko'),
  LocaleOption(locale: Locale('nl'), flag: '🇳🇱', labelKey: 'langName_nl'),
  LocaleOption(locale: Locale('pl'), flag: '🇵🇱', labelKey: 'langName_pl'),
  LocaleOption(locale: Locale('tr'), flag: '🇹🇷', labelKey: 'langName_tr'),
  LocaleOption(locale: Locale('hi'), flag: '🇮🇳', labelKey: 'langName_hi'),
  LocaleOption(locale: Locale('sv'), flag: '🇸🇪', labelKey: 'langName_sv'),
  LocaleOption(locale: Locale('el'), flag: '🇬🇷', labelKey: 'langName_el'),
];

List<Locale> get kSupportedFlutterLocales =>
    kSupportedLocaleOptions.map((e) => e.locale).toList();
