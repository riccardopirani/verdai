import 'package:flutter/material.dart';
import 'package:verdant/l10n/app_localizations.dart';

import '../../core/theme/colors.dart';
import '../../shared/widgets/verdant_card.dart';

class StandardsList extends StatelessWidget {
  const StandardsList({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final items = [
      ('CSRD', l10n.stdCsrdTitle),
      ('GRI', l10n.stdGri),
      ('ESRS', l10n.stdEsrs),
    ];
    return Column(
      children: [
        for (final i in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: VerdantCard(
              child: ListTile(
                title:
                    Text(i.$1, style: Theme.of(context).textTheme.titleLarge),
                subtitle: Text(i.$2),
                trailing: const Icon(Icons.chevron_right, color: kTextMuted),
              ),
            ),
          ),
      ],
    );
  }
}
