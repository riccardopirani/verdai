import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/constants/app_constants.dart';
import '../core/constants/supabase_constants.dart';
import '../shared/models/company.dart';
import '../shared/models/emission_data.dart';
import '../shared/models/esg_report.dart';
import '../shared/models/subscription.dart';

class SupabaseService {
  SupabaseService._();
  static final SupabaseService instance = SupabaseService._();

  bool get isReady => AppConstants.isSupabaseConfigured;

  SupabaseClient get client {
    if (!isReady) {
      throw StateError('Supabase non configurato. Usa --dart-define.');
    }
    return Supabase.instance.client;
  }

  Stream<AuthState> get authStateChanges {
    if (!isReady) {
      return const Stream<AuthState>.empty();
    }
    return Supabase.instance.client.auth.onAuthStateChange;
  }

  User? get currentUser => isReady ? client.auth.currentUser : null;

  Future<AuthResponse> signUp({
    required String email,
    required String password,
  }) {
    if (!isReady) throw StateError('Supabase non configurato');
    return client.auth.signUp(email: email, password: password);
  }

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) {
    if (!isReady) throw StateError('Supabase non configurato');
    return client.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    if (!isReady) return;
    await client.auth.signOut();
  }

  Future<void> resetPassword(String email) {
    if (!isReady) throw StateError('Supabase non configurato');
    return client.auth.resetPasswordForEmail(email);
  }

  Future<Company?> fetchCompanyForUser(String userId) async {
    if (!isReady) return null;
    final row = await client
        .from(SupabaseTables.companies)
        .select()
        .eq('user_id', userId)
        .maybeSingle();
    if (row == null) return null;
    return Company.fromJson(Map<String, dynamic>.from(row));
  }

  Future<Company> createCompany({
    required String userId,
    required String name,
    String? sector,
    String? size,
    String? vatNumber,
  }) async {
    if (!isReady) throw StateError('Supabase non configurato');
    final row = await client
        .from(SupabaseTables.companies)
        .insert({
          'user_id': userId,
          'name': name,
          if (sector != null) 'sector': sector,
          if (size != null) 'size': size,
          if (vatNumber != null) 'vat_number': vatNumber,
        })
        .select()
        .single();
    return Company.fromJson(Map<String, dynamic>.from(row));
  }

  Future<List<EmissionRecord>> fetchEmissions(String companyId) async {
    if (!isReady) return [];
    final rows = await client
        .from(SupabaseTables.emissionRecords)
        .select()
        .eq('company_id', companyId);
    return (rows as List)
        .map((e) => EmissionRecord.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<List<EsgReport>> fetchReports(String companyId) async {
    if (!isReady) return [];
    final rows = await client
        .from(SupabaseTables.esgReports)
        .select()
        .eq('company_id', companyId);
    return (rows as List)
        .map((e) => EsgReport.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<Subscription?> fetchSubscription(String companyId) async {
    if (!isReady) return null;
    final row = await client
        .from(SupabaseTables.subscriptions)
        .select()
        .eq('company_id', companyId)
        .maybeSingle();
    if (row == null) return null;
    return Subscription.fromJson(Map<String, dynamic>.from(row));
  }

  /// Returns active subscription and 3 Stripe plans configured by backend code.
  Future<Map<String, dynamic>> fetchBillingOverview(String companyId) async {
    if (!isReady) throw StateError('Supabase non configurato');
    final response = await client.functions.invoke(
      'stripe-billing-overview',
      body: {'companyId': companyId},
    );
    return Map<String, dynamic>.from(response.data as Map);
  }

  /// Creates Checkout session for a plan key: starter | growth | partner.
  Future<Uri> createCheckoutSession({
    required String companyId,
    required String planKey,
    required Uri successUrl,
    required Uri cancelUrl,
  }) async {
    if (!isReady) throw StateError('Supabase non configurato');
    final response = await client.functions.invoke(
      'stripe-create-checkout-session',
      body: {
        'companyId': companyId,
        'planKey': planKey,
        'successUrl': successUrl.toString(),
        'cancelUrl': cancelUrl.toString(),
      },
    );
    final data = Map<String, dynamic>.from(response.data as Map);
    final raw = data['url'] as String?;
    if (raw == null || raw.isEmpty) {
      throw StateError('Checkout URL mancante');
    }
    return Uri.parse(raw);
  }

  Future<Uri> createCustomerPortalSession({
    required String companyId,
    required Uri returnUrl,
  }) async {
    if (!isReady) throw StateError('Supabase non configurato');
    final response = await client.functions.invoke(
      'stripe-create-customer-portal',
      body: {
        'companyId': companyId,
        'returnUrl': returnUrl.toString(),
      },
    );
    final data = Map<String, dynamic>.from(response.data as Map);
    final raw = data['url'] as String?;
    if (raw == null || raw.isEmpty) {
      throw StateError('Portal URL mancante');
    }
    return Uri.parse(raw);
  }

  Future<void> cancelSubscriptionAtPeriodEnd(String companyId) async {
    if (!isReady) throw StateError('Supabase non configurato');
    await client.functions.invoke(
      'stripe-cancel-subscription',
      body: {'companyId': companyId},
    );
  }
}
