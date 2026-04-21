import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:verdant/l10n/app_localizations.dart';

import '../../core/theme/colors.dart';
import '../../core/theme/typography.dart';
import '../../core/utils/responsive.dart';
import '../../features/auth/auth_provider.dart';
import '../../shared/widgets/status_badge.dart';
import '../../shared/widgets/verdant_card.dart';
import 'dashboard_provider.dart';
import 'widgets/compliance_status.dart';
import 'widgets/emissions_chart.dart';
import 'widgets/esg_score_card.dart';
import 'widgets/quick_actions.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final kpiAsync = ref.watch(dashboardKpiProvider);
    final mobile = Responsive.isMobile(context);
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      backgroundColor: kSurface,
      body: kpiAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => Center(child: Text(l10n.dashLoadingError)),
        data: (k) {
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
                sliver: SliverToBoxAdapter(
                  child: _Header(l10n: l10n, email: user?.email),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(24),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    if (mobile) ...[
                      EsgScoreCard(score: k.esgScore),
                      const SizedBox(height: 16),
                      _Co2Card(l10n: l10n, tons: k.co2Tons),
                      const SizedBox(height: 16),
                      ComplianceStatusCard(progress: k.complianceProgress),
                      const SizedBox(height: 16),
                      _ReportQuotaCard(
                        l10n: l10n,
                        used: k.reportsUsed,
                        limit: k.reportsLimit,
                      ),
                    ] else
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: EsgScoreCard(score: k.esgScore)),
                          const SizedBox(width: 16),
                          Expanded(child: _Co2Card(l10n: l10n, tons: k.co2Tons)),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ComplianceStatusCard(
                              progress: k.complianceProgress,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _ReportQuotaCard(
                              l10n: l10n,
                              used: k.reportsUsed,
                              limit: k.reportsLimit,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 24),
                    if (mobile) ...[
                      const EmissionsChart(),
                      const SizedBox(height: 16),
                      _CategoryDonut(l10n: l10n),
                    ] else
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(flex: 6, child: EmissionsChart()),
                          const SizedBox(width: 16),
                          Expanded(flex: 4, child: _CategoryDonut(l10n: l10n)),
                        ],
                      ),
                    const SizedBox(height: 24),
                    if (mobile) ...[
                      _RecentReports(l10n: l10n),
                      const SizedBox(height: 16),
                      _AlertsPreview(l10n: l10n),
                    ] else
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _RecentReports(l10n: l10n)),
                          const SizedBox(width: 16),
                          Expanded(child: _AlertsPreview(l10n: l10n)),
                        ],
                      ),
                    const SizedBox(height: 24),
                    const QuickActions(),
                  ]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.l10n, this.email});

  final AppLocalizations l10n;
  final String? email;

  @override
  Widget build(BuildContext context) {
    final initial = (email?.isNotEmpty == true)
        ? email![0].toUpperCase()
        : l10n.userFallback;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.dashTitle,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                l10n.dashBreadcrumb,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        SizedBox(
          width: 200,
          child: TextField(
            decoration: InputDecoration(
              hintText: l10n.searchHint,
              prefixIcon: const Icon(Icons.search, color: kTextMuted),
              isDense: true,
              filled: true,
              fillColor: kSurfaceCard,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              onPressed: () => context.go('/compliance'),
              icon: const Icon(Icons.notifications_outlined),
            ),
            const Positioned(
              right: 8,
              top: 8,
              child: _NotifBadge(count: '2'),
            ),
          ],
        ),
        const SizedBox(width: 8),
        CircleAvatar(
          backgroundColor: kPrimaryGreen.withValues(alpha: 0.3),
          child: Text(
            initial,
            style: const TextStyle(color: kTextPrimary),
          ),
        ),
      ],
    );
  }
}

class _NotifBadge extends StatelessWidget {
  const _NotifBadge({required this.count});
  final String count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        color: kError,
        shape: BoxShape.circle,
      ),
      constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
      child: Text(
        count,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 10, color: kTextPrimary),
      ),
    );
  }
}

class _Co2Card extends StatelessWidget {
  const _Co2Card({required this.l10n, required this.tons});

  final AppLocalizations l10n;
  final double tons;

  @override
  Widget build(BuildContext context) {
    return VerdantCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.eco, color: kLeafAccent),
              const SizedBox(width: 8),
              Text(l10n.dashCo2Title,
                  style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            l10n.dashCo2TonsFmt(tons.toStringAsFixed(1)),
            style: verdantMono(24, weight: FontWeight.w600),
          ),
          Text(
            l10n.dashCo2Delta,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: kSuccess),
          ),
        ],
      ),
    );
  }
}

class _ReportQuotaCard extends StatelessWidget {
  const _ReportQuotaCard({
    required this.l10n,
    required this.used,
    required this.limit,
  });

  final AppLocalizations l10n;
  final int used;
  final int limit;

  @override
  Widget build(BuildContext context) {
    final left = (limit - used).clamp(0, limit);
    return VerdantCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.dashReportsTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            '$used / $limit',
            style: verdantMono(24, weight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: limit == 0 ? 0 : used / limit,
            color: kPrimaryGreen,
            backgroundColor: kBorderSubtle,
          ),
          const SizedBox(height: 8),
          Text(
            l10n.dashReportsLeft('$left'),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _CategoryDonut extends StatelessWidget {
  const _CategoryDonut({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return VerdantCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.dashBreakdownTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 48,
                sections: [
                  PieChartSectionData(
                    color: kPrimaryGreen,
                    value: 45,
                    title: '45%',
                    radius: 50,
                    titleStyle:
                        const TextStyle(color: kTextPrimary, fontSize: 11),
                  ),
                  PieChartSectionData(
                    color: kLeafAccent,
                    value: 28,
                    title: '28%',
                    radius: 50,
                    titleStyle:
                        const TextStyle(color: kDeepForest, fontSize: 11),
                  ),
                  PieChartSectionData(
                    color: kInfo,
                    value: 18,
                    title: '18%',
                    radius: 50,
                    titleStyle:
                        const TextStyle(color: kTextPrimary, fontSize: 11),
                  ),
                  PieChartSectionData(
                    color: kWarning,
                    value: 9,
                    title: '9%',
                    radius: 50,
                    titleStyle:
                        const TextStyle(color: kDeepForest, fontSize: 11),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              _LegDot(color: kPrimaryGreen, label: l10n.catEnergy),
              _LegDot(color: kLeafAccent, label: l10n.catTransport),
              _LegDot(color: kInfo, label: l10n.catSuppliers),
              _LegDot(color: kWarning, label: l10n.catOther),
            ],
          ),
        ],
      ),
    );
  }
}

class _LegDot extends StatelessWidget {
  const _LegDot({required this.color, required this.label});
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}

class _RecentReports extends StatelessWidget {
  const _RecentReports({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return VerdantCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.dashRecentReports,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              TextButton(
                onPressed: () => context.go('/reports'),
                child: Text(l10n.dashSeeAll),
              ),
            ],
          ),
          _ReportRow(
            l10n: l10n,
            title: l10n.reportRow1Title,
            standard: 'CSRD',
            status: 'draft',
          ),
          const Divider(color: kBorderSubtle),
          _ReportRow(
            l10n: l10n,
            title: l10n.reportRow2Title,
            standard: 'ISSB',
            status: 'in_review',
          ),
          const Divider(color: kBorderSubtle),
          _ReportRow(
            l10n: l10n,
            title: l10n.reportRow3Title,
            standard: 'CDP',
            status: 'published',
          ),
        ],
      ),
    );
  }
}

class _ReportRow extends StatelessWidget {
  const _ReportRow({
    required this.l10n,
    required this.title,
    required this.standard,
    required this.status,
  });

  final AppLocalizations l10n;
  final String title;
  final String standard;
  final String status;

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
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      subtitle: Text(standard),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          StatusBadge(label: statusLabel, tone: tone),
          IconButton(onPressed: () {}, icon: const Icon(Icons.download_outlined)),
        ],
      ),
    );
  }
}

class _AlertsPreview extends StatelessWidget {
  const _AlertsPreview({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return VerdantCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.dashAlerts,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              TextButton(
                onPressed: () => context.go('/compliance'),
                child: Text(l10n.dashSeeAllArrow),
              ),
            ],
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.warning_amber_rounded, color: kError),
            title: Text(l10n.alertRow1Title),
            subtitle: Text(l10n.alertRow1Sub),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.info_outline, color: kWarning),
            title: Text(l10n.alertRow2Title),
            subtitle: Text(l10n.alertRow2Sub),
          ),
        ],
      ),
    );
  }
}
