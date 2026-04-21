import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:verdant/l10n/app_localizations.dart';

import '../../../core/theme/colors.dart';
import '../../../shared/widgets/verdant_card.dart';

class SocialProofSection extends StatelessWidget {
  const SocialProofSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.socialTitle,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, c) {
              final oneCol = c.maxWidth < 768;
              final cards = [
                _Testimonial(
                  initials: 'MR',
                  name: l10n.testimonial1Name,
                  roleCompany: l10n.testimonial1Role,
                  quote: l10n.testimonial1Quote,
                ),
                _Testimonial(
                  initials: 'LM',
                  name: l10n.testimonial2Name,
                  roleCompany: l10n.testimonial2Role,
                  quote: l10n.testimonial2Quote,
                ),
                _Testimonial(
                  initials: 'GB',
                  name: l10n.testimonial3Name,
                  roleCompany: l10n.testimonial3Role,
                  quote: l10n.testimonial3Quote,
                ),
              ];
              if (oneCol) {
                return Column(
                  children: [
                    for (var i = 0; i < cards.length; i++) ...[
                      cards[i],
                      if (i < cards.length - 1) const SizedBox(height: 16),
                    ],
                  ],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < cards.length; i++) ...[
                    Expanded(child: cards[i]),
                    if (i < cards.length - 1) const SizedBox(width: 16),
                  ],
                ],
              );
            },
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _MetricPill(text: l10n.socialMetricCompanies),
              _MetricPill(text: l10n.socialMetricCompliance),
              _MetricPill(text: l10n.socialMetricSavings),
              _MetricPill(text: l10n.socialMetricRating),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetricPill extends StatelessWidget {
  const _MetricPill({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: kSurfaceCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: kBorderSubtle),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: kLeafAccent),
      ),
    );
  }
}

class _Testimonial extends StatelessWidget {
  const _Testimonial({
    required this.initials,
    required this.name,
    required this.roleCompany,
    required this.quote,
  });

  final String initials;
  final String name;
  final String roleCompany;
  final String quote;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: VerdantCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: kPrimaryGreen.withValues(alpha: 0.3),
                    child: Text(
                      initials,
                      style: const TextStyle(
                        color: kTextPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name, style: Theme.of(context).textTheme.titleLarge),
                        Text(
                          roleCompany,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.star, color: kWarning, size: 18),
                  const Icon(Icons.star, color: kWarning, size: 18),
                  const Icon(Icons.star, color: kWarning, size: 18),
                  const Icon(Icons.star, color: kWarning, size: 18),
                  const Icon(Icons.star, color: kWarning, size: 18),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                '“$quote”',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
