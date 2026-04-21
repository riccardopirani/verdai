import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:verdant/l10n/app_localizations.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/responsive.dart';
import '../../../shared/widgets/status_badge.dart';
import '../../../shared/widgets/verdant_button.dart';
import '../../../shared/widgets/verdant_card.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _float;

  @override
  void initState() {
    super.initState();
    _float = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _float.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final mobile = Responsive.isMobile(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: Flex(
        direction: mobile ? Axis.vertical : Axis.horizontal,
        crossAxisAlignment:
            mobile ? CrossAxisAlignment.stretch : CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: mobile ? 0 : 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Badge(text: l10n.heroBadgeCsrd),
                const SizedBox(height: 20),
                Text(
                  l10n.heroHeadline,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.heroSub,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: kTextMuted,
                        fontSize: 18,
                      ),
                ),
                const SizedBox(height: 28),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    VerdantButton(
                      label: l10n.heroCtaFree,
                      onPressed: () => context.go('/auth/register'),
                    ),
                    VerdantButton(
                      label: l10n.heroCtaDemo,
                      variant: VerdantButtonVariant.ghost,
                      onPressed: () => context.go('/features'),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                _SocialProofRow(text: l10n.heroSocialProof),
              ],
            ),
          ),
          if (!mobile) const SizedBox(width: 48),
          Expanded(
            flex: mobile ? 0 : 5,
            child: Padding(
              padding: EdgeInsets.only(top: mobile ? 40 : 0),
              child: AnimatedBuilder(
                animation: _float,
                builder: (context, child) {
                  final t = _float.value;
                  final dy = math.sin(t * math.pi) * 8;
                  return Transform.translate(
                    offset: Offset(0, dy),
                    child: child,
                  );
                },
                child: _HeroMockup(l10n: l10n),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: kSurfaceCard,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: kPrimaryGreen.withValues(alpha: 0.6)),
        boxShadow: [
          BoxShadow(
            color: kPrimaryGreen.withValues(alpha: 0.25),
            blurRadius: 16,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.verified, color: kPrimaryGreen, size: 18),
          const SizedBox(width: 8),
          Text(
            text,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ],
      ),
    );
  }
}

class _SocialProofRow extends StatelessWidget {
  const _SocialProofRow({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    const initials = ['M', 'L', 'G', 'S', 'P'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            for (var i = 0; i < initials.length; i++)
              Align(
                widthFactor: i == 0 ? 1 : 0.75,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Color.lerp(kPrimaryGreen, kDeepForest, i / 5)!,
                  child: Text(
                    initials[i],
                    style: const TextStyle(
                      color: kDeepForest,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class _HeroMockup extends StatelessWidget {
  const _HeroMockup({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return VerdantCard(
      glow: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.heroEsgScore, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            l10n.heroScore(78, 100),
            style: verdantMono(28, weight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 3),
                      FlSpot(1, 4),
                      FlSpot(2, 3.5),
                      FlSpot(3, 5),
                      FlSpot(4, 4),
                      FlSpot(5, 6),
                    ],
                    color: kPrimaryGreen,
                    barWidth: 3,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: kPrimaryGreen.withValues(alpha: 0.12),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              StatusBadge(label: l10n.heroScopeCsrd, tone: BadgeTone.success),
              StatusBadge(label: l10n.heroScope1, tone: BadgeTone.success),
              StatusBadge(label: l10n.heroScope2, tone: BadgeTone.success),
            ],
          ),
        ],
      ),
    );
  }
}
