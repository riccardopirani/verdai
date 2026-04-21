import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:verdant/l10n/app_localizations.dart';

import '../../core/utils/responsive.dart';
import 'banani_dashboard_tokens.dart';
import 'dashboard_provider.dart';
import 'widgets/quick_actions.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  static String _esgGrade(double score) {
    if (score >= 90) return 'A+';
    if (score >= 85) return 'A';
    if (score >= 78) return 'A-';
    if (score >= 72) return 'B+';
    if (score >= 65) return 'B';
    if (score >= 58) return 'B-';
    if (score >= 50) return 'C+';
    if (score >= 42) return 'C';
    return 'C-';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final kpiAsync = ref.watch(dashboardKpiProvider);
    final mobile = Responsive.isMobile(context);
    final months = List.generate(12, (i) => DateFormat.MMM(Localizations.localeOf(context).toString()).format(DateTime(2024, i + 1)));

    return ColoredBox(
      color: BananiDash.background,
      child: kpiAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: BananiDash.primary)),
        error: (_, __) => Center(child: Text(l10n.dashLoadingError, style: const TextStyle(color: BananiDash.foreground))),
        data: (k) {
          final co2Fmt = NumberFormat.decimalPattern(Localizations.localeOf(context).toString());
          final reportsLeft = (k.reportsLimit - k.reportsUsed).clamp(0, k.reportsLimit);

          final kpiRow = _KpiFourUp(
            mobile: mobile,
            children: [
              _BananiKpiCard(
                label: l10n.dashEsgCardTitle,
                value: _esgGrade(k.esgScore),
                icon: Icons.star_outline,
                iconBg: BananiDash.primaryMuted(0.1),
                iconColor: BananiDash.primary,
                footer: Row(
                  children: [
                    const Icon(Icons.trending_up, size: 14, color: BananiDash.primary),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        l10n.dashEsgDelta,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: BananiDash.primary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              _BananiKpiCard(
                label: l10n.dashCo2Title,
                value: co2Fmt.format(k.co2Tons.round()),
                valueSuffix: ' t',
                icon: Icons.cloud_outlined,
                iconBg: BananiDash.secondaryMuted(0.1),
                iconColor: BananiDash.secondary,
                footer: Row(
                  children: [
                    const Icon(Icons.trending_down, size: 14, color: BananiDash.danger),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        l10n.dashCo2Delta,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: BananiDash.danger,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              _BananiKpiCard(
                label: l10n.complianceTitle,
                value: '${(k.complianceProgress * 100).round()}%',
                icon: Icons.verified_user_outlined,
                iconBg: BananiDash.primaryMuted(0.1),
                iconColor: BananiDash.primary,
                footer: Row(
                  children: [
                    const Icon(Icons.trending_up, size: 14, color: BananiDash.primary),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        l10n.reportDataCompleteness,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: BananiDash.primary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              _BananiKpiCard(
                label: l10n.dashReportsTitle,
                value: '$reportsLeft',
                valueSuffix: ' / ${k.reportsLimit}',
                icon: Icons.description_outlined,
                iconBg: BananiDash.warningMuted(0.1),
                iconColor: BananiDash.warning,
              ),
            ],
          );

          final chartAndScopes = mobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _EmissionsBarsCard(l10n: l10n, months: months),
                    const SizedBox(height: 24),
                    _ScopesCard(l10n: l10n),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 2, child: _EmissionsBarsCard(l10n: l10n, months: months)),
                    const SizedBox(width: 24),
                    Expanded(child: _ScopesCard(l10n: l10n)),
                  ],
                );

          final lower = mobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _RecentAndAlertsColumn(l10n: l10n),
                    const SizedBox(height: 24),
                    _QuickActionsPanel(l10n: l10n),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 2, child: _RecentAndAlertsColumn(l10n: l10n)),
                    const SizedBox(width: 24),
                    Expanded(child: _QuickActionsPanel(l10n: l10n)),
                  ],
                );

          return SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                kpiRow,
                const SizedBox(height: 24),
                chartAndScopes,
                const SizedBox(height: 24),
                lower,
              ],
            ),
          );
        },
      ),
    );
  }
}

class _KpiFourUp extends StatelessWidget {
  const _KpiFourUp({required this.mobile, required this.children});

  final bool mobile;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    if (mobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0) const SizedBox(height: 16),
            children[i],
          ],
        ],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < children.length; i++) ...[
          if (i > 0) const SizedBox(width: 24),
          Expanded(child: children[i]),
        ],
      ],
    );
  }
}

class _BananiKpiCard extends StatelessWidget {
  const _BananiKpiCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    this.valueSuffix = '',
    this.footer,
  });

  final String label;
  final String value;
  final String valueSuffix;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: BananiDash.surface,
        borderRadius: BorderRadius.circular(BananiDash.radiusLg),
        border: Border.all(color: BananiDash.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: BananiDash.mutedForeground,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(BananiDash.radiusMd),
                ),
                child: Icon(icon, size: 20, color: iconColor),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: BananiDash.foreground,
                ),
              ),
              if (valueSuffix.isNotEmpty)
                Text(
                  valueSuffix,
                  style: const TextStyle(
                    fontSize: 14,
                    color: BananiDash.mutedForeground,
                  ),
                ),
            ],
          ),
          if (footer != null) ...[
            const SizedBox(height: 8),
            footer!,
          ],
        ],
      ),
    );
  }
}

/// Stacked bar visualization (Banani-style); heights mirror export proportions.
class _EmissionsBarsCard extends StatelessWidget {
  const _EmissionsBarsCard({required this.l10n, required this.months});

  final AppLocalizations l10n;
  final List<String> months;

  static const _bars = <(double, double)>[
    (0.45, 0.30),
    (0.60, 0.45),
    (0.55, 0.40),
    (0.70, 0.55),
    (0.65, 0.50),
    (0.50, 0.35),
    (0.40, 0.25),
    (0.55, 0.40),
    (0.60, 0.45),
    (0.45, 0.30),
    (0.30, 0.15),
    (0.25, 0.10),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: BananiDash.surface,
        borderRadius: BorderRadius.circular(BananiDash.radiusLg),
        border: Border.all(color: BananiDash.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.navEmissions,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: BananiDash.foreground,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 256,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final h in _bars)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: _StackedBar(ghostFrac: h.$1, solidFrac: h.$2),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.only(top: 12),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: BananiDash.border)),
            ),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              spacing: 8,
              runSpacing: 4,
              children: [
                for (final m in months)
                  Text(
                    m,
                    style: const TextStyle(fontSize: 12, color: BananiDash.mutedForeground),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StackedBar extends StatelessWidget {
  const _StackedBar({required this.ghostFrac, required this.solidFrac});

  final double ghostFrac;
  final double solidFrac;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final h = c.maxHeight;
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(BananiDash.radiusSm)),
          child: ColoredBox(
            color: BananiDash.border,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: h * ghostFrac,
                    color: BananiDash.primaryMuted(0.4),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: h * solidFrac,
                    decoration: BoxDecoration(
                      color: BananiDash.primary,
                      boxShadow: BananiDash.primaryBarGlow,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ScopesCard extends StatelessWidget {
  const _ScopesCard({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: BananiDash.surface,
        borderRadius: BorderRadius.circular(BananiDash.radiusLg),
        border: Border.all(color: BananiDash.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.dashBreakdownTitle,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: BananiDash.foreground,
            ),
          ),
          const SizedBox(height: 24),
          _ScopeRow(title: l10n.scope1, share: '35%', ring: BananiDash.primary),
          const SizedBox(height: 24),
          _ScopeRow(title: l10n.scope2, share: '25%', ring: BananiDash.secondary),
          const SizedBox(height: 24),
          _ScopeRow(title: l10n.scope3, share: '40%', ring: BananiDash.warning),
        ],
      ),
    );
  }
}

class _ScopeRow extends StatelessWidget {
  const _ScopeRow({
    required this.title,
    required this.share,
    required this.ring,
  });

  final String title;
  final String share;
  final Color ring;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: ring, width: 4),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: BananiDash.foreground,
                ),
              ),
              Text(
                share,
                style: const TextStyle(fontSize: 12, color: BananiDash.mutedForeground),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RecentAndAlertsColumn extends StatelessWidget {
  const _RecentAndAlertsColumn({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.dashRecentReports,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: BananiDash.foreground,
          ),
        ),
        const SizedBox(height: 12),
        _ReportListTile(
          title: l10n.reportRow1Title,
          subtitle: l10n.stdCsrd,
          badge: l10n.statusPublished,
        ),
        const SizedBox(height: 12),
        _ReportListTile(
          title: l10n.reportRow2Title,
          subtitle: l10n.stdIssb,
          badge: l10n.statusPublished,
        ),
        const SizedBox(height: 32),
        Text(
          l10n.dashAlerts,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: BananiDash.foreground,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: BananiDash.warningMuted(0.05),
            borderRadius: BorderRadius.circular(BananiDash.radiusLg),
            border: Border.all(color: BananiDash.warning.withValues(alpha: 0.2)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.warning_amber_rounded, color: BananiDash.warning, size: 20),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.alertRow1Title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: BananiDash.onWarning,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.alertRow1Sub,
                      style: const TextStyle(fontSize: 12, color: BananiDash.mutedForeground),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: BananiDash.surface,
            borderRadius: BorderRadius.circular(BananiDash.radiusLg),
            border: Border.all(color: BananiDash.border),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.info_outline, color: BananiDash.secondary, size: 20),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.alertRow2Title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: BananiDash.foreground,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.alertRow2Sub,
                      style: const TextStyle(fontSize: 12, color: BananiDash.mutedForeground),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ReportListTile extends StatelessWidget {
  const _ReportListTile({
    required this.title,
    required this.subtitle,
    required this.badge,
  });

  final String title;
  final String subtitle;
  final String badge;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: BananiDash.surface,
        borderRadius: BorderRadius.circular(BananiDash.radiusLg),
        border: Border.all(color: BananiDash.border),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: BananiDash.muted,
              borderRadius: BorderRadius.circular(BananiDash.radiusMd),
            ),
            child: const Icon(Icons.description_outlined, color: BananiDash.mutedForeground),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: BananiDash.foreground,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12, color: BananiDash.mutedForeground),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: BananiDash.primaryMuted(0.1),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              badge,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: BananiDash.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionsPanel extends StatelessWidget {
  const _QuickActionsPanel({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.quickActionsTitle,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: BananiDash.foreground,
          ),
        ),
        const SizedBox(height: 16),
        const QuickActions(banani: true),
      ],
    );
  }
}
