import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:verdant/l10n/app_localizations.dart';

import '../../core/theme/colors.dart';
import '../../services/esg_automation_service.dart';
import '../../services/pdf_generator_service.dart';
import '../../shared/models/company.dart';
import '../../shared/widgets/verdant_button.dart';
import '../../shared/widgets/verdant_card.dart';

class ReportGeneratorPage extends StatefulWidget {
  const ReportGeneratorPage({super.key});

  @override
  State<ReportGeneratorPage> createState() => _ReportGeneratorPageState();
}

class _ReportGeneratorPageState extends State<ReportGeneratorPage> {
  int _step = 0;
  int _year = DateTime.now().year;
  String _standard = 'CSRD';
  String _lang = 'IT';
  bool _bench = true;
  bool _plan = true;

  final _completeness = 0.72;
  bool _generating = false;
  int _genStep = 0;

  List<String> _genStepLabels(AppLocalizations l10n) => [
        l10n.genStepCollect,
        l10n.genStepCalc,
        l10n.genStepCompliance,
        l10n.genStepPdf,
        l10n.genStepDone,
      ];

  Future<void> _runGenerate() async {
    final l10n = AppLocalizations.of(context);
    final labels = _genStepLabels(l10n);
    setState(() {
      _generating = true;
      _genStep = 0;
    });
    for (var i = 0; i < labels.length; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 450));
      if (!mounted) return;
      setState(() => _genStep = i);
    }
    setState(() => _generating = false);
  }

  Future<void> _previewPdf() async {
    final l10n = AppLocalizations.of(context);
    final demoCompany = Company(
      id: 'local-company',
      userId: 'local-user',
      name: l10n.demoCompanyName,
    );
    final footprint = EsgAutomationService.instance.footprintForYear(_year);
    final doc = await PdfGeneratorService().buildDemoReport(
      l10n: l10n,
      company: demoCompany,
      year: _year,
      standard: _standard,
      esgScore: EsgAutomationService.instance.esgScore(_year),
      totalCo2Tons: footprint.totalTons,
      scope1Tons: footprint.scope1Kg / 1000,
      scope2Tons: footprint.scope2Kg / 1000,
      scope3Tons: footprint.scope3Kg / 1000,
    );
    await Printing.layoutPdf(onLayout: (_) async => doc.save());
  }

  String _standardLabel(AppLocalizations l10n, String code) {
    switch (code) {
      case 'GRI':
        return l10n.stdGri;
      case 'ESRS':
        return l10n.stdEsrs;
      case 'CSRD':
      default:
        return l10n.stdCsrdTitle;
    }
  }

  String _langLabel(AppLocalizations l10n, String code) {
    switch (code) {
      case 'EN':
        return l10n.langName_en;
      case 'DE':
        return l10n.langName_de;
      case 'FR':
        return l10n.langName_fr;
      case 'IT':
      default:
        return l10n.langName_it;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final genLabels = _genStepLabels(l10n);

    return Scaffold(
      backgroundColor: kSurface,
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Row(
            children: [
              _StepChip(active: _step >= 0, label: l10n.stepConfig),
              _StepChip(active: _step >= 1, label: l10n.stepPreview),
              _StepChip(active: _step >= 2, label: l10n.stepOutput),
            ],
          ),
          const SizedBox(height: 24),
          if (_step == 0) ...[
            VerdantCard(
              child: Column(
                children: [
                  DropdownButtonFormField<int>(
                    value: _year,
                    items: [2023, 2024, 2025]
                        .map((y) =>
                            DropdownMenuItem(value: y, child: Text('$y')))
                        .toList(),
                    onChanged: (v) => setState(() => _year = v ?? _year),
                    decoration: InputDecoration(labelText: l10n.fieldYear),
                  ),
                  DropdownButtonFormField<String>(
                    value: _standard,
                    items: ['CSRD', 'GRI', 'ESRS']
                        .map(
                          (c) => DropdownMenuItem(
                            value: c,
                            child: Text(_standardLabel(l10n, c)),
                          ),
                        )
                        .toList(),
                    onChanged: (v) => setState(() => _standard = v ?? 'CSRD'),
                    decoration: InputDecoration(labelText: l10n.fieldStandard),
                  ),
                  DropdownButtonFormField<String>(
                    value: _lang,
                    items: ['IT', 'EN', 'DE', 'FR']
                        .map(
                          (c) => DropdownMenuItem(
                            value: c,
                            child: Text(_langLabel(l10n, c)),
                          ),
                        )
                        .toList(),
                    onChanged: (v) => setState(() => _lang = v ?? 'IT'),
                    decoration:
                        InputDecoration(labelText: l10n.fieldReportLang),
                  ),
                  SwitchListTile(
                    value: _bench,
                    onChanged: (v) => setState(() => _bench = v),
                    title: Text(l10n.toggleBenchmark),
                  ),
                  SwitchListTile(
                    value: _plan,
                    onChanged: (v) => setState(() => _plan = v),
                    title: Text(l10n.toggleImprovement),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            VerdantButton(
              label: l10n.reportForward,
              onPressed: () => setState(() => _step = 1),
            ),
          ] else if (_step == 1) ...[
            VerdantCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.reportDataCompleteness,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: _completeness,
                    color: kPrimaryGreen,
                  ),
                  const SizedBox(height: 12),
                  Text(l10n.reportMissingScope3),
                  TextButton(
                    onPressed: () {},
                    child: Text(l10n.reportAddNow),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                TextButton(
                  onPressed: () => setState(() => _step = 0),
                  child: Text(l10n.reportBack),
                ),
                const SizedBox(width: 12),
                VerdantButton(
                  label: l10n.reportForward,
                  onPressed: () => setState(() => _step = 2),
                ),
              ],
            ),
          ] else ...[
            VerdantCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VerdantButton(
                    label: _generating
                        ? l10n.reportGenerating
                        : l10n.reportGenerateBtn(_standard),
                    expand: true,
                    onPressed: _generating ? null : _runGenerate,
                  ),
                  if (_generating || _genStep == genLabels.length - 1) ...[
                    const SizedBox(height: 16),
                    for (var i = 0; i < genLabels.length; i++)
                      ListTile(
                        leading: Icon(
                          i <= _genStep
                              ? Icons.check_circle
                              : Icons.circle_outlined,
                          color: i <= _genStep ? kSuccess : kTextMuted,
                        ),
                        title: Text(genLabels[i]),
                      ),
                  ],
                  const SizedBox(height: 16),
                  VerdantButton(
                    label: l10n.reportPreviewPdf,
                    variant: VerdantButtonVariant.ghost,
                    expand: true,
                    onPressed: _previewPdf,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => setState(() => _step = 1),
              child: Text(l10n.reportBack),
            ),
          ],
        ],
      ),
    );
  }
}

class _StepChip extends StatelessWidget {
  const _StepChip({required this.active, required this.label});
  final bool active;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: active ? kPrimaryGreen.withValues(alpha: 0.15) : kSurfaceCard,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: active ? kPrimaryGreen : kBorderSubtle),
        ),
        child: Text(label),
      ),
    );
  }
}
