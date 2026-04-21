import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:verdant/l10n/app_localizations.dart';

import '../../shared/widgets/legal_footer.dart';
import 'landing_design_tokens.dart';
import 'widgets/public_marketing_app_bar.dart';

/// Initial scroll target when opening the landing via deep link (`/how-it-works`, etc.).
enum LandingScrollTarget {
  none,
  howItWorks,
  features,
  pricing,
}

class LandingPage extends StatefulWidget {
  const LandingPage({
    super.key,
    this.scrollTarget = LandingScrollTarget.none,
  });

  /// Scroll to the matching section after the first layout.
  final LandingScrollTarget scrollTarget;

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final _howItWorksKey = GlobalKey();
  final _featuresSectionKey = GlobalKey();
  final _pricingSectionKey = GlobalKey();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (widget.scrollTarget != LandingScrollTarget.none) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _scrollForTarget(widget.scrollTarget));
    }
  }

  @override
  void didUpdateWidget(LandingPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.scrollTarget != widget.scrollTarget &&
        widget.scrollTarget != LandingScrollTarget.none) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _scrollForTarget(widget.scrollTarget));
    }
  }

  void _scrollForTarget(LandingScrollTarget target) {
    final GlobalKey key = switch (target) {
      LandingScrollTarget.howItWorks => _howItWorksKey,
      LandingScrollTarget.features => _featuresSectionKey,
      LandingScrollTarget.pricing => _pricingSectionKey,
      LandingScrollTarget.none => _featuresSectionKey,
    };
    final ctx = key.currentContext;
    if (!mounted || ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeOutCubic,
      alignment: 0.12,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  PublicNavHighlight get _navHighlight => switch (widget.scrollTarget) {
        LandingScrollTarget.howItWorks => PublicNavHighlight.howItWorks,
        LandingScrollTarget.features => PublicNavHighlight.features,
        LandingScrollTarget.pricing => PublicNavHighlight.pricing,
        LandingScrollTarget.none => PublicNavHighlight.none,
      };

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: LandingDesign.themeOverlay(context),
      child: Scaffold(
        backgroundColor: LandingDesign.background,
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            PublicMarketingSliverAppBar(highlight: _navHighlight),
            const SliverToBoxAdapter(
              child: _Section(
                color: LandingDesign.primary,
                child: _LandingHero(),
              ),
            ),
            const SliverToBoxAdapter(child: _SocialProofGrid()),
            SliverToBoxAdapter(
              key: _howItWorksKey,
              child: const _ThreeStepsSection(),
            ),
            const SliverToBoxAdapter(child: _ComparisonTableSection()),
            SliverToBoxAdapter(
              key: _featuresSectionKey,
              child: const _FeaturesSection(),
            ),
            const SliverToBoxAdapter(child: _TimelineSection()),
            const SliverToBoxAdapter(child: _TestimonialsSection()),
            SliverToBoxAdapter(
              key: _pricingSectionKey,
              child: const _PricingSection(),
            ),
            const SliverToBoxAdapter(child: _FaqSection()),
            const SliverToBoxAdapter(child: _FinalCta()),
            const SliverToBoxAdapter(child: LegalFooter()),
          ],
        ),
      ),
    );
  }
}

class _LandingHero extends StatelessWidget {
  const _LandingHero();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 980),
        child: Stack(
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.topRight,
                    radius: 1.2,
                    colors: [
                      Colors.white.withValues(alpha: 0.12),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: LandingDesign.secondary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        l10n.heroBadgeCsrd,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: LandingDesign.secondary,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                Text(
                  l10n.pubLandingHeroHeadline,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: LandingDesign.onPrimary,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                ),
                const SizedBox(height: 20),
                Text(
                  l10n.pubLandingHeroSub,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: LandingDesign.onPrimaryMuted,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                ),
                const SizedBox(height: 28),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    FilledButton(
                      onPressed: () => context.go('/auth/register'),
                      style: FilledButton.styleFrom(
                        backgroundColor: LandingDesign.secondary,
                        foregroundColor: LandingDesign.ctaOnSecondary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 18,
                        ),
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(l10n.pubLandingHeroCtaFree),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => context.go('/features'),
                      icon: const Icon(Icons.play_circle_outline),
                      label: Text(l10n.pubLandingHeroCtaDemo),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: LandingDesign.onPrimary,
                        side: BorderSide(
                          color: Colors.white.withValues(alpha: 0.35),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 18,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: LandingDesign.destructive,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.warning_amber_rounded,
                        color: LandingDesign.onPrimary,
                        size: 26,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          l10n.pubLandingHeroWarning,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: LandingDesign.onPrimary,
                                    fontWeight: FontWeight.w600,
                                    height: 1.45,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.child, required this.color});
  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: color,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 84),
      child: child,
    );
  }
}

class _SocialProofGrid extends StatelessWidget {
  const _SocialProofGrid();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final items = <(IconData, String, String)>[
      (
        Icons.description_outlined,
        l10n.pubLandingSocial1Title,
        l10n.pubLandingSocial1Body,
      ),
      (
        Icons.help_outline,
        l10n.pubLandingSocial2Title,
        l10n.pubLandingSocial2Body,
      ),
      (
        Icons.table_view_outlined,
        l10n.pubLandingSocial3Title,
        l10n.pubLandingSocial3Body,
      ),
      (
        Icons.map_outlined,
        l10n.pubLandingSocial4Title,
        l10n.pubLandingSocial4Body,
      ),
    ];
    return _Section(
      color: LandingDesign.muted,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Column(
            children: [
              Text(
                l10n.pubLandingSocialTitle,
                style: Theme.of(context).textTheme.displaySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                l10n.pubLandingSocialSubtitle,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: LandingDesign.mutedForeground,
                      fontWeight: FontWeight.w400,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: items
                    .map(
                      (i) => SizedBox(
                        width: 540,
                        child: Container(
                          padding: const EdgeInsets.all(22),
                          decoration: BoxDecoration(
                            color: LandingDesign.background,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: LandingDesign.border),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(i.$1, color: LandingDesign.primary),
                              const SizedBox(height: 12),
                              Text(
                                i.$2,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                i.$3,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: LandingDesign.mutedForeground,
                                      height: 1.5,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FaqSection extends StatelessWidget {
  const _FaqSection();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final items = [
      (l10n.pubLandingFaqQ1, l10n.pubLandingFaqA1),
      (l10n.pubLandingFaqQ2, l10n.pubLandingFaqA2),
      (l10n.pubLandingFaqQ3, l10n.pubLandingFaqA3),
      (l10n.pubLandingFaqQ4, l10n.pubLandingFaqA4),
    ];
    return _Section(
      color: LandingDesign.background,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 820),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.faqTitle,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 16),
              ...items.map(
                (e) => Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: LandingDesign.border),
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    title: Text(
                      e.$1,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Text(
                            e.$2,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FinalCta extends StatelessWidget {
  const _FinalCta();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return _Section(
      color: LandingDesign.primary,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 980),
          child: Column(
            children: [
              Text(
                l10n.pubLandingFinalTitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: LandingDesign.onPrimary,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 14),
              Text(
                l10n.pubLandingFinalSub,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: LandingDesign.onPrimaryMuted,
                    ),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () => context.go('/auth/register'),
                style: FilledButton.styleFrom(
                  backgroundColor: LandingDesign.secondary,
                  foregroundColor: LandingDesign.ctaOnSecondary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 18,
                  ),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(l10n.pubLandingFinalCta),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ThreeStepsSection extends StatelessWidget {
  const _ThreeStepsSection();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final steps = [
      ('1', l10n.pubLandingStep1Title, l10n.pubLandingStep1Body),
      ('2', l10n.pubLandingStep2Title, l10n.pubLandingStep2Body),
      ('3', l10n.pubLandingStep3Title, l10n.pubLandingStep3Body),
    ];
    return _Section(
      color: LandingDesign.background,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Column(
            children: [
              Text(
                l10n.pubLandingStepsTitle,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 36),
              Wrap(
                spacing: 18,
                runSpacing: 18,
                alignment: WrapAlignment.center,
                children: steps
                    .map(
                      (s) => SizedBox(
                        width: 340,
                        child: Column(
                          children: [
                            Container(
                              width: 86,
                              height: 86,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: LandingDesign.primary,
                                border: Border.all(
                                  color: LandingDesign.background,
                                  width: 8,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black
                                        .withValues(alpha: 0.06),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  s.$1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
                                      ?.copyWith(
                                        color: LandingDesign.onPrimary,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),
                            Text(
                              s.$2,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              s.$3,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: LandingDesign.mutedForeground,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ComparisonTableSection extends StatelessWidget {
  const _ComparisonTableSection();

  static DataCell _mutedCell(String text) {
    return DataCell(
      Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: LandingDesign.mutedForeground,
        ),
      ),
    );
  }

  static DataCell _highlightCell(String text) {
    return DataCell(
      Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          color: LandingDesign.primary,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return _Section(
      color: LandingDesign.primary,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Container(
            decoration: BoxDecoration(
              color: LandingDesign.background,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: 40,
                  offset: const Offset(0, 16),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: const WidgetStatePropertyAll(
                  LandingDesign.muted,
                ),
                dataRowColor: const WidgetStatePropertyAll(
                  LandingDesign.background,
                ),
                border: TableBorder.all(
                  color: LandingDesign.border,
                ),
                columns: [
                  DataColumn(label: Text(l10n.pubCompareColFeature)),
                  DataColumn(label: Text(l10n.pubCompareColConsultant)),
                  DataColumn(label: Text(l10n.pubCompareColExcel)),
                  DataColumn(label: Text(l10n.brandName)),
                ],
                rows: [
                  DataRow(
                    cells: [
                      _mutedCell(l10n.pubCompareRowCost),
                      DataCell(Text(l10n.pubCompareCostConsultant)),
                      DataCell(Text(l10n.pubCompareCostExcel)),
                      _highlightCell(l10n.pubCompareCostVerdant),
                    ],
                  ),
                  DataRow(
                    cells: [
                      _mutedCell(l10n.pubCompareRowTime),
                      DataCell(Text(l10n.pubCompareTimeConsultant)),
                      DataCell(
                        Text(
                          l10n.pubCompareTimeExcelNever,
                          style: const TextStyle(
                            color: LandingDesign.destructive,
                          ),
                        ),
                      ),
                      _highlightCell(l10n.pubCompareTimeVerdant),
                    ],
                  ),
                  DataRow(
                    cells: [
                      _mutedCell(l10n.pubCompareRowAudit),
                      DataCell(Text(l10n.pubCompareAuditDepends)),
                      DataCell(
                        Text(
                          l10n.pubCompareAuditNo,
                          style: const TextStyle(
                            color: LandingDesign.destructive,
                          ),
                        ),
                      ),
                      _highlightCell(l10n.pubCompareAuditYes),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FeaturesSection extends StatelessWidget {
  const _FeaturesSection();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final items = <(IconData, String)>[
      (Icons.eco_outlined, l10n.pubFeatureCarbon),
      (Icons.menu_book_outlined, l10n.pubFeatureStandards),
      (Icons.description_outlined, l10n.pubFeaturePdf),
      (Icons.account_balance_outlined, l10n.pubFeatureBanking),
      (Icons.hub_outlined, l10n.pubFeatureSupplyChain),
      (Icons.notifications_active_outlined, l10n.pubFeatureAlerts),
    ];
    return _Section(
      color: LandingDesign.muted,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Column(
            children: [
              Text(
                l10n.pubFeaturesGridTitle,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 30),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: items
                    .map(
                      (i) => SizedBox(
                        width: 350,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: LandingDesign.background,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: LandingDesign.border),
                          ),
                          child: Row(
                            children: [
                              Icon(i.$1, color: LandingDesign.primary),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  i.$2,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimelineSection extends StatelessWidget {
  const _TimelineSection();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final rows = [
      (l10n.pubTimeline1Label, l10n.pubTimeline1Body),
      (l10n.pubTimeline2Label, l10n.pubTimeline2Body),
      (l10n.pubTimeline3Label, l10n.pubTimeline3Body),
      (l10n.pubTimeline4Label, l10n.pubTimeline4Body),
    ];
    return _Section(
      color: LandingDesign.background,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 920),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.pubTimelineTitle,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 24),
              ...rows.map(
                (r) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: LandingDesign.border),
                      borderRadius: BorderRadius.circular(12),
                      color: LandingDesign.background,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.circle,
                          size: 12,
                          color: LandingDesign.primary,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text('${r.$1}: ${r.$2}'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TestimonialsSection extends StatelessWidget {
  const _TestimonialsSection();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final entries = [
      (
        l10n.pubTestimonial1Name,
        l10n.pubTestimonial1Role,
        l10n.pubTestimonial1Quote,
      ),
      (
        l10n.pubTestimonial2Name,
        l10n.pubTestimonial2Role,
        l10n.pubTestimonial2Quote,
      ),
      (
        l10n.pubTestimonial3Name,
        l10n.pubTestimonial3Role,
        l10n.pubTestimonial3Quote,
      ),
    ];
    return _Section(
      color: LandingDesign.muted,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: entries
                .map(
                  (e) => SizedBox(
                    width: 350,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: LandingDesign.background,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: LandingDesign.border),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.star, color: LandingDesign.secondary),
                              Icon(Icons.star, color: LandingDesign.secondary),
                              Icon(Icons.star, color: LandingDesign.secondary),
                              Icon(Icons.star, color: LandingDesign.secondary),
                              Icon(Icons.star, color: LandingDesign.secondary),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text('"${e.$3}"'),
                          const SizedBox(height: 12),
                          Text(
                            e.$1,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            e.$2,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color: LandingDesign.mutedForeground,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

enum _LandingPlanCta { filledTrial, outlinedTrial, contactSales }

class _LandingPlanTier {
  const _LandingPlanTier({
    required this.name,
    required this.price,
    required this.bullets,
    required this.isFeatured,
    required this.cta,
  });

  final String name;
  final String price;
  final List<String> bullets;
  final bool isFeatured;
  final _LandingPlanCta cta;
}

class _PricingSection extends StatelessWidget {
  const _PricingSection();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final plans = [
      _LandingPlanTier(
        name: l10n.pubLandingPlanStarterName,
        price: '99',
        bullets: [
          l10n.pubLandingPlanStarterB1,
          l10n.pubLandingPlanStarterB2,
          l10n.pubLandingPlanStarterB3,
        ],
        isFeatured: false,
        cta: _LandingPlanCta.outlinedTrial,
      ),
      _LandingPlanTier(
        name: l10n.pubLandingPlanBusinessName,
        price: '249',
        bullets: [
          l10n.pubLandingPlanBusinessB1,
          l10n.pubLandingPlanBusinessB2,
          l10n.pubLandingPlanBusinessB3,
        ],
        isFeatured: true,
        cta: _LandingPlanCta.filledTrial,
      ),
      _LandingPlanTier(
        name: l10n.pubLandingPlanEnterpriseName,
        price: '599',
        bullets: [
          l10n.pubLandingPlanEnterpriseB1,
          l10n.pubLandingPlanEnterpriseB2,
          l10n.pubLandingPlanEnterpriseB3,
        ],
        isFeatured: false,
        cta: _LandingPlanCta.contactSales,
      ),
    ];
    return _Section(
      color: LandingDesign.muted,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: plans
                .map(
                  (p) => SizedBox(
                    width: 350,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: LandingDesign.background,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: p.isFeatured
                              ? LandingDesign.primary
                              : LandingDesign.border,
                          width: p.isFeatured ? 2 : 1,
                        ),
                        boxShadow: p.isFeatured
                            ? [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.08),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ]
                            : null,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            p.name,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '€${p.price}${l10n.pubLandingPricingPerMonthSuffix}',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 10),
                          ...p.bullets.map(
                            (f) => Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.check_circle_outline,
                                    size: 18,
                                    color: LandingDesign.primary,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(child: Text(f)),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: switch (p.cta) {
                              _LandingPlanCta.filledTrial => FilledButton(
                                  onPressed: () =>
                                      context.go('/auth/register'),
                                  style: FilledButton.styleFrom(
                                    backgroundColor: LandingDesign.primary,
                                    foregroundColor: LandingDesign.onPrimary,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(l10n.pricingBananiCtaTrial),
                                ),
                              _LandingPlanCta.outlinedTrial => OutlinedButton(
                                  onPressed: () =>
                                      context.go('/auth/register'),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: LandingDesign.primary,
                                    side: const BorderSide(
                                      color: LandingDesign.primary,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(l10n.pricingBananiCtaTrial),
                                ),
                              _LandingPlanCta.contactSales => OutlinedButton(
                                  onPressed: () => _launchSalesMail(l10n),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: LandingDesign.primary,
                                    side: const BorderSide(
                                      color: LandingDesign.primary,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(l10n.planCtaContactSales),
                                ),
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  static Future<void> _launchSalesMail(AppLocalizations l10n) async {
    final uri = Uri(
      scheme: 'mailto',
      path: 'sales@marconisoftware.com',
      queryParameters: {'subject': l10n.salesMailSubject},
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
