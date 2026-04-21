import 'package:flutter/material.dart';
import 'package:verdant/l10n/app_localizations.dart';

import '../../../core/theme/colors.dart';
import '../../../shared/widgets/verdant_card.dart';

class ProblemSection extends StatelessWidget {
  const ProblemSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.problemTitle,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, c) {
              final w = c.maxWidth;
              final columns = w > 900 ? 3 : 1;
              final cards = [
                _ProblemCard(
                  emoji: '🗂️',
                  title: l10n.problem1Title,
                  body: l10n.problem1Body,
                ),
                _ProblemCard(
                  emoji: '⚖️',
                  title: l10n.problem2Title,
                  body: l10n.problem2Body,
                ),
                _ProblemCard(
                  emoji: '💸',
                  title: l10n.problem3Title,
                  body: l10n.problem3Body,
                ),
              ];
              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: cards
                    .map(
                      (e) => SizedBox(
                        width: columns == 3 ? (w - 32) / 3 : w,
                        child: e,
                      ),
                    )
                    .toList(),
              );
            },
          ),
          const SizedBox(height: 32),
          Center(
            child: Icon(
              Icons.arrow_downward_rounded,
              color: kPrimaryGreen.withValues(alpha: 0.8),
              size: 36,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.warning_amber_rounded, color: kError, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  l10n.problemWarning,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: kError,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProblemCard extends StatelessWidget {
  const _ProblemCard({
    required this.emoji,
    required this.title,
    required this.body,
  });

  final String emoji;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return VerdantCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 28)),
          const SizedBox(height: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
