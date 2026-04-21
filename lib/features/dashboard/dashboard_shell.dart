import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:verdant/l10n/app_localizations.dart';

import '../../core/theme/colors.dart';
import '../../core/utils/responsive.dart';
import '../../features/auth/auth_provider.dart';
import '../../shared/widgets/language_menu_button.dart';
import '../../shared/widgets/verdant_logo.dart';

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
    Icons.home_outlined,
    Icons.auto_graph_outlined,
    Icons.description_outlined,
    Icons.verified_outlined,
    Icons.hub_outlined,
    Icons.settings_outlined,
  ];

  String _label(AppLocalizations l, String path) {
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
        return l.navIntegrations;
      case '/settings':
        return l.navSettings;
      default:
        return path;
    }
  }

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final mobile = Responsive.isMobile(context);
    final desktop = Responsive.isDesktop(context);
    final user = ref.watch(currentUserProvider);

    if (mobile) {
      return Scaffold(
        backgroundColor: kSurface,
        body: child,
        bottomNavigationBar: NavigationBar(
          height: 68,
          backgroundColor: kSurfaceCard,
          indicatorColor: kPrimaryGreen.withValues(alpha: 0.2),
          selectedIndex: _indexForPath(location),
          onDestinationSelected: (i) => context.go(_paths[i]),
          destinations: [
            for (var i = 0; i < 5; i++)
              NavigationDestination(
                icon: Icon(_icons[i]),
                label: _short(l10n, _paths[i]),
              ),
          ],
        ),
        appBar: AppBar(
          title: Row(
            children: [
              const VerdantLogo(size: 28),
              const SizedBox(width: 10),
              Text(l10n.brandName, style: Theme.of(context).textTheme.headlineMedium),
            ],
          ),
          actions: [
            const LanguageMenuButton(compact: true),
            IconButton(
              onPressed: () => context.go('/settings'),
              icon: const Icon(Icons.settings_outlined),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: kSurface,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: desktop ? 280 : 88,
            child: ColoredBox(
              color: kSurfaceCard,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        const VerdantLogo(size: 32),
                        if (desktop) ...[
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              l10n.brandName,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (desktop)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: const LanguageMenuButton(),
                    ),
                  const SizedBox(height: 8),
                  if (desktop)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        user?.email ?? l10n.account,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: ListView(
                      children: [
                        for (var i = 0; i < _paths.length; i++)
                          _SideTile(
                            icon: _icons[i],
                            label: _label(l10n, _paths[i]),
                            path: _paths[i],
                            selected: location == _paths[i] ||
                                (_paths[i] != '/dashboard' &&
                                    location.startsWith(_paths[i])),
                            expanded: desktop,
                          ),
                      ],
                    ),
                  ),
                  if (desktop)
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.planStarterSidebar,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          const SizedBox(height: 8),
                          const LinearProgressIndicator(
                            value: 2 / 3,
                            color: kPrimaryGreen,
                            backgroundColor: kBorderSubtle,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            l10n.reportsUsedProgress(2, 3),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(height: 12),
                          OutlinedButton(
                            onPressed: () => context.go('/pricing'),
                            child: Text(l10n.upgradeGrowth),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }

  int _indexForPath(String path) {
    for (var i = 0; i < _paths.length; i++) {
      if (path == _paths[i] ||
          (path.startsWith(_paths[i]) && _paths[i] != '/dashboard')) {
        return i.clamp(0, 4);
      }
    }
    return 0;
  }
}

class _SideTile extends StatelessWidget {
  const _SideTile({
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
    final bg = selected ? kPrimaryGreen.withValues(alpha: 0.12) : Colors.transparent;
    final border = selected
        ? const Border(left: BorderSide(color: kPrimaryGreen, width: 3))
        : null;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Material(
        color: bg,
        child: InkWell(
          onTap: () => context.go(path),
          child: Container(
            decoration: BoxDecoration(border: border),
            padding: EdgeInsets.symmetric(
              horizontal: expanded ? 20 : 16,
              vertical: 14,
            ),
            child: Row(
              children: [
                Icon(icon, color: selected ? kPrimaryGreen : kTextMuted),
                if (expanded) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      label,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 15,
                            color: selected ? kTextPrimary : kTextSecondary,
                          ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
