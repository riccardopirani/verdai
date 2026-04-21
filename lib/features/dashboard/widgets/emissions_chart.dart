import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:verdant/l10n/app_localizations.dart';

import '../../../core/theme/colors.dart';
import '../../../services/esg_automation_service.dart';
import '../../../shared/widgets/verdant_card.dart';

class EmissionsChart extends StatefulWidget {
  const EmissionsChart({super.key});

  @override
  State<EmissionsChart> createState() => _EmissionsChartState();
}

class _EmissionsChartState extends State<EmissionsChart> {
  int _mode = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final yoy = EsgAutomationService.instance.yearOverYear();

    return VerdantCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.emissionsChartTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              SegmentedButton<int>(
                segments: [
                  ButtonSegment(
                    value: 0,
                    label: Text(l10n.chartModeMonth),
                  ),
                  ButtonSegment(
                    value: 1,
                    label: Text(l10n.chartModeQuarter),
                  ),
                  ButtonSegment(
                    value: 2,
                    label: Text(l10n.chartModeYear),
                  ),
                ],
                selected: {_mode},
                onSelectionChanged: (s) => setState(() => _mode = s.first),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 220,
            child: LineChart(
              LineChartData(
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      getTitlesWidget: (v, m) {
                        final idx = v.toInt();
                        if (idx < 0 || idx >= yoy.length) {
                          return const SizedBox.shrink();
                        }
                        return Text(
                          '${yoy[idx].year}',
                          style:
                              const TextStyle(color: kTextMuted, fontSize: 11),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 36,
                      getTitlesWidget: (v, m) => Text(
                        '${v.toInt()}',
                        style: const TextStyle(color: kTextMuted, fontSize: 11),
                      ),
                    ),
                  ),
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 20,
                  getDrawingHorizontalLine: (v) => FlLine(
                    color: kBorderSubtle.withValues(alpha: 0.4),
                    strokeWidth: 1,
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  _line(
                      yoy.map((e) => e.scope1Kg / 1000).toList(), kLeafAccent),
                  _line(yoy.map((e) => e.scope2Kg / 1000).toList(), kInfo),
                  _line(yoy.map((e) => e.scope3Kg / 1000).toList(), kWarning),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            children: [
              _Legend(color: kLeafAccent, label: l10n.scope1),
              _Legend(color: kInfo, label: l10n.scope2),
              _Legend(color: kWarning, label: l10n.scope3),
            ],
          ),
        ],
      ),
    );
  }

  LineChartBarData _line(List<double> ys, Color c) {
    return LineChartBarData(
      spots: [for (var i = 0; i < ys.length; i++) FlSpot(i.toDouble(), ys[i])],
      color: c,
      barWidth: 2.5,
      dotData: const FlDotData(show: false),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend({required this.color, required this.label});
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
