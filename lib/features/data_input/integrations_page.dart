import 'package:flutter/material.dart';
import 'package:verdant/l10n/app_localizations.dart';

import '../../core/theme/colors.dart';
import '../../shared/widgets/verdant_button.dart';
import '../../shared/widgets/verdant_card.dart';

class IntegrationsPage extends StatelessWidget {
  const IntegrationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final items = <(String, String, bool)>[
      (l10n.integNameSap, l10n.integConnect, false),
      (l10n.integNameFic, l10n.integConnect, false),
      (l10n.integNameSheets, l10n.integOAuth, false),
      (l10n.integNameQuickbooks, l10n.integConnect, false),
      (l10n.integNameApi, l10n.integGenApiKey, false),
      (l10n.integNameExcel, l10n.integStatusConnected, true),
    ];

    return Scaffold(
      backgroundColor: kSurface,
      appBar: AppBar(title: Text(l10n.integrationsTitle)),
      body: GridView.builder(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.3,
        ),
        itemCount: items.length,
        itemBuilder: (context, i) {
          final s = items[i];
          return VerdantCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(s.$1, style: Theme.of(context).textTheme.titleLarge),
                const Spacer(),
                if (s.$3)
                  Text(
                    s.$2,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: kSuccess),
                  )
                else
                  VerdantButton(
                    label: s.$2,
                    expand: true,
                    onPressed: () {},
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
