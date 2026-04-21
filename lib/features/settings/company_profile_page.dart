import 'package:flutter/material.dart';
import 'package:verdant/l10n/app_localizations.dart';

import '../../core/theme/colors.dart';

class CompanyProfilePage extends StatelessWidget {
  const CompanyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: kSurface,
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(l10n.companyProfileTitle,
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 16),
          Text(
            l10n.fieldLegalName,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 8),
          Text(
            l10n.hintLegalDemo,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
