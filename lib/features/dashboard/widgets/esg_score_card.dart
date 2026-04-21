import 'package:flutter/material.dart';
import 'package:verdant/l10n/app_localizations.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../shared/widgets/verdant_card.dart';

class EsgScoreCard extends StatelessWidget {
  const EsgScoreCard({
    super.key,
    required this.score,
  });

  final double score;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final v = (score / 100).clamp(0.0, 1.0);

    return VerdantCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.dashEsgCardTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              SizedBox(
                width: 88,
                height: 88,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CircularProgressIndicator(
                      value: v,
                      strokeWidth: 8,
                      backgroundColor: kBorderSubtle,
                      color: kPrimaryGreen,
                    ),
                    Center(
                      child: Text(
                        score.toStringAsFixed(0),
                        style: verdantMono(22, weight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '/ 100',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      l10n.dashEsgDelta,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: kSuccess),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
