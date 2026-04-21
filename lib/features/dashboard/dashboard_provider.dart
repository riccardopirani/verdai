import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/auth_provider.dart';
import '../../services/esg_automation_service.dart';

class DashboardKpi {
  const DashboardKpi({
    required this.esgScore,
    required this.co2Tons,
    required this.complianceProgress,
    required this.reportsUsed,
    required this.reportsLimit,
  });

  final double esgScore;
  final double co2Tons;
  final double complianceProgress;
  final int reportsUsed;
  final int reportsLimit;
}

final dashboardKpiProvider = FutureProvider<DashboardKpi>((ref) async {
  final companyId = await ref.watch(companyIdProvider.future);
  final service = EsgAutomationService.instance;
  final footprint = service.footprintForYear(DateTime.now().year);
  final score = service.esgScore(DateTime.now().year);
  final progress = service.complianceProgress();
  final generatedReports =
      service.yearOverYear().where((e) => e.totalKg > 0).length;
  const reportsLimit = 12;
  if (companyId == null) {
    return DashboardKpi(
      esgScore: score,
      co2Tons: footprint.totalTons,
      complianceProgress: progress,
      reportsUsed: generatedReports,
      reportsLimit: reportsLimit,
    );
  }
  return DashboardKpi(
    esgScore: score,
    co2Tons: footprint.totalTons,
    complianceProgress: progress,
    reportsUsed: generatedReports,
    reportsLimit: reportsLimit,
  );
});
