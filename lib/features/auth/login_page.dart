import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:verdant/l10n/app_localizations.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/colors.dart';
import '../../core/utils/app_validators.dart';
import '../../core/utils/responsive.dart';
import '../landing/landing_design_tokens.dart';
import '../landing/widgets/public_marketing_app_bar.dart';
import '../../services/supabase_service.dart';
import '../../shared/widgets/legal_footer.dart';
import '../../shared/widgets/verdant_input.dart';
import '../../shared/widgets/verdant_logo.dart';
import 'widgets/auth_brand_panel.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _error;
  bool _loading = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    setState(() => _error = null);
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (!AppConstants.isSupabaseConfigured) {
      setState(() => _error = l10n.errSupabaseLogin);
      return;
    }
    setState(() => _loading = true);
    try {
      await SupabaseService.instance.signIn(
        email: _email.text.trim(),
        password: _password.text,
      );
      if (mounted) context.go('/dashboard');
    } catch (e) {
      setState(() => _error = l10n.errLoginFailed);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _google() async {
    final l10n = AppLocalizations.of(context);
    if (!AppConstants.isSupabaseConfigured) {
      setState(() => _error = l10n.errOAuth);
      return;
    }
    await SupabaseService.instance.client.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: Uri.base.origin,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final split = Responsive.isDesktop(context);

    return Theme(
      data: LandingDesign.themeOverlay(context),
      child: Scaffold(
        backgroundColor: LandingDesign.background,
        appBar: const PublicMarketingAppBar(),
        body: Theme(
          data: LandingDesign.authShellTheme(context),
          child: Row(
          children: [
            if (split) const Expanded(flex: 4, child: AuthBrandPanel()),
            Expanded(
              flex: 6,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(32),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!split) const VerdantLogo(size: 40),
                          if (!split) const SizedBox(height: 24),
                          Text(
                            l10n.loginTitle,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                l10n.loginNoAccount,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              TextButton(
                                onPressed: () => context.go('/auth/register'),
                                child: Text(l10n.loginRegisterCta),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          VerdantInput(
                            label: l10n.loginEmail,
                            hint: l10n.loginEmailHint,
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,
                            validator: (v) => AppValidators.email(l10n, v),
                          ),
                          const SizedBox(height: 16),
                          VerdantInput(
                            label: l10n.loginPassword,
                            controller: _password,
                            obscureText: true,
                            validator: (v) => AppValidators.password(l10n, v),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () =>
                                  context.go('/auth/forgot-password'),
                              child: Text(l10n.loginForgot),
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (_error != null)
                            Text(_error!,
                                style: const TextStyle(color: kError)),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: _loading ? null : _submit,
                              style: FilledButton.styleFrom(
                                backgroundColor: LandingDesign.primary,
                                foregroundColor: LandingDesign.onPrimary,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                _loading
                                    ? l10n.loginSubmitLoading
                                    : l10n.loginSubmit,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              const Expanded(
                                  child: Divider(color: LandingDesign.border)),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  l10n.or,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                              const Expanded(
                                  child: Divider(color: LandingDesign.border)),
                            ],
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: _google,
                              icon: const Icon(Icons.g_mobiledata),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: LandingDesign.primary,
                                side: const BorderSide(
                                    color: LandingDesign.primary),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              label: Text(l10n.loginGoogle),
                            ),
                          ),
                          const SizedBox(height: 32),
                          const LegalFooter(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }
}
