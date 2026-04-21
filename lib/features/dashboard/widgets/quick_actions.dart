import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:verdant/l10n/app_localizations.dart';

import '../../../core/theme/colors.dart';
import '../../../shared/widgets/verdant_card.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return VerdantCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.quickActionsTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, c) {
              final w = c.maxWidth;
              final cols = w > 700 ? 4 : 2;
              final items = <(String, IconData, String)>[
                (l10n.qaAddEmissions, Icons.add_chart, '/emissions'),
                (l10n.qaGenReport, Icons.description_outlined, '/reports/new'),
                (l10n.qaUploadExcel, Icons.upload_file, '/emissions'),
                (l10n.qaConnectErp, Icons.hub_outlined, '/integrations'),
              ];
              return GridView.count(
                crossAxisCount: cols,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.4,
                children: [
                  for (final i in items)
                    _ActionTile(
                      label: i.$1,
                      icon: i.$2,
                      onTap: () => context.go(i.$3),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kSurface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: kBorderSubtle),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: kPrimaryGreen),
              const Spacer(),
              Text(label, style: Theme.of(context).textTheme.labelLarge),
            ],
          ),
        ),
      ),
    );
  }
}
