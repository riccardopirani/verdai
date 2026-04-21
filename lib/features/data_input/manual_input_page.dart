import 'package:flutter/material.dart';
import 'package:verdant/l10n/app_localizations.dart';

import '../../core/theme/colors.dart';
import '../../services/co2_calculator_service.dart';
import '../../services/esg_automation_service.dart';
import '../../shared/widgets/verdant_button.dart';
import '../../shared/widgets/verdant_card.dart';
import '../../shared/widgets/verdant_input.dart';

class ManualInputPage extends StatefulWidget {
  const ManualInputPage({super.key, this.embed = false});

  final bool embed;

  @override
  State<ManualInputPage> createState() => _ManualInputPageState();
}

class _ManualInputPageState extends State<ManualInputPage> {
  String _category = 'Energy';
  final _kwh = TextEditingController();
  final _km = TextEditingController();
  final _diesel = TextEditingController();
  final List<String> _rows = [];

  @override
  void dispose() {
    _kwh.dispose();
    _km.dispose();
    _diesel.dispose();
    super.dispose();
  }

  String _categoryLabel(AppLocalizations l10n, String key) {
    switch (key) {
      case 'Transport':
        return l10n.catTransportOpt;
      case 'Gas':
        return l10n.catGas;
      case 'Water':
        return l10n.catWater;
      case 'Waste':
        return l10n.catWaste;
      case 'Suppliers':
        return l10n.catSuppliersOpt;
      case 'Energy':
      default:
        return l10n.catEnergyOpt;
    }
  }

  void _add(AppLocalizations l10n) {
    final calc = CO2CalculatorService();
    final co2 = _category == 'Energy'
        ? calc.calculateScope2(
            electricityKwh: double.tryParse(_kwh.text) ?? 0,
            country: 'IT',
          )
        : calc.calculateScope1(
              dieselLiters: double.tryParse(_diesel.text) ?? 0,
              petrolLiters: 0,
              naturalGasM3: 0,
            ) +
            (double.tryParse(_km.text) ?? 0) * 0.2;
    final scope = _category == 'Energy'
        ? 2
        : _category == 'Suppliers'
            ? 3
            : 1;
    EsgAutomationService.instance.addManualEmission(scope: scope, co2Kg: co2);
    setState(() {
      _rows.insert(
        0,
        '${_categoryLabel(l10n, _category)} • ${co2.toStringAsFixed(1)} ${l10n.unitCo2eKg}',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    final body = ListView(
      padding: const EdgeInsets.all(24),
      children: [
        VerdantCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.manualTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _category,
                items: [
                  DropdownMenuItem(
                    value: 'Energy',
                    child: Text(l10n.catEnergyOpt),
                  ),
                  DropdownMenuItem(
                    value: 'Transport',
                    child: Text(l10n.catTransportOpt),
                  ),
                  DropdownMenuItem(value: 'Gas', child: Text(l10n.catGas)),
                  DropdownMenuItem(value: 'Water', child: Text(l10n.catWater)),
                  DropdownMenuItem(value: 'Waste', child: Text(l10n.catWaste)),
                  DropdownMenuItem(
                    value: 'Suppliers',
                    child: Text(l10n.catSuppliersOpt),
                  ),
                ],
                onChanged: (v) => setState(() => _category = v ?? 'Energy'),
                decoration: InputDecoration(labelText: l10n.manualCategory),
              ),
              if (_category == 'Energy') ...[
                VerdantInput(
                  label: l10n.manualKwh,
                  controller: _kwh,
                  keyboardType: TextInputType.number,
                ),
              ] else ...[
                VerdantInput(
                  label: l10n.manualKm,
                  controller: _km,
                  keyboardType: TextInputType.number,
                ),
                VerdantInput(
                  label: l10n.manualDieselL,
                  controller: _diesel,
                  keyboardType: TextInputType.number,
                ),
              ],
              const SizedBox(height: 12),
              VerdantButton(
                label: l10n.manualAdd,
                expand: true,
                onPressed: () => _add(l10n),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        VerdantCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.manualRecords,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              for (final r in _rows)
                ListTile(
                  title: Text(r),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => setState(() => _rows.remove(r)),
                  ),
                ),
            ],
          ),
        ),
      ],
    );

    if (widget.embed) return body;

    return Scaffold(
      backgroundColor: kSurface,
      body: body,
    );
  }
}
