import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:verdant/l10n/app_localizations.dart';

import '../../../core/theme/colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/widgets/verdant_button.dart';
import '../../../shared/widgets/verdant_card.dart';

class PricingCards extends StatefulWidget {
  const PricingCards({super.key, this.compact = false});

  final bool compact;

  @override
  State<PricingCards> createState() => _PricingCardsState();
}

class _PricingCardsState extends State<PricingCards> {
  bool _annual = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          if (!widget.compact) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(l10n.pricingBilling, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(width: 12),
                Switch(
                  value: _annual,
                  activeTrackColor: kPrimaryGreen.withValues(alpha: 0.5),
                  thumbColor: WidgetStateProperty.all(kPrimaryGreen),
                  onChanged: (v) => setState(() => _annual = v),
                ),
                Text(
                  _annual ? l10n.yearlyWithDiscount : l10n.monthly,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
          LayoutBuilder(
            builder: (context, c) {
              final w = c.maxWidth;
              final stack = w < 900;
              final plans = [
                _Plan(
                  planId: 'starter',
                  name: l10n.planStarter,
                  monthly: 79,
                  annualFactor: 0.8,
                  annual: _annual,
                  border: kBorderSubtle,
                  badge: null,
                  highlights: [
                    l10n.planStarterF1,
                    l10n.planStarterF2,
                    l10n.planStarterF3,
                    l10n.planStarterF4,
                    l10n.planStarterF5,
                    l10n.planStarterF6,
                    l10n.planStarterF7,
                    l10n.planStarterF8,
                  ],
                  cta: l10n.planCtaStartTrial,
                  onCta: () => context.go('/auth/register'),
                  l10n: l10n,
                ),
                _Plan(
                  planId: 'growth',
                  name: l10n.planGrowth,
                  monthly: 299,
                  annualFactor: 0.8,
                  annual: _annual,
                  border: kPrimaryGreen,
                  glow: true,
                  badge: l10n.planBadgePopular,
                  highlights: [
                    l10n.planGrowthF1,
                    l10n.planGrowthF2,
                    l10n.planGrowthF3,
                    l10n.planGrowthF4,
                    l10n.planGrowthF5,
                    l10n.planGrowthF6,
                    l10n.planGrowthF7,
                    l10n.planGrowthF8,
                    l10n.planGrowthF9,
                    l10n.planGrowthF10,
                  ],
                  cta: l10n.planCtaStartTrial,
                  onCta: () => context.go('/auth/register'),
                  l10n: AppLocalizations.of(context),
                ),
                _Plan(
                  planId: 'partner',
                  name: l10n.planPartner,
                  monthly: 999,
                  annualFactor: 0.8,
                  annual: _annual,
                  border: const Color(0xFFF59E0B),
                  badge: l10n.planBadgePartner,
                  highlights: [
                    l10n.planPartnerF1,
                    l10n.planPartnerF2,
                    l10n.planPartnerF3,
                    l10n.planPartnerF4,
                    l10n.planPartnerF5,
                    l10n.planPartnerF6,
                    l10n.planPartnerF7,
                    l10n.planPartnerF8,
                  ],
                  cta: l10n.planCtaContactSales,
                  onCta: () {},
                  l10n: l10n,
                ),
              ];
              if (stack) {
                return Column(
                  children: [
                    for (final p in plans) ...[p, const SizedBox(height: 16)],
                  ],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: plans
                    .map(
                      (p) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: p,
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _Plan extends StatelessWidget {
  const _Plan({
    required this.planId,
    required this.name,
    required this.monthly,
    required this.annual,
    required this.annualFactor,
    required this.border,
    required this.highlights,
    required this.cta,
    required this.onCta,
    required this.l10n,
    this.badge,
    this.glow = false,
  });

  final String planId;
  final String name;
  final double monthly;
  final bool annual;
  final double annualFactor;
  final Color border;
  final List<String> highlights;
  final String cta;
  final VoidCallback onCta;
  final AppLocalizations l10n;
  final String? badge;
  final bool glow;

  @override
  Widget build(BuildContext context) {
    final price = annual ? monthly * annualFactor : monthly;
    final suffix = annual ? l10n.perMonthAnnual : l10n.perMonth;
    return VerdantCard(
      glow: glow,
      borderColor: border,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (badge != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                gradient: kPrimaryGradient,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                badge!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: kDeepForest,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
          if (badge != null) const SizedBox(height: 12),
          Text(name, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8),
          Text(
            '${formatCurrencyEuro(price)}$suffix',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          for (final line in highlights)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                line,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: line.startsWith('✗') ? kTextMuted : kTextSecondary,
                    ),
              ),
            ),
          const SizedBox(height: 16),
          VerdantButton(
            label: cta,
            onPressed: onCta,
            variant: planId == 'partner'
                ? VerdantButtonVariant.ghost
                : VerdantButtonVariant.primary,
            expand: true,
          ),
        ],
      ),
    );
  }
}
