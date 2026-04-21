import 'dart:async';

import 'package:flutter/material.dart';
import 'package:verdant/l10n/app_localizations.dart';

import '../../landing/landing_design_tokens.dart';
import '../../../shared/widgets/verdant_logo.dart';

class AuthBrandPanel extends StatefulWidget {
  const AuthBrandPanel({super.key});

  @override
  State<AuthBrandPanel> createState() => _AuthBrandPanelState();
}

class _AuthBrandPanelState extends State<AuthBrandPanel> {
  Timer? _t;
  var _chars = 0;
  String _full = '';
  Locale? _locale;

  @override
  void dispose() {
    _t?.cancel();
    super.dispose();
  }

  void _restartTyping(String text) {
    _t?.cancel();
    _full = text;
    _chars = 0;
    if (text.isEmpty) return;
    _t = Timer.periodic(const Duration(milliseconds: 42), (_) {
      if (!mounted) return;
      if (_chars < _full.length) {
        setState(() => _chars++);
      } else {
        _t?.cancel();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context);
    final tagline =
        l10n.footerTagline.replaceAll(RegExp(r'[\r\n]+'), ' ').trim();
    if (_locale != locale || _full != tagline) {
      _locale = locale;
      _restartTyping(tagline);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return ColoredBox(
      color: LandingDesign.primary,
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const VerdantLogo(size: 80),
            const SizedBox(height: 24),
            Text(
              _full.isEmpty
                  ? ''
                  : _full.substring(0, _chars.clamp(0, _full.length)),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: LandingDesign.onPrimary,
                  ),
            ),
            const SizedBox(height: 32),
            _bullet(context, l10n.authBulletEmojiLock, l10n.authBulletGdpr),
            _bullet(context, l10n.authBulletEmojiChart, l10n.authBulletCompanies),
            _bullet(context, l10n.authBulletEmojiCheck, l10n.authBulletSetup),
          ],
        ),
      ),
    );
  }

  Widget _bullet(BuildContext context, String icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: LandingDesign.onPrimaryMuted,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
