import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:verdant/l10n/app_localizations.dart';

import '../../shared/widgets/legal_footer.dart';
import 'landing_design_tokens.dart';
import 'widgets/public_marketing_app_bar.dart';

/// Public contact page — light marketing layout with [PublicMarketingSliverAppBar].
class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  static const double _maxContent = 1152;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Theme(
      data: LandingDesign.themeOverlay(context),
      child: Scaffold(
        backgroundColor: LandingDesign.background,
        body: CustomScrollView(
          slivers: [
            const PublicMarketingSliverAppBar(
              highlight: PublicNavHighlight.contact,
            ),
            SliverToBoxAdapter(
              child: ColoredBox(
                color: LandingDesign.muted.withValues(alpha: 0.5),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 96,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints:
                          const BoxConstraints(maxWidth: _maxContent),
                      child: Column(
                        children: [
                          Text(
                            l10n.contactPageTitle,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                  fontSize: 48,
                                  fontWeight: FontWeight.w700,
                                  height: 1.1,
                                  color: LandingDesign.foreground,
                                ),
                          ),
                          const SizedBox(height: 24),
                          ConstrainedBox(
                            constraints:
                                const BoxConstraints(maxWidth: 672),
                            child: Text(
                              l10n.contactPageSubtitle,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontSize: 20,
                                    height: 1.75,
                                    color: LandingDesign.mutedForeground,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                          ),
                          const SizedBox(height: 64),
                          LayoutBuilder(
                            builder: (context, c) {
                              final row = c.maxWidth >= 900;
                              final cards = [
                                _ContactCard(
                                  icon: Icons.handshake_outlined,
                                  title: l10n.contactCardSalesTitle,
                                  body: l10n.contactCardSalesBody,
                                  email: l10n.contactEmailSalesLabel,
                                  cta: l10n.contactCtaWriteSales,
                                  subject: l10n.contactMailSubjectSales,
                                ),
                                _ContactCard(
                                  icon: Icons.support_agent_outlined,
                                  title: l10n.contactCardSupportTitle,
                                  body: l10n.contactCardSupportBody,
                                  email: l10n.contactEmailSupportLabel,
                                  cta: l10n.contactCtaWriteSupport,
                                  subject: l10n.contactMailSubjectSupport,
                                ),
                                _ContactCard(
                                  icon: Icons.schedule_outlined,
                                  title: l10n.contactCardOfficeTitle,
                                  body:
                                      '${l10n.contactCardOfficeBody}\n\nDodici Morelli\nVia del Riccio 24/A',
                                  email: null,
                                  cta: null,
                                  subject: null,
                                ),
                              ];
                              if (row) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (var i = 0; i < cards.length; i++) ...[
                                      if (i > 0) const SizedBox(width: 32),
                                      Expanded(child: cards[i]),
                                    ],
                                  ],
                                );
                              }
                              return Column(
                                children: [
                                  for (var i = 0; i < cards.length; i++) ...[
                                    if (i > 0) const SizedBox(height: 32),
                                    cards[i],
                                  ],
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 48),
                          const _ContactFormCard(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: LegalFooter()),
          ],
        ),
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  const _ContactCard({
    required this.icon,
    required this.title,
    required this.body,
    required this.email,
    required this.cta,
    required this.subject,
  });

  final IconData icon;
  final String title;
  final String body;
  final String? email;
  final String? cta;
  final String? subject;

  Future<void> _mail() async {
    if (email == null || subject == null) return;
    final uri = Uri.parse(
      'mailto:$email?subject=${Uri.encodeComponent(subject!)}',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(12);
    return Material(
      color: LandingDesign.background,
      elevation: 0,
      borderRadius: radius,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: radius,
          border: Border.all(color: LandingDesign.border),
        ),
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(icon, size: 32, color: LandingDesign.primary),
            const SizedBox(height: 20),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: LandingDesign.foreground,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              body,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: LandingDesign.mutedForeground,
                    height: 1.5,
                  ),
            ),
            if (email != null && cta != null) ...[
              const SizedBox(height: 20),
              SelectableText(
                email!,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: LandingDesign.primary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _mail,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: LandingDesign.primary,
                    side: const BorderSide(color: LandingDesign.primary),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(cta!),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ContactFormCard extends StatefulWidget {
  const _ContactFormCard();

  @override
  State<_ContactFormCard> createState() => _ContactFormCardState();
}

class _ContactFormCardState extends State<_ContactFormCard> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _msgCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _sending = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _msgCtrl.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;

    setState(() => _sending = true);
    final uri = Uri.parse(
      'mailto:sales@marconisoftware.com'
      '?subject=${Uri.encodeComponent('Richiesta contatto da sito')}'
      '&body=${Uri.encodeComponent('Nome: ${_nameCtrl.text}\nEmail: ${_emailCtrl.text}\n\nMessaggio:\n${_msgCtrl.text}')}',
    );

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(12);
    return Material(
      color: LandingDesign.background,
      borderRadius: radius,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: radius,
          border: Border.all(color: LandingDesign.border),
        ),
        padding: const EdgeInsets.all(32),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Scrivici',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: LandingDesign.foreground,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                'Compila il form e ti risponderemo il prima possibile.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: LandingDesign.mutedForeground,
                    ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Inserisci il nome' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailCtrl,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  final value = v?.trim() ?? '';
                  if (value.isEmpty) return 'Inserisci l\'email';
                  if (!value.contains('@')) return 'Email non valida';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _msgCtrl,
                decoration: const InputDecoration(
                  labelText: 'Messaggio',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                minLines: 5,
                maxLines: 8,
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Inserisci un messaggio'
                    : null,
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: _sending ? null : _send,
                style: FilledButton.styleFrom(
                  backgroundColor: LandingDesign.primary,
                  foregroundColor: LandingDesign.onPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(_sending ? 'Invio...' : 'Invia richiesta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
