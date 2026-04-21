/// Configure via `--dart-define` or IDE launch configuration. Do not commit secrets.
class AppConstants {
  static const String supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  static const String supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');
  static const String stripePublishableKey = String.fromEnvironment('STRIPE_PUBLISHABLE_KEY');

  static const String priceStarter = String.fromEnvironment('STRIPE_PRICE_STARTER');
  static const String priceGrowth = String.fromEnvironment('STRIPE_PRICE_GROWTH');
  static const String pricePartner = String.fromEnvironment('STRIPE_PRICE_PARTNER');

  static bool get isSupabaseConfigured =>
      supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty;
}
