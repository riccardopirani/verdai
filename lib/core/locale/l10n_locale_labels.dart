import 'package:verdant/l10n/app_localizations.dart';

import 'supported_locales.dart';

extension AppLocalizationsLanguageLabels on AppLocalizations {
  String labelForLocaleOption(LocaleOption o) {
    switch (o.labelKey) {
      case 'langName_en':
        return langName_en;
      case 'langName_it':
        return langName_it;
      case 'langName_fr':
        return langName_fr;
      case 'langName_de':
        return langName_de;
      case 'langName_zh':
        return langName_zh;
      case 'langName_ru':
        return langName_ru;
      case 'langName_uk':
        return langName_uk;
      case 'langName_he':
        return langName_he;
      case 'langName_fa':
        return langName_fa;
      case 'langName_es':
        return langName_es;
      case 'langName_pt':
        return langName_pt;
      case 'langName_ar':
        return langName_ar;
      case 'langName_ja':
        return langName_ja;
      case 'langName_ko':
        return langName_ko;
      case 'langName_nl':
        return langName_nl;
      case 'langName_pl':
        return langName_pl;
      case 'langName_tr':
        return langName_tr;
      case 'langName_hi':
        return langName_hi;
      case 'langName_sv':
        return langName_sv;
      case 'langName_el':
        return langName_el;
      default:
        return o.locale.languageCode;
    }
  }
}
