import 'package:flutter/material.dart';
import 'package:verdant/l10n/app_localizations.dart';

import '../../../core/theme/colors.dart';
import '../../../shared/widgets/status_badge.dart';
import '../../../shared/widgets/verdant_card.dart';

class ComplianceStatusCard extends StatelessWidget {
  const ComplianceStatusCard({
    super.key,
    this.progress = 0.68,
  });

  final double progress;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return VerdantCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.complianceCardTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            l10n.complianceCsrdProgress,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              color: kWarning,
              backgroundColor: kBorderSubtle,
            ),
          ),
          const SizedBox(height: 12),
          StatusBadge(
            label: l10n.complianceDeadline,
            tone: BadgeTone.warning,
          ),
        ],
      ),
    );
  }
}
