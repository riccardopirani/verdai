import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/constants/app_constants.dart';

/// Stripe Checkout / Customer Portal. Backend should create sessions and return URLs.
class StripeService {
  StripeService._();
  static final StripeService instance = StripeService._();

  Future<void> initIfConfigured() async {
    if (AppConstants.stripePublishableKey.isEmpty) return;
    Stripe.publishableKey = AppConstants.stripePublishableKey;
    await Stripe.instance.applySettings();
  }

  /// Call your Edge Function / API that returns `session.url` for Checkout.
  Future<void> openCheckoutUrl(Uri checkoutUrl) async {
    if (!await launchUrl(checkoutUrl, mode: LaunchMode.externalApplication)) {
      throw Exception('Impossibile aprire Checkout Stripe');
    }
  }

  Future<void> openCustomerPortal(Uri portalUrl) async {
    if (!await launchUrl(portalUrl, mode: LaunchMode.externalApplication)) {
      throw Exception('Impossibile aprire il portale cliente');
    }
  }

  /// Webhook handler belongs on the server (Supabase Edge Function).
  Future<void> handleWebhook(String payload, String signature) async {}
}
