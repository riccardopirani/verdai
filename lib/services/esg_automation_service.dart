import 'dart:math';
import 'dart:typed_data';

import 'package:excel/excel.dart';

class EmissionEntry {
  const EmissionEntry({
    required this.scope,
    required this.co2Kg,
    required this.year,
  });

  final int scope;
  final double co2Kg;
  final int year;
}

class YearlyFootprint {
  const YearlyFootprint({
    required this.year,
    required this.scope1Kg,
    required this.scope2Kg,
    required this.scope3Kg,
  });

  final int year;
  final double scope1Kg;
  final double scope2Kg;
  final double scope3Kg;

  double get totalKg => scope1Kg + scope2Kg + scope3Kg;
  double get totalTons => totalKg / 1000;
}

class ComplianceItem {
  const ComplianceItem({
    required this.key,
    required this.done,
    required this.framework,
  });

  final String key;
  final bool done;
  final String framework;
}

class ComplianceAlert {
  const ComplianceAlert({
    required this.key,
    required this.highPriority,
  });

  final String key;
  final bool highPriority;
}

class TenderCertificate {
  const TenderCertificate({
    required this.reference,
    required this.issuedAt,
    required this.validUntil,
    required this.footprintTons,
  });

  final String reference;
  final DateTime issuedAt;
  final DateTime validUntil;
  final double footprintTons;
}

class EsgAutomationService {
  EsgAutomationService._();
  static final EsgAutomationService instance = EsgAutomationService._();

  final List<EmissionEntry> _entries = [];

  YearlyFootprint footprintForYear(int year) {
    final byYear = _entries.where((e) => e.year == year);
    final scope1 = byYear
        .where((e) => e.scope == 1)
        .fold<double>(0, (sum, e) => sum + e.co2Kg);
    final scope2 = byYear
        .where((e) => e.scope == 2)
        .fold<double>(0, (sum, e) => sum + e.co2Kg);
    final scope3 = byYear
        .where((e) => e.scope == 3)
        .fold<double>(0, (sum, e) => sum + e.co2Kg);
    return YearlyFootprint(
      year: year,
      scope1Kg: scope1,
      scope2Kg: scope2,
      scope3Kg: scope3,
    );
  }

  List<YearlyFootprint> yearOverYear() {
    if (_entries.isEmpty) {
      return [footprintForYear(DateTime.now().year)];
    }
    final years = _entries.map((e) => e.year).toSet().toList()..sort();
    return years.map(footprintForYear).toList(growable: false);
  }

  double esgScore(int year) {
    final f = footprintForYear(year);
    if (f.totalTons == 0) return 0;
    final intensity = f.totalTons / 110;
    return (82 - (intensity * 13)).clamp(0, 95);
  }

  List<ComplianceItem> complianceChecklist([int? year]) {
    final targetYear = year ?? DateTime.now().year;
    final f = footprintForYear(targetYear);
    return [
      ComplianceItem(
        key: 'double_materiality',
        done: f.totalKg > 0,
        framework: 'CSRD',
      ),
      ComplianceItem(
        key: 'scope_disclosure',
        done: f.scope1Kg > 0 || f.scope2Kg > 0 || f.scope3Kg > 0,
        framework: 'ESRS E1',
      ),
      ComplianceItem(
        key: 'supplier_evidence',
        done: f.scope3Kg > 0,
        framework: 'GRI 308',
      ),
      ComplianceItem(
        key: 'climate_plan',
        done: f.scope1Kg + f.scope2Kg > 0,
        framework: 'ESRS E1',
      ),
      ComplianceItem(
        key: 'governance_statement',
        done: f.totalKg > 0,
        framework: 'CSRD',
      ),
    ];
  }

  List<ComplianceAlert> complianceAlerts([int? year]) {
    final targetYear = year ?? DateTime.now().year;
    final f = footprintForYear(targetYear);
    final alerts = <ComplianceAlert>[];
    if (f.scope3Kg == 0) {
      alerts.add(
          const ComplianceAlert(key: 'missing_suppliers', highPriority: true));
    }
    alerts.add(
        const ComplianceAlert(key: 'tender_expiring', highPriority: false));
    return alerts;
  }

  double complianceProgress() {
    final items = complianceChecklist();
    final done = items.where((e) => e.done).length;
    return items.isEmpty ? 0 : done / items.length;
  }

  TenderCertificate generateTenderCertificate(int year) {
    final ref = 'PUB-${year.toString().substring(2)}-${(year * 17) % 10000}';
    return TenderCertificate(
      reference: ref,
      issuedAt: DateTime.now(),
      validUntil: DateTime.now().add(const Duration(days: 365)),
      footprintTons: footprintForYear(year).totalTons,
    );
  }

  void addManualEmission({
    required int scope,
    required double co2Kg,
    int? year,
  }) {
    _entries.add(
      EmissionEntry(
        scope: scope,
        co2Kg: co2Kg,
        year: year ?? DateTime.now().year,
      ),
    );
  }

  Future<double> importFromFile({
    required String fileName,
    required Uint8List bytes,
  }) async {
    final name = fileName.toLowerCase();
    if (name.endsWith('.xlsx')) {
      return _importFromExcel(bytes);
    }
    final text = String.fromCharCodes(bytes);
    return _importFromText(text);
  }

  double _importFromExcel(Uint8List bytes) {
    final excel = Excel.decodeBytes(bytes);
    var aggregate = 0.0;
    for (final sheet in excel.tables.values) {
      for (final row in sheet.rows) {
        for (final cell in row) {
          final numValue = _parseNumeric(cell?.value?.toString() ?? '');
          if (numValue != null) {
            aggregate += numValue;
          }
        }
      }
    }
    return _registerImportedValue(aggregate);
  }

  double _importFromText(String text) {
    final regex = RegExp(r'(\d+(?:[\.,]\d+)?)');
    var aggregate = 0.0;
    for (final m in regex.allMatches(text)) {
      final value = _parseNumeric(m.group(1) ?? '');
      if (value != null) aggregate += value;
    }
    return _registerImportedValue(aggregate);
  }

  double _registerImportedValue(double rawSum) {
    final normalized = min<double>(max<double>(rawSum / 80, 0), 25000);
    addManualEmission(scope: 3, co2Kg: normalized);
    return normalized;
  }

  double? _parseNumeric(String input) {
    final cleaned =
        input.replaceAll(',', '.').replaceAll(RegExp(r'[^0-9\.]'), '');
    return double.tryParse(cleaned);
  }
}
