import 'package:flutter/material.dart';
import 'package:verdant/l10n/app_localizations.dart';

import '../../core/theme/colors.dart';
import '../../services/esg_automation_service.dart';

class CompliancePage extends StatelessWidget {
  const CompliancePage({super.key});

  String _checklistLabel(AppLocalizations l10n, String key) {
    switch (key) {
      case 'double_materiality':
        return l10n.compChecklistDoubleMateriality;
      case 'scope_disclosure':
        return l10n.compChecklistScopeDisclosure;
      case 'supplier_evidence':
        return l10n.compChecklistSupplierEvidence;
      case 'climate_plan':
        return l10n.compChecklistClimatePlan;
      case 'governance_statement':
      default:
        return l10n.compChecklistGovernance;
    }
  }

  String _alertTitle(AppLocalizations l10n, String key) {
    switch (key) {
      case 'missing_suppliers':
        return l10n.compAlertMissingSuppliersTitle;
      case 'tender_expiring':
      default:
        return l10n.compAlertTenderExpiringTitle;
    }
  }

  String _alertSubtitle(AppLocalizations l10n, String key) {
    switch (key) {
      case 'missing_suppliers':
        return l10n.compAlertMissingSuppliersSub;
      case 'tender_expiring':
      default:
        return l10n.compAlertTenderExpiringSub;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final service = EsgAutomationService.instance;
    final checklist = service.complianceChecklist();
    final certificate = service.generateTenderCertificate(DateTime.now().year);
    final alerts = service.complianceAlerts();

    return Scaffold(
      backgroundColor: kSurface,
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            l10n.alertsSectionTitle,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 12),
          for (final alert in alerts) ...[
            Card(
              child: ListTile(
                leading: Icon(
                  alert.highPriority
                      ? Icons.warning_amber_rounded
                      : Icons.info_outline,
                  color: alert.highPriority ? kError : kWarning,
                ),
                title: Text(_alertTitle(l10n, alert.key)),
                subtitle: Text(_alertSubtitle(l10n, alert.key)),
              ),
            ),
            const SizedBox(height: 8),
          ],
          const SizedBox(height: 16),
          Text(
            l10n.compChecklistTitle,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 12),
          for (final item in checklist)
            Card(
              child: CheckboxListTile(
                value: item.done,
                onChanged: (_) {},
                title: Text(_checklistLabel(l10n, item.key)),
                subtitle: Text(item.framework),
              ),
            ),
          const SizedBox(height: 16),
          Text(
            l10n.compTenderTitle,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.verified_outlined, color: kSuccess),
              title: Text(l10n.compCertificateTitle(certificate.reference)),
              subtitle: Text(
                l10n.compCertificateSub(
                  certificate.footprintTons.toStringAsFixed(2),
                  certificate.validUntil.toLocal().toString().split(' ').first,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
