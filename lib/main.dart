import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart';
import 'core/constants/app_constants.dart';
import 'core/locale/locale_prefs.dart';
import 'core/locale/locale_provider.dart';
import 'core/web/configure_url_strategy.dart'
    if (dart.library.js_interop) 'core/web/configure_url_strategy_web.dart';
import 'services/stripe_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureUrlStrategy();

  final initialLocale = await loadSavedOrDeviceLocale();

  if (AppConstants.isSupabaseConfigured) {
    await Supabase.initialize(
      url: AppConstants.supabaseUrl,
      anonKey: AppConstants.supabaseAnonKey,
    );
  }

  await StripeService.instance.initIfConfigured();

  runApp(
    ProviderScope(
      overrides: [
        localeProvider.overrideWith((ref) => initialLocale),
      ],
      child: const VerdaiApp(),
    ),
  );
}
