import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:verdant/l10n/app_localizations.dart';

import '../../../core/theme/colors.dart';
import '../../../shared/widgets/verdant_card.dart';
import '../banani_dashboard_tokens.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key, this.banani = false});

  /// When true, renders only the action grid (no card/title) using [BananiDash] styles.
  final bool banani;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final items = <(String, IconData, String)>[
      (l10n.qaAddEmissions, Icons.add_circle_outline, '/emissions'),
      (l10n.qaGenReport, Icons.note_add_outlined, '/reports/new'),
      (l10n.qaUploadExcel, Icons.cloud_upload_outlined, '/emissions'),
      (l10n.qaConnectErp, Icons.link, '/integrations'),
    ];

    final grid = GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1,
      children: [
        for (final i in items)
          banani
              ? _BananiActionTile(
                  label: i.$1,
                  icon: i.$2,
                  onTap: () => context.go(i.$3),
                )
              : _ActionTile(
                  label: i.$1,
                  icon: i.$2,
                  onTap: () => context.go(i.$3),
                ),
      ],
    );

    if (banani) return grid;

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

class _BananiActionTile extends StatelessWidget {
  const _BananiActionTile({
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
      color: BananiDash.surface,
      borderRadius: BorderRadius.circular(BananiDash.radiusLg),
      child: InkWell(
        borderRadius: BorderRadius.circular(BananiDash.radiusLg),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(BananiDash.radiusLg),
            border: Border.all(color: BananiDash.border),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: BananiDash.muted,
                ),
                child: Icon(icon, color: BananiDash.mutedForeground, size: 22),
              ),
              const SizedBox(height: 12),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: BananiDash.foreground,
                ),
              ),
            ],
          ),
        ),
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
