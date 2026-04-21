/// Emission factors (illustrative — validate against official DEFRA / national sources for production).
class CO2CalculatorService {
  static const Map<String, double> electricityFactors = {
    'IT': 0.233,
    'DE': 0.366,
    'FR': 0.052,
    'EU_avg': 0.276,
  };

  static const Map<String, double> fuelFactors = {
    'diesel': 2.68,
    'petrol': 2.31,
    'lpg': 1.51,
    'cng': 2.04,
  };

  static const double naturalGasFactor = 2.04;

  double calculateScope1({
    required double dieselLiters,
    required double petrolLiters,
    required double naturalGasM3,
  }) {
    return (dieselLiters * fuelFactors['diesel']!) +
        (petrolLiters * fuelFactors['petrol']!) +
        (naturalGasM3 * naturalGasFactor);
  }

  double calculateScope2({
    required double electricityKwh,
    required String country,
  }) {
    final factor = electricityFactors[country] ?? electricityFactors['EU_avg']!;
    return electricityKwh * factor;
  }

  /// Simple illustrative score: lower intensity + sector baseline.
  double calculateESGScore({
    required double totalCO2Tons,
    required int employees,
    required String sector,
  }) {
    if (employees <= 0) return 50;
    final tonsPerEmployee = totalCO2Tons / employees;
    double sectorBaseline = 12;
    switch (sector.toLowerCase()) {
      case 'manifatturiero':
      case 'manufacturing':
        sectorBaseline = 18;
        break;
      case 'logistica':
      case 'logistics':
        sectorBaseline = 22;
        break;
      case 'retail':
        sectorBaseline = 8;
        break;
      case 'servizi':
      case 'services':
        sectorBaseline = 6;
        break;
    }
    final ratio = (sectorBaseline - tonsPerEmployee) / sectorBaseline;
    final score = 50 + (ratio.clamp(-1.0, 1.0) * 45);
    return score.clamp(0, 100);
  }
}
