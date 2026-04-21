import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:verdant/l10n/app_localizations.dart';

import '../../../core/theme/colors.dart';
import '../../../shared/widgets/verdant_logo.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 32),
      decoration: const BoxDecoration(
        color: kDeepForest,
        border: Border(top: BorderSide(color: kBorderSubtle)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const VerdantLogo(size: 32),
              const SizedBox(width: 12),
              Text(l10n.brandName, style: Theme.of(context).textTheme.headlineMedium),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            l10n.footerTagline,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              TextButton(
                onPressed: () => context.go('/features'),
                child: Text(l10n.footerFeatures),
              ),
              TextButton(
                onPressed: () => context.go('/pricing'),
                child: Text(l10n.footerPricing),
              ),
              TextButton(
                onPressed: () => context.go('/auth/login'),
                child: Text(l10n.footerLogin),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            l10n.footerCopyright(DateTime.now().year),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: kTextMuted),
          ),
        ],
      ),
    );
  }
}
