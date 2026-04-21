import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verdant/l10n/app_localizations.dart';

import '../../core/locale/l10n_locale_labels.dart';
import '../../core/locale/locale_provider.dart';
import '../../core/locale/supported_locales.dart';
import '../../core/theme/colors.dart';

/// Flag + dropdown to switch app [Locale]; persists via [setAppLocale].
class LanguageMenuButton extends ConsumerWidget {
  const LanguageMenuButton({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final current = ref.watch(localeProvider);
    LocaleOption? currentOpt;
    for (final o in kSupportedLocaleOptions) {
      if (o.locale.languageCode == current.languageCode &&
          (o.locale.countryCode ?? '') == (current.countryCode ?? '')) {
        currentOpt = o;
        break;
      }
    }
    currentOpt ??= kSupportedLocaleOptions.firstWhere(
      (o) => o.locale.languageCode == current.languageCode,
      orElse: () => kSupportedLocaleOptions.first,
    );

    return PopupMenuButton<Locale>(
      tooltip: l10n.language,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(currentOpt.flag, style: const TextStyle(fontSize: 20)),
            if (!compact) ...[
              const SizedBox(width: 6),
              Text(
                l10n.labelForLocaleOption(currentOpt),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
            const Icon(Icons.arrow_drop_down, color: kTextMuted),
          ],
        ),
      ),
      itemBuilder: (context) {
        return [
          for (final o in kSupportedLocaleOptions)
            PopupMenuItem<Locale>(
              value: o.locale,
              child: Row(
                children: [
                  Text(o.flag, style: const TextStyle(fontSize: 20)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      '${l10n.labelForLocaleOption(o)} (${o.locale.languageCode})',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
        ];
      },
      onSelected: (locale) async => setAppLocale(ref, locale),
    );
  }
}
