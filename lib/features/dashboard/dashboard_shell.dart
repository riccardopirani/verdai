import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:verdant/l10n/app_localizations.dart';

import '../../core/utils/responsive.dart';
import '../../features/auth/auth_provider.dart';
import '../../shared/widgets/language_menu_button.dart';
import 'banani_dashboard_tokens.dart';
import 'dashboard_provider.dart';
import 'widgets/banani_shell_header.dart';

class DashboardShell extends ConsumerWidget {
  const DashboardShell({
    super.key,
    required this.child,
    required this.location,
  });

  final Widget child;
  final String location;

  static const _paths = <String>[
    '/dashboard',
    '/emissions',
    '/reports',
    '/compliance',
    '/integrations',
    '/settings',
  ];

  static const _icons = <IconData>[
    Icons.dashboard_outlined,
    Icons.storage_outlined,
    Icons.description_outlined,
    Icons.verified_user_outlined,
    Icons.power_outlined,
    Icons.settings_outlined,
  ];

  String _short(AppLocalizations l, String path) {
    switch (path) {
      case '/dashboard':
        return l.navShortDashboard;
      case '/emissions':
        return l.navShortData;
      case '/reports':
        return l.navShortReports;
      case '/compliance':
        return l.navShortCompliance;
      case '/integrations':
        return l.navShortIntegrations;
      default:
        return l.navSettings;
    }
  }

  String _mobileTitle(AppLocalizations l) {
    if (location.startsWith('/settings/billing')) return l.billingTitle;
    if (location.startsWith('/settings/company')) return l.companyProfileTitle;
    if (location.startsWith('/settings/manual-input')) return l.settingsManualFull;
    if (location.startsWith('/settings')) return l.settingsTitle;
    if (location.startsWith('/reports/new')) return l.reportGenTitle;
    if (location.startsWith('/reports')) return l.reportsListTitle;
    if (location.startsWith('/emissions')) return l.emissionsUploadTitle;
    if (location.startsWith('/compliance')) return l.complianceTitle;
    if (location.startsWith('/integrations')) return l.integrationsTitle;
    if (location.startsWith('/dashboard')) return l.navDashboard;
    return l.navDashboard;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final mobile = Responsive.isMobile(context);
    final desktop = Responsive.isDesktop(context);
    final user = ref.watch(currentUserProvider);
    final kpi = ref.watch(dashboardKpiProvider);
    final reportsUsed = kpi.valueOrNull?.reportsUsed ?? 0;
    final reportsLimit = kpi.valueOrNull?.reportsLimit ?? 1;
    final email = user?.email ?? l10n.account;
    final initial = email.isNotEmpty ? email[0].toUpperCase() : l10n.userFallback;

    if (mobile) {
      return Scaffold(
        backgroundColor: BananiDash.background,
        appBar: AppBar(
          backgroundColor: BananiDash.background,
          foregroundColor: BananiDash.foreground,
          elevation: 0,
          title: Text(
            _mobileTitle(l10n),
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: BananiDash.foreground,
            ),
          ),
          actions: const [
            LanguageMenuButton(compact: true),
            SizedBox(width: 4),
          ],
        ),
        drawer: Drawer(
          backgroundColor: BananiDash.surface,
          child: SafeArea(
            child: _SidebarNav(
              l10n: l10n,
              location: location,
              expanded: true,
              email: email,
              initial: initial,
              scrollable: true,
              reportsUsed: reportsUsed,
              reportsLimit: reportsLimit,
            ),
          ),
        ),
        body: child,
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            backgroundColor: BananiDash.surface,
            indicatorColor: BananiDash.primary.withValues(alpha: 0.15),
            labelTextStyle: WidgetStateProperty.resolveWith((s) {
              final selected = s.contains(WidgetState.selected);
              return TextStyle(
                fontSize: 11,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                color: selected ? BananiDash.primary : BananiDash.mutedForeground,
              );
            }),
            iconTheme: WidgetStateProperty.resolveWith((s) {
              final selected = s.contains(WidgetState.selected);
              return IconThemeData(
                color: selected ? BananiDash.primary : BananiDash.mutedForeground,
                size: 22,
              );
            }),
          ),
          child: NavigationBar(
            height: 68,
            selectedIndex: _indexForPath(location).clamp(0, 5),
            onDestinationSelected: (i) => context.go(_paths[i]),
            destinations: [
              for (var i = 0; i < 6; i++)
                NavigationDestination(
                  icon: Icon(_icons[i]),
                  label: _short(l10n, _paths[i]),
                ),
            ],
          ),
        ),
      );
    }

    final sidebarW = desktop ? BananiDash.sidebarWidth : 72.0;

    return Scaffold(
      backgroundColor: BananiDash.background,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: sidebarW,
            child: ColoredBox(
              color: BananiDash.surface,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  border: Border(right: BorderSide(color: BananiDash.border)),
                ),
                child: _SidebarNav(
                  l10n: l10n,
                  location: location,
                  expanded: desktop,
                  email: email,
                  initial: initial,
                  reportsUsed: reportsUsed,
                  reportsLimit: reportsLimit,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BananiShellHeader(location: location),
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int _indexForPath(String path) {
    for (var i = 0; i < _paths.length; i++) {
      if (path == _paths[i] ||
          (path.startsWith(_paths[i]) && _paths[i] != '/dashboard')) {
        return i;
      }
    }
    return 0;
  }
}

class _SidebarNav extends StatelessWidget {
  const _SidebarNav({
    required this.l10n,
    required this.location,
    required this.expanded,
    required this.email,
    required this.initial,
    required this.reportsUsed,
    required this.reportsLimit,
    this.scrollable = false,
  });

  final AppLocalizations l10n;
  final String location;
  final bool expanded;
  final String email;
  final String initial;
  final int reportsUsed;
  final int reportsLimit;
  final bool scrollable;

  bool _selected(String path) {
    if (path == '/dashboard') return location == '/dashboard';
    return location.startsWith(path);
  }

  Widget _logoRow() {
    return Padding(
      padding: EdgeInsets.fromLTRB(expanded ? 16 : 12, 16, 16, expanded ? 16 : 12),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: BananiDash.primary,
              borderRadius: BorderRadius.circular(BananiDash.radiusMd),
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.eco, size: 18, color: BananiDash.onPrimary),
          ),
          if (expanded) ...[
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                l10n.brandName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: BananiDash.foreground,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  List<Widget> _linkTiles() {
    return [
      for (var i = 0; i < DashboardShell._paths.length; i++)
        _SideNavLink(
          icon: DashboardShell._icons[i],
          label: _navLabel(l10n, DashboardShell._paths[i]),
          path: DashboardShell._paths[i],
          selected: _selected(DashboardShell._paths[i]),
          expanded: expanded,
        ),
    ];
  }

  Widget _planAndUser(BuildContext context) {
    if (!expanded) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Center(
          child: CircleAvatar(
            radius: 16,
            backgroundColor: BananiDash.input,
            foregroundColor: BananiDash.foreground,
            child: Text(initial, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
          ),
        ),
      );
    }

    final progress = reportsLimit <= 0 ? 0.0 : (reportsUsed / reportsLimit).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: BananiDash.muted,
              borderRadius: BorderRadius.circular(BananiDash.radiusLg),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.planStarterSidebar,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: BananiDash.foreground,
                      ),
                    ),
                    Text(
                      l10n.reportsUsedProgress(reportsUsed, reportsLimit),
                      style: const TextStyle(
                        fontSize: 12,
                        color: BananiDash.mutedForeground,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    color: BananiDash.primary,
                    backgroundColor: BananiDash.border,
                  ),
                ),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: () => context.go('/settings/billing'),
                  style: FilledButton.styleFrom(
                    backgroundColor: BananiDash.primary,
                    foregroundColor: BananiDash.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(BananiDash.radiusMd),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: Text(l10n.upgradeGrowth),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: BananiDash.input,
                foregroundColor: BananiDash.foreground,
                child: Text(initial, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  email,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: BananiDash.foreground,
                  ),
                ),
              ),
              const LanguageMenuButton(compact: true),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (scrollable) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _logoRow(),
            ..._linkTiles(),
            _planAndUser(context),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _logoRow(),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: _linkTiles(),
          ),
        ),
        _planAndUser(context),
      ],
    );
  }

  String _navLabel(AppLocalizations l, String path) {
    switch (path) {
      case '/dashboard':
        return l.navDashboard;
      case '/emissions':
        return l.navEmissions;
      case '/reports':
        return l.navReports;
      case '/compliance':
        return l.navCompliance;
      case '/integrations':
        return l.integrationsTitle;
      case '/settings':
        return l.navSettings;
      default:
        return path;
    }
  }

}

class _SideNavLink extends StatelessWidget {
  const _SideNavLink({
    required this.icon,
    required this.label,
    required this.path,
    required this.selected,
    required this.expanded,
  });

  final IconData icon;
  final String label;
  final String path;
  final bool selected;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final bg = selected ? BananiDash.primary.withValues(alpha: 0.1) : Colors.transparent;
    final fg = selected ? BananiDash.primary : BananiDash.mutedForeground;

    final row = Material(
      color: bg,
      borderRadius: BorderRadius.circular(BananiDash.radiusMd),
      child: InkWell(
        onTap: () => context.go(path),
        borderRadius: BorderRadius.circular(BananiDash.radiusMd),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: expanded ? 12 : 10, vertical: 10),
          child: Row(
            children: [
              Icon(icon, size: 18, color: fg),
              if (expanded) ...[
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: fg,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );

    if (!expanded) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Tooltip(
          message: label,
          child: row,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: row,
    );
  }
}
