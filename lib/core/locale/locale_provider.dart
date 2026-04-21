import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'locale_prefs.dart';

/// Initial value is overridden from [main] after [loadSavedOrDeviceLocale].
final localeProvider = StateProvider<Locale>((ref) => const Locale('en'));

Future<void> setAppLocale(WidgetRef ref, Locale locale) async {
  ref.read(localeProvider.notifier).state = locale;
  await persistLocale(locale);
}
