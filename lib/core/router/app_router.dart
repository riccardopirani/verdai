import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';
import '../../features/auth/forgot_password_page.dart';
import '../../features/auth/login_page.dart';
import '../../features/auth/register_page.dart';
import '../../features/compliance/compliance_page.dart';
import '../../features/dashboard/dashboard_page.dart';
import '../../features/dashboard/dashboard_shell.dart';
import '../../features/data_input/integrations_page.dart';
import '../../features/data_input/manual_input_page.dart';
import '../../features/data_input/upload_page.dart';
import '../../features/landing/contact_page.dart';
import '../../features/landing/landing_page.dart';
import '../../features/onboarding/onboarding_flow.dart';
import '../../features/reports/report_generator_page.dart';
import '../../features/reports/reports_list_page.dart';
import '../../features/settings/billing_page.dart';
import '../../features/settings/company_profile_page.dart';
import '../../features/settings/settings_page.dart';
import '../../services/supabase_service.dart';
import 'auth_refresh.dart';

final _authRefresh = AuthRefreshNotifier();

final GoRouter appRouter = GoRouter(
  refreshListenable: _authRefresh,
  initialLocation: '/',
  redirect: (context, state) {
    final loc = state.matchedLocation;
    final isLoggedIn = AppConstants.isSupabaseConfigured &&
        SupabaseService.instance.currentUser != null;

    final isAuthRoute = loc.startsWith('/auth');
    const public = {
      '/',
      '/pricing',
      '/features',
      '/how-it-works',
      '/contact',
    };
    final isPublic = public.contains(loc);

    if (!isLoggedIn && !isAuthRoute && !isPublic) {
      return '/auth/login';
    }
    if (isLoggedIn && isAuthRoute) {
      return '/dashboard';
    }
    return null;
  },
  routes: [
    GoRoute(path: '/', builder: (c, s) => const LandingPage()),
    GoRoute(
      path: '/pricing',
      builder: (c, s) =>
          const LandingPage(scrollTarget: LandingScrollTarget.pricing),
    ),
    GoRoute(
      path: '/how-it-works',
      builder: (c, s) =>
          const LandingPage(scrollTarget: LandingScrollTarget.howItWorks),
    ),
    GoRoute(
      path: '/features',
      builder: (c, s) =>
          const LandingPage(scrollTarget: LandingScrollTarget.features),
    ),
    GoRoute(path: '/contact', builder: (c, s) => const ContactPage()),
    GoRoute(path: '/auth/login', builder: (c, s) => const LoginPage()),
    GoRoute(path: '/auth/register', builder: (c, s) => const RegisterPage()),
    GoRoute(
      path: '/auth/forgot-password',
      builder: (c, s) => const ForgotPasswordPage(),
    ),
    GoRoute(path: '/onboarding', builder: (c, s) => const OnboardingFlow()),
    ShellRoute(
      builder: (context, state, child) => DashboardShell(
        location: state.uri.path,
        child: child,
      ),
      routes: [
        GoRoute(
          path: '/dashboard',
          builder: (c, s) => const DashboardPage(),
        ),
        GoRoute(
          path: '/emissions',
          builder: (c, s) => const UploadPage(),
        ),
        GoRoute(
          path: '/reports',
          builder: (c, s) => const ReportsListPage(),
        ),
        GoRoute(
          path: '/reports/new',
          builder: (c, s) => const ReportGeneratorPage(),
        ),
        GoRoute(
          path: '/compliance',
          builder: (c, s) => const CompliancePage(),
        ),
        GoRoute(
          path: '/integrations',
          builder: (c, s) => const IntegrationsPage(),
        ),
        GoRoute(
          path: '/settings',
          builder: (c, s) => const SettingsPage(),
          routes: [
            GoRoute(
              path: 'billing',
              builder: (c, s) => const BillingPage(),
            ),
            GoRoute(
              path: 'company',
              builder: (c, s) => const CompanyProfilePage(),
            ),
            GoRoute(
              path: 'manual-input',
              builder: (c, s) => const ManualInputPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
