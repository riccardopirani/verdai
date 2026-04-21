import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _company = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _sector = 'Manufacturing';
  String _size = '<50';
  bool _terms = false;
  String? _error;
  bool _loading = false;

  @override
  void dispose() {
    _company.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  double get _strength {
    final p = _password.text;
    var s = 0.0;
    if (p.length >= 8) s += 0.35;
    if (RegExp(r'[A-Z]').hasMatch(p)) s += 0.2;
    if (RegExp(r'[0-9]').hasMatch(p)) s += 0.25;
    if (RegExp(r'[^A-Za-z0-9]').hasMatch(p)) s += 0.2;
    return s.clamp(0, 1);
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    setState(() => _error = null);
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (!_terms) {
      setState(() => _error = l10n.errTerms);
      return;
    }
    if (!AppConstants.isSupabaseConfigured) {
      setState(() => _error = l10n.errSupabaseRegister);
      return;
    }
    setState(() => _loading = true);
    try {
      final res = await SupabaseService.instance.signUp(
        email: _email.text.trim(),
        password: _password.text,
      );
      final user = res.user;
      if (user != null) {
        await SupabaseService.instance.createCompany(
          userId: user.id,
          name: _company.text.trim(),
          sector: _sector,
          size: _size,
        );
      }
      if (mounted) context.go('/onboarding');
    } catch (e) {
      setState(() => _error = l10n.errRegisterFailed);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final split = Responsive.isDesktop(context);

    final sectors = <(String, String)>[
      ('Manufacturing', l10n.sectorManufacturing),
      ('Retail', l10n.sectorRetail),
      ('Services', l10n.sectorServices),
      ('Other', l10n.sectorOther),
    ];

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
                  constraints: const BoxConstraints(maxWidth: 460),
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
                            l10n.registerTitle,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          Text(
                            l10n.registerSubtitle,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 24),
                          VerdantInput(
                            label: l10n.registerCompany,
                            controller: _company,
                            validator: (v) => AppValidators.required(
                              l10n,
                              v,
                              l10n.labelCompany,
                            ),
                          ),
                          const SizedBox(height: 16),
                          VerdantInput(
                            label: l10n.registerEmail,
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,
                            validator: (v) => AppValidators.email(l10n, v),
                          ),
                          const SizedBox(height: 16),
                          VerdantInput(
                            label: l10n.registerPassword,
                            controller: _password,
                            obscureText: true,
                            validator: (v) => AppValidators.password(l10n, v),
                            onChanged: (_) => setState(() {}),
                          ),
                          const SizedBox(height: 8),
                          TweenAnimationBuilder<double>(
                            tween: Tween(end: _strength),
                            duration: const Duration(milliseconds: 200),
                            builder: (context, v, _) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: LinearProgressIndicator(
                                  value: v,
                                  minHeight: 6,
                                  backgroundColor: LandingDesign.border,
                                  color: Color.lerp(
                                    LandingDesign.destructive,
                                    LandingDesign.primary,
                                    v,
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          Text(
                            l10n.registerSector,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<String>(
                            // ignore: deprecated_member_use
                            value: _sector,
                            style: Theme.of(context).textTheme.bodyLarge,
                            dropdownColor: LandingDesign.background,
                            iconEnabledColor: LandingDesign.primary,
                            borderRadius: BorderRadius.circular(10),
                            items: sectors
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e.$1,
                                    child: Text(
                                      e.$2,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge,
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (v) =>
                                setState(() => _sector = v ?? _sector),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            l10n.registerSize,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<String>(
                            // ignore: deprecated_member_use
                            value: _size,
                            style: Theme.of(context).textTheme.bodyLarge,
                            dropdownColor: LandingDesign.background,
                            iconEnabledColor: LandingDesign.primary,
                            borderRadius: BorderRadius.circular(10),
                            items: [
                              DropdownMenuItem(
                                value: '<50',
                                child: Text(
                                  l10n.sizeUnder50,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                              DropdownMenuItem(
                                value: '50-250',
                                child: Text(
                                  l10n.size50to250,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                              DropdownMenuItem(
                                value: '>250',
                                child: Text(
                                  l10n.sizeOver250,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                            ],
                            onChanged: (v) =>
                                setState(() => _size = v ?? _size),
                          ),
                          const SizedBox(height: 16),
                          CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            value: _terms,
                            onChanged: (v) =>
                                setState(() => _terms = v ?? false),
                            title: Text(
                              l10n.registerTerms,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                          if (_error != null) ...[
                            const SizedBox(height: 8),
                            Text(_error!,
                                style: const TextStyle(color: kError)),
                          ],
                          const SizedBox(height: 16),
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
                                    ? l10n.registerSubmitLoading
                                    : l10n.registerSubmit,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextButton(
                            onPressed: () => context.go('/auth/login'),
                            child: Text(l10n.registerHasAccount),
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
