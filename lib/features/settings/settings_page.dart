import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:verdant/l10n/app_localizations.dart';

import '../../core/theme/colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: kSurface,
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          ListTile(
            title: Text(l10n.settingsCompany),
            onTap: () => context.go('/settings/company'),
          ),
          ListTile(
            title: Text(l10n.settingsBilling),
            onTap: () => context.go('/settings/billing'),
          ),
          ListTile(
            title: Text(l10n.settingsManualFull),
            onTap: () => context.go('/data/manual'),
          ),
          const SizedBox(height: 24),
          TextButton(
            onPressed: () => context.go('/auth/login'),
            child: Text(l10n.signOut),
          ),
        ],
      ),
    );
  }
}
