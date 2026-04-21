import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:verdant/l10n/app_localizations.dart';

import '../../core/theme/colors.dart';
import '../../shared/widgets/verdant_button.dart';
import '../../shared/widgets/verdant_card.dart';
import '../../shared/widgets/verdant_input.dart';

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  int _step = 0;

  final _vat = TextEditingController();
  final _name = TextEditingController();
  final _hq = TextEditingController();
  String _country = 'IT';

  String? _sector;
  final Set<String> _standards = {};

  final _kwh = TextEditingController();
  final _km = TextEditingController();
  final _employees = TextEditingController();

  String _planChoice = 'trial';

  @override
  void dispose() {
    _vat.dispose();
    _name.dispose();
    _hq.dispose();
    _kwh.dispose();
    _km.dispose();
    _employees.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: kSurface,
      appBar: AppBar(
        title: Text(l10n.onboardingTitle('${_step + 1}')),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6),
          child: TweenAnimationBuilder<double>(
            tween: Tween(end: (_step + 1) / 5),
            duration: const Duration(milliseconds: 250),
            builder: (context, v, _) => LinearProgressIndicator(
              value: v,
              color: kPrimaryGreen,
              backgroundColor: kBorderSubtle,
            ),
          ),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              VerdantCard(
                child: _body(l10n),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  if (_step > 0)
                    TextButton(
                      onPressed: () => setState(() => _step--),
                      child: Text(l10n.onboardingBack),
                    ),
                  const Spacer(),
                  VerdantButton(
                    label: _step == 4 ? l10n.onboardingFinish : l10n.onboardingNext,
                    onPressed: _next,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _next() {
    if (_step < 4) {
      setState(() => _step++);
    } else {
      if (_planChoice == 'paid') {
        context.go('/pricing');
      } else {
        context.go('/dashboard');
      }
    }
  }

  Widget _body(AppLocalizations l10n) {
    switch (_step) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.onbWelcomeTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.onbWelcomeSub,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            VerdantInput(
              label: l10n.onbVat,
              hint: l10n.onbVatHint,
              controller: _vat,
            ),
            const SizedBox(height: 12),
            VerdantInput(
              label: l10n.onbLegalName,
              controller: _name,
            ),
            const SizedBox(height: 12),
            VerdantInput(
              label: l10n.onbAddress,
              controller: _hq,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _country,
              decoration: InputDecoration(labelText: l10n.onbCountry),
              items: [
                DropdownMenuItem(value: 'IT', child: Text(l10n.countryIT)),
                DropdownMenuItem(value: 'DE', child: Text(l10n.countryDE)),
                DropdownMenuItem(value: 'FR', child: Text(l10n.countryFR)),
              ],
              onChanged: (v) => setState(() => _country = v ?? 'IT'),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.onbDemoNote,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        );
      case 1:
        final sectors = <(String, String)>[
          ('Manufacturing', '🏭'),
          ('Logistics', '🚛'),
          ('Retail', '🛍️'),
          ('Food', '🌾'),
          ('Construction', '🏗️'),
          ('Energy', '⚡'),
          ('Services', '💼'),
          ('Other', '➕'),
        ];
        String labelFor(String key) {
          switch (key) {
            case 'Manufacturing':
              return l10n.onbSectorManufacturing;
            case 'Logistics':
              return l10n.onbSectorLogistics;
            case 'Retail':
              return l10n.onbSectorRetail;
            case 'Food':
              return l10n.onbSectorFood;
            case 'Construction':
              return l10n.onbSectorConstruction;
            case 'Energy':
              return l10n.onbSectorEnergy;
            case 'Services':
              return l10n.onbSectorServices;
            case 'Other':
            default:
              return l10n.onbSectorOther;
          }
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.onbSectorTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (final s in sectors)
                  ChoiceChip(
                    label: Text('${s.$2} ${labelFor(s.$1)}'),
                    selected: _sector == s.$1,
                    onSelected: (_) => setState(() => _sector = s.$1),
                  ),
              ],
            ),
          ],
        );
      case 2:
        final opts = <(String, String)>[
          ('csrd', l10n.stdCsrd),
          ('issb', l10n.stdIssb),
          ('cdp', l10n.stdCdp),
          ('gri', l10n.stdGri),
          ('ecovadis', l10n.stdEcovadis),
          ('unknown', l10n.stdUnknown),
        ];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.onbStandardsTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            for (final o in opts)
              CheckboxListTile(
                value: _standards.contains(o.$1),
                onChanged: (v) => setState(() {
                  if (v ?? false) {
                    _standards.add(o.$1);
                  } else {
                    _standards.remove(o.$1);
                  }
                }),
                title: Text(o.$2),
                controlAffinity: ListTileControlAffinity.leading,
              ),
          ],
        );
      case 3:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.onbDataTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            VerdantInput(
              label: l10n.onbEnergy2023,
              controller: _kwh,
              keyboardType: TextInputType.number,
            ),
            VerdantInput(
              label: l10n.onbFleetKm2023,
              controller: _km,
              keyboardType: TextInputType.number,
            ),
            VerdantInput(
              label: l10n.onbEmployees,
              controller: _employees,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.onbDataHint,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        );
      default:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.onbPlanTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.onbPlanSub,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            RadioListTile<String>(
              value: 'trial',
              groupValue: _planChoice,
              onChanged: (v) => setState(() => _planChoice = v ?? 'trial'),
              title: Text(l10n.onbPlanTrial),
            ),
            RadioListTile<String>(
              value: 'paid',
              groupValue: _planChoice,
              onChanged: (v) => setState(() => _planChoice = v ?? 'trial'),
              title: Text(l10n.onbPlanPaid),
            ),
          ],
        );
    }
  }
}
