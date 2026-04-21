import 'package:flutter/material.dart';
import 'package:verdant/l10n/app_localizations.dart';

import '../../core/theme/colors.dart';
import '../../services/stripe_service.dart';
import '../../services/supabase_service.dart';
import '../../shared/models/subscription.dart';

class BillingPage extends StatefulWidget {
  const BillingPage({super.key});

  @override
  State<BillingPage> createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  bool _loading = true;
  bool _busy = false;
  String? _error;
  String? _companyId;
  Subscription? _subscription;
  List<Map<String, dynamic>> _plans = const [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final user = SupabaseService.instance.currentUser;
      if (user == null) {
        throw StateError('Utente non autenticato');
      }
      final company = await SupabaseService.instance.fetchCompanyForUser(user.id);
      if (company == null) {
        throw StateError('Nessuna azienda trovata');
      }
      final overview = await SupabaseService.instance.fetchBillingOverview(
        company.id,
      );
      setState(() {
        _companyId = company.id;
        _subscription = overview['subscription'] == null
            ? null
            : Subscription.fromJson(
                Map<String, dynamic>.from(overview['subscription'] as Map),
              );
        _plans = (overview['plans'] as List<dynamic>? ?? const [])
            .map((e) => Map<String, dynamic>.from(e as Map))
            .toList();
      });
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _openCheckout(String planKey) async {
    if (_companyId == null) return;
    setState(() => _busy = true);
    try {
      final base = Uri.base;
      final checkout = await SupabaseService.instance.createCheckoutSession(
        companyId: _companyId!,
        planKey: planKey,
        successUrl: base.replace(path: '/#/settings/billing', query: ''),
        cancelUrl: base.replace(path: '/#/settings/billing', query: ''),
      );
      await StripeService.instance.openCheckoutUrl(checkout);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Errore checkout: $e')),
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _openPortal() async {
    if (_companyId == null) return;
    setState(() => _busy = true);
    try {
      final portal = await SupabaseService.instance.createCustomerPortalSession(
        companyId: _companyId!,
        returnUrl: Uri.base.replace(path: '/#/settings/billing', query: ''),
      );
      await StripeService.instance.openCustomerPortal(portal);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Errore portale: $e')),
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _cancelAtPeriodEnd() async {
    if (_companyId == null) return;
    setState(() => _busy = true);
    try {
      await SupabaseService.instance.cancelSubscriptionAtPeriodEnd(_companyId!);
      await _load();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Errore annullamento: $e')),
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final currentPlan = _subscription?.plan;

    return Scaffold(
      backgroundColor: kSurface,
      appBar: AppBar(title: Text(l10n.billingTitle)),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(_error!, style: const TextStyle(color: kError)),
                  ),
                )
              : ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    Card(
                      child: ListTile(
                        title: Text(
                          l10n.billingCurrent,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        subtitle: Text(
                          _subscription == null
                              ? 'Nessun abbonamento attivo'
                              : '${_subscription!.plan.toUpperCase()} • ${_subscription!.status}',
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    for (final plan in _plans) ...[
                      Card(
                        child: ListTile(
                          title: Text(
                            '${plan['name']} • €${plan['unitAmount']}/${plan['interval']}',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          subtitle: Text(plan['description'] as String? ?? ''),
                          trailing: FilledButton(
                            onPressed: _busy
                                ? null
                                : currentPlan == plan['key']
                                    ? null
                                    : () => _openCheckout(plan['key'] as String),
                            child: Text(
                              currentPlan == plan['key']
                                  ? 'Piano attivo'
                                  : 'Seleziona',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                    Card(
                      child: ListTile(
                        title: Text(
                          l10n.billingPayment,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        subtitle: Text(l10n.billingCardMask),
                      ),
                    ),
                    const SizedBox(height: 24),
                    OutlinedButton(
                      onPressed: _busy || _subscription == null ? null : _openPortal,
                      child: Text(l10n.billingManagePortal),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      l10n.billingDanger,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: kError),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: _busy || _subscription == null
                          ? null
                          : () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (c) => AlertDialog(
                                  title: Text(l10n.dialogCancelTitle),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(c, false),
                                      child: Text(l10n.no),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(c, true),
                                      child: Text(l10n.yes),
                                    ),
                                  ],
                                ),
                              );
                              if (confirm == true && context.mounted) {
                                await _cancelAtPeriodEnd();
                              }
                            },
                      child: Text(l10n.billingCancelSub),
                    ),
                  ],
                ),
    );
  }
}
