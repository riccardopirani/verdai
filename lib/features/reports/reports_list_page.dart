import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:verdant/l10n/app_localizations.dart';

import '../../core/theme/colors.dart';
import '../../services/esg_automation_service.dart';
import '../../shared/widgets/status_badge.dart';
import '../../shared/widgets/verdant_button.dart';
import '../../shared/widgets/verdant_card.dart';

class ReportsListPage extends StatelessWidget {
  const ReportsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: kSurface,
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: VerdantButton(
              label: l10n.reportsNew,
              onPressed: () => context.go('/reports/new'),
            ),
          ),
          const SizedBox(height: 16),
          ...EsgAutomationService.instance
                  .yearOverYear()
                  .every((y) => y.totalKg == 0)
              ? [
                  Text(
                    l10n.reportsEmptyState,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ]
              : [
                  for (final y
                      in EsgAutomationService.instance.yearOverYear()) ...[
                  _ReportTile(
                    title: l10n.reportsGeneratedForYear('${y.year}'),
                    standard: 'CSRD / GRI / ESRS',
                    year: y.year,
                    status: 'published',
                    l10n: l10n,
                  ),
                  const SizedBox(height: 12),
                ],
              ],
        ],
      ),
    );
  }
}

class _ReportTile extends StatelessWidget {
  const _ReportTile({
    required this.title,
    required this.standard,
    required this.year,
    required this.status,
    required this.l10n,
  });

  final String title;
  final String standard;
  final int year;
  final String status;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final tone = status == 'published'
        ? BadgeTone.success
        : status == 'in_review'
            ? BadgeTone.warning
            : BadgeTone.neutral;
    final statusLabel = switch (status) {
      'published' => l10n.statusPublished,
      'in_review' => l10n.statusInReview,
      _ => l10n.statusDraft,
    };
    return VerdantCard(
      child: ListTile(
        title: Text(title),
        subtitle: Text(l10n.reportsRowMeta(standard, '$year')),
        trailing: StatusBadge(label: statusLabel, tone: tone),
      ),
    );
  }
}
