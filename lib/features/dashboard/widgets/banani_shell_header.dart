import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:verdant/features/auth/auth_provider.dart';
import 'package:verdant/l10n/app_localizations.dart';

import '../banani_dashboard_tokens.dart';

List<String> _crumbSegments(String raw) {
  final parts = raw.split(RegExp(r'\s*/\s*'));
  return parts.map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
}

/// Top bar for the main column (title, breadcrumb, search, notifications, profile).
class BananiShellHeader extends ConsumerWidget {
  const BananiShellHeader({
    super.key,
    required this.location,
  });

  final String location;

  String _pageTitle(AppLocalizations l) {
    if (location.startsWith('/settings/billing')) return l.billingTitle;
    if (location.startsWith('/settings/company')) return l.companyProfileTitle;
    if (location.startsWith('/settings/manual-input')) return l.settingsManualFull;
    if (location.startsWith('/settings')) return l.settingsTitle;
    if (location.startsWith('/reports/new')) return l.reportGenTitle;
    if (location.startsWith('/reports')) return l.reportsListTitle;
    if (location.startsWith('/emissions')) return l.emissionsUploadTitle;
    if (location.startsWith('/compliance')) return l.complianceTitle;
    if (location.startsWith('/integrations')) return l.integrationsTitle;
    return l.navDashboard;
  }

  String _crumbHome(AppLocalizations l) {
    final s = _crumbSegments(l.dashBreadcrumb);
    return s.isNotEmpty ? s.first : l.navDashboard;
  }

  String _crumbCurrent(AppLocalizations l) {
    if (location == '/dashboard' || location.startsWith('/dashboard')) {
      final s = _crumbSegments(l.dashBreadcrumb);
      return s.length > 1 ? s.last : l.navDashboard;
    }
    return _pageTitle(l);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final user = ref.watch(currentUserProvider);
    final email = user?.email ?? l10n.account;
    final initial = (email.isNotEmpty) ? email[0].toUpperCase() : l10n.userFallback;

    return Material(
      color: BananiDash.background,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
        decoration: const BoxDecoration(
          color: BananiDash.background,
          border: Border(bottom: BorderSide(color: BananiDash.border)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _pageTitle(l10n),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: BananiDash.foreground,
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        _crumbHome(l10n),
                        style: const TextStyle(
                          color: BananiDash.mutedForeground,
                          fontSize: 14,
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right,
                        size: 14,
                        color: BananiDash.mutedForeground,
                      ),
                      Text(
                        _crumbCurrent(l10n),
                        style: const TextStyle(
                          color: BananiDash.foreground,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 256,
              child: TextField(
                style: const TextStyle(
                  color: BananiDash.mutedForeground,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  hintText: l10n.searchHint,
                  hintStyle: const TextStyle(color: BananiDash.mutedForeground),
                  prefixIcon: const Icon(Icons.search, color: BananiDash.mutedForeground, size: 20),
                  filled: true,
                  fillColor: BananiDash.input,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(BananiDash.radiusMd),
                    borderSide: const BorderSide(color: BananiDash.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(BananiDash.radiusMd),
                    borderSide: const BorderSide(color: BananiDash.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(BananiDash.radiusMd),
                    borderSide: const BorderSide(color: BananiDash.primary, width: 1.5),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 24),
            Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  onPressed: () => context.go('/compliance'),
                  icon: const Icon(Icons.notifications_outlined),
                  color: BananiDash.mutedForeground,
                  tooltip: l10n.navCompliance,
                ),
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: BananiDash.danger,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                    child: const Text(
                      '2',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: BananiDash.onDanger,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 20,
              backgroundColor: BananiDash.input,
              foregroundColor: BananiDash.foreground,
              child: Text(
                initial,
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
