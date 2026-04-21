import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:verdant/l10n/app_localizations.dart';

import '../../../shared/widgets/language_menu_button.dart';
import '../../../shared/widgets/verdant_logo.dart';
import '../landing_design_tokens.dart';

/// Which public marketing nav item is visually active (landing-style top bar).
enum PublicNavHighlight { none, howItWorks, features, pricing, contact }

TextStyle? _navLabelStyle(
  BuildContext context,
  PublicNavHighlight highlight,
  PublicNavHighlight target,
) {
  final selected = highlight == target;
  return Theme.of(context).textTheme.labelLarge?.copyWith(
        color: selected
            ? LandingDesign.foreground
            : LandingDesign.mutedForeground,
        fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
      );
}

List<Widget> _publicMarketingActions(
  BuildContext context,
  AppLocalizations l10n,
  PublicNavHighlight highlight,
) {
  return [
    const LanguageMenuButton(),
    TextButton(
      onPressed: () => context.go('/how-it-works'),
      child: Text(
        l10n.landingNavHowItWorks,
        style: _navLabelStyle(context, highlight, PublicNavHighlight.howItWorks),
      ),
    ),
    TextButton(
      onPressed: () => context.go('/features'),
      child: Text(
        l10n.landingFeatures,
        style: _navLabelStyle(context, highlight, PublicNavHighlight.features),
      ),
    ),
    TextButton(
      onPressed: () => context.go('/pricing'),
      child: Text(
        l10n.landingPricing,
        style: _navLabelStyle(context, highlight, PublicNavHighlight.pricing),
      ),
    ),
    TextButton(
      onPressed: () => context.go('/contact'),
      child: Text(
        l10n.landingHeaderContact,
        style: _navLabelStyle(context, highlight, PublicNavHighlight.contact),
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilledButton(
        onPressed: () => context.go('/auth/login'),
        style: FilledButton.styleFrom(
          backgroundColor: LandingDesign.primary,
          foregroundColor: LandingDesign.onPrimary,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(l10n.landingLogin),
      ),
    ),
  ];
}

class _BrandTitle extends StatelessWidget {
  const _BrandTitle({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.go('/'),
      borderRadius: BorderRadius.circular(8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const VerdantLogo(size: 28),
          const SizedBox(width: 10),
          Text(
            l10n.brandName,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: LandingDesign.foreground,
                ),
          ),
        ],
      ),
    );
  }
}

/// Top bar matching [LandingPage] — for [Scaffold.appBar].
class PublicMarketingAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PublicMarketingAppBar({
    super.key,
    this.highlight = PublicNavHighlight.none,
  });

  final PublicNavHighlight highlight;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AppBar(
      backgroundColor: LandingDesign.background.withValues(alpha: 0.96),
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0.5,
      title: _BrandTitle(l10n: l10n),
      actions: _publicMarketingActions(context, l10n, highlight),
    );
  }
}

/// [SliverAppBar] variant for [CustomScrollView] (landing, pricing, contact).
class PublicMarketingSliverAppBar extends StatelessWidget {
  const PublicMarketingSliverAppBar({
    super.key,
    this.highlight = PublicNavHighlight.none,
  });

  final PublicNavHighlight highlight;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SliverAppBar(
      floating: true,
      pinned: true,
      backgroundColor: LandingDesign.background.withValues(alpha: 0.96),
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0.5,
      title: _BrandTitle(l10n: l10n),
      actions: _publicMarketingActions(context, l10n, highlight),
    );
  }
}
