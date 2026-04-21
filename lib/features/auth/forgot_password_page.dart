import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:verdant/l10n/app_localizations.dart';

import '../../core/constants/app_constants.dart';
import '../../core/utils/app_validators.dart';
import '../../features/landing/landing_design_tokens.dart';
import '../../features/landing/widgets/public_marketing_app_bar.dart';
import '../../services/supabase_service.dart';
import '../../shared/widgets/legal_footer.dart';
import '../../shared/widgets/verdant_button.dart';
import '../../shared/widgets/verdant_input.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _email = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _message;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final l10n = AppLocalizations.of(context);
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (!AppConstants.isSupabaseConfigured) {
      setState(() => _message = l10n.errConfigureSupabase);
      return;
    }
    await SupabaseService.instance.resetPassword(_email.text.trim());
    setState(() => _message = l10n.forgotMessage);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Theme(
      data: LandingDesign.themeOverlay(context),
      child: Scaffold(
        backgroundColor: LandingDesign.background,
        appBar: const PublicMarketingAppBar(),
        body: Theme(
          data: LandingDesign.authShellTheme(context),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.forgotTitle,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          const SizedBox(height: 24),
                          VerdantInput(
                            label: l10n.loginEmail,
                            controller: _email,
                            validator: (v) => AppValidators.email(l10n, v),
                          ),
                          if (_message != null) ...[
                            const SizedBox(height: 12),
                            Text(
                              _message!,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                          const SizedBox(height: 20),
                          VerdantButton(
                            label: l10n.forgotSubmit,
                            expand: true,
                            onPressed: _send,
                          ),
                          TextButton(
                            onPressed: () => context.go('/auth/login'),
                            child: Text(l10n.forgotBack),
                          ),
                        ],
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
    );
  }
}
