import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:verdant/l10n/app_localizations.dart';

import '../../../core/theme/colors.dart';
import '../../../shared/widgets/status_badge.dart';
import '../../../shared/widgets/verdant_button.dart';
import '../../../shared/widgets/verdant_card.dart';
import '../../../shared/widgets/verdant_input.dart';

class SolutionTabsSection extends StatefulWidget {
  const SolutionTabsSection({super.key});

  @override
  State<SolutionTabsSection> createState() => _SolutionTabsSectionState();
}

class _SolutionTabsSectionState extends State<SolutionTabsSection> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final tabs = [
      l10n.solTabCo2,
      l10n.solTabReport,
      l10n.solTabAlerts,
      l10n.solTabIntegrate,
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.solutionTitle,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(tabs.length, (i) {
                final sel = i == _tab;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(tabs[i]),
                    selected: sel,
                    onSelected: (_) => setState(() => _tab = i),
                    selectedColor: kPrimaryGreen.withValues(alpha: 0.25),
                    backgroundColor: kSurfaceCard,
                    labelStyle: TextStyle(
                      color: sel ? kTextPrimary : kTextSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                    side: BorderSide(
                      color: sel ? kPrimaryGreen : kBorderSubtle,
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 24),
          AnimatedSwitcher(
            duration: 250.ms,
            child: KeyedSubtree(
              key: ValueKey(_tab),
              child: _tabBody(l10n),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabBody(AppLocalizations l10n) {
    switch (_tab) {
      case 0:
        return _Co2Tab(l10n: l10n);
      case 1:
        return _ReportTab(l10n: l10n);
      case 2:
        return _AlertsTab(l10n: l10n);
      default:
        return _IntegrationsTab(l10n: l10n);
    }
  }
}

class _Co2Tab extends StatelessWidget {
  const _Co2Tab({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return VerdantCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VerdantInput(
            label: l10n.solCo2Kwh,
            hint: l10n.solCo2KwhHint,
          ),
          const SizedBox(height: 12),
          VerdantInput(
            label: l10n.solCo2Diesel,
            hint: l10n.solCo2DieselHint,
          ),
          const SizedBox(height: 12),
          VerdantInput(
            label: l10n.solCo2Km,
            hint: l10n.solCo2KmHint,
          ),
          const SizedBox(height: 20),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 0.72),
            duration: 900.ms,
            builder: (context, v, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: v,
                      minHeight: 12,
                      color: kPrimaryGreen,
                      backgroundColor: kBorderSubtle,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l10n.solCo2Estimate('12.4'),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ReportTab extends StatelessWidget {
  const _ReportTab({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return VerdantCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.solReportPreviewTitle, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          Container(
            height: 160,
            decoration: BoxDecoration(
              color: kDeepForest,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: kBorderSubtle),
            ),
            child: Center(
              child: Text(
                l10n.solReportPreviewBody,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          const SizedBox(height: 16),
          VerdantButton(
            label: l10n.solReportExportDemo,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.snackDownloadSimulated)),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _AlertsTab extends StatelessWidget {
  const _AlertsTab({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return VerdantCard(
      child: Column(
        children: [
          _AlertRow(
            title: l10n.solAlert1,
            tone: BadgeTone.error,
            l10n: l10n,
          ),
          const Divider(color: kBorderSubtle),
          _AlertRow(
            title: l10n.solAlert2,
            tone: BadgeTone.warning,
            l10n: l10n,
          ),
          const Divider(color: kBorderSubtle),
          _AlertRow(
            title: l10n.solAlert3,
            tone: BadgeTone.success,
            l10n: l10n,
          ),
        ],
      ),
    );
  }
}

class _AlertRow extends StatelessWidget {
  const _AlertRow({
    required this.title,
    required this.tone,
    required this.l10n,
  });

  final String title;
  final BadgeTone tone;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final label = tone == BadgeTone.error
        ? l10n.severityCritical
        : tone == BadgeTone.warning
            ? l10n.severityAttention
            : l10n.severityInfo;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      trailing: StatusBadge(label: label, tone: tone),
    );
  }
}

class _IntegrationsTab extends StatelessWidget {
  const _IntegrationsTab({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final items = [
      (l10n.integNameSap, l10n.integStatusAvailable),
      (l10n.integNameExcel, l10n.integStatusConnected),
      (l10n.integNameQuickbooks, l10n.integStatusAvailable),
      (l10n.integNameFic, l10n.integStatusAvailable),
      (l10n.integNameSheets, l10n.integStatusAvailable),
      (l10n.integNameApi, l10n.integStatusSoon),
    ];
    return VerdantCard(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.6,
        ),
        itemBuilder: (context, i) {
          final s = items[i].$2;
          final done = s.contains('✓');
          final soon = s == l10n.integStatusSoon;
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: kSurface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: kBorderSubtle),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(items[i].$1, style: Theme.of(context).textTheme.labelLarge),
                const Spacer(),
                Text(
                  s,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: done
                            ? kSuccess
                            : soon
                                ? kTextMuted
                                : kInfo,
                      ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
