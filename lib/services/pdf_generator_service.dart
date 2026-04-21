import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:verdant/l10n/app_localizations.dart';

import '../shared/models/company.dart';

class PdfGeneratorService {
  Future<pw.Document> buildDemoReport({
    required AppLocalizations l10n,
    required Company company,
    required int year,
    required String standard,
    required double esgScore,
    required double totalCo2Tons,
    double scope1Tons = 0,
    double scope2Tons = 0,
    double scope3Tons = 0,
  }) async {
    final doc = pw.Document();
    doc.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          margin: const pw.EdgeInsets.all(40),
          theme: pw.ThemeData.withFont(),
        ),
        build: (context) => [
          pw.Header(
            level: 0,
            child: pw.Text(
              l10n.pdfCoverTitle(standard),
              style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.SizedBox(height: 12),
          pw.Text(
            l10n.pdfCompany(company.name),
            style: const pw.TextStyle(fontSize: 14),
          ),
          pw.Text(
            l10n.pdfYear('$year'),
            style: const pw.TextStyle(fontSize: 12),
          ),
          pw.SizedBox(height: 24),
          pw.Text(
            l10n.pdfExecSummary,
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
          ),
          pw.Bullet(text: l10n.pdfBulletScore(esgScore.toStringAsFixed(1))),
          pw.Bullet(
            text: l10n.pdfBulletCo2(totalCo2Tons.toStringAsFixed(2)),
          ),
          pw.Bullet(text: l10n.pdfFrameworkAlignment),
          pw.SizedBox(height: 24),
          pw.Text(
            l10n.pdfScopeTableTitle,
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
          ),
          pw.TableHelper.fromTextArray(
            headers: [l10n.pdfScopeColScope, l10n.pdfScopeColTons],
            data: [
              [l10n.scope1, scope1Tons.toStringAsFixed(2)],
              [l10n.scope2, scope2Tons.toStringAsFixed(2)],
              [l10n.scope3, scope3Tons.toStringAsFixed(2)],
            ],
          ),
          pw.SizedBox(height: 32),
          pw.Text(
            l10n.pdfFooter(DateTime.now().toIso8601String()),
            style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700),
          ),
        ],
      ),
    );
    return doc;
  }
}
