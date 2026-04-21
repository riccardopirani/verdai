import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:verdant/l10n/app_localizations.dart';

import '../../core/theme/colors.dart';
import '../../services/esg_automation_service.dart';
import '../../shared/widgets/verdant_button.dart';
import '../../shared/widgets/verdant_card.dart';
import 'manual_input_page.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;
  bool _drag = false;
  String? _fileName;
  String? _importOutcome;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  Future<void> _pick() async {
    final l10n = AppLocalizations.of(context);
    final r = await FilePicker.platform.pickFiles(withData: true);
    final file = r?.files.single;
    if (file == null) return;
    setState(() {
      _fileName = file.name;
      _importOutcome = null;
    });
    if (file.bytes != null) {
      final importedKg = await EsgAutomationService.instance.importFromFile(
        fileName: file.name,
        bytes: file.bytes!,
      );
      if (!mounted) return;
      setState(() {
        _importOutcome = '${importedKg.toStringAsFixed(1)} ${l10n.unitCo2eKg}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: kSurface,
      appBar: AppBar(
        title: Text(l10n.emissionsUploadTitle),
        bottom: TabBar(
          controller: _tabs,
          labelColor: kPrimaryGreen,
          unselectedLabelColor: kTextMuted,
          indicatorColor: kPrimaryGreen,
          tabs: [
            Tab(text: l10n.tabUploadExcel),
            Tab(text: l10n.tabManual),
            Tab(text: l10n.tabIntegrations),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: [
          ListView(
            padding: const EdgeInsets.all(24),
            children: [
              MouseRegion(
                onEnter: (_) => setState(() => _drag = true),
                onExit: (_) => setState(() => _drag = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: _drag
                        ? kPrimaryGreen.withValues(alpha: 0.08)
                        : kSurfaceCard,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: kPrimaryGreen.withValues(alpha: _drag ? 0.8 : 0.4),
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.table_chart,
                          size: 48, color: kPrimaryGreen),
                      const SizedBox(height: 12),
                      Text(
                        l10n.dropExcelTitle,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      TextButton(
                        onPressed: _pick,
                        child: Text(l10n.dropExcelPick),
                      ),
                      if (_fileName != null) Text(_fileName!),
                      if (_importOutcome != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          l10n.uploadScope3Imported(_importOutcome!),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              VerdantCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.mappingTitle,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    _MappingRow(
                      excel: l10n.colColumnA,
                      field: 'kWh',
                      l10n: l10n,
                    ),
                    _MappingRow(
                      excel: l10n.colColumnB,
                      field: 'liters',
                      l10n: l10n,
                    ),
                    const SizedBox(height: 16),
                    VerdantButton(
                      label: l10n.mappingImport,
                      expand: true,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l10n.snackCalculating)),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const ManualInputPage(embed: true),
          _IntegrationsPlaceholder(l10n: l10n),
        ],
      ),
    );
  }
}

class _MappingRow extends StatelessWidget {
  const _MappingRow({
    required this.excel,
    required this.field,
    required this.l10n,
  });
  final String excel;
  final String field;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(child: Text(excel)),
          const Icon(Icons.arrow_forward, color: kTextMuted, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: DropdownButtonFormField<String>(
              value: field,
              items: [
                DropdownMenuItem(
                  value: 'kWh',
                  child: Text(l10n.fieldKwh),
                ),
                DropdownMenuItem(
                  value: 'km',
                  child: Text(l10n.fieldKm),
                ),
                DropdownMenuItem(
                  value: 'liters',
                  child: Text(l10n.fieldLitersDiesel),
                ),
              ],
              onChanged: (_) {},
              decoration: const InputDecoration(),
            ),
          ),
        ],
      ),
    );
  }
}

class _IntegrationsPlaceholder extends StatelessWidget {
  const _IntegrationsPlaceholder({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(l10n.integrationsOpenDetail));
  }
}
