class EmissionRecord {
  const EmissionRecord({
    required this.id,
    required this.companyId,
    required this.year,
    this.month,
    required this.scope,
    required this.category,
    this.valueKwh,
    this.valueLiters,
    this.valueKm,
    required this.co2Kg,
    this.source,
    this.notes,
    this.createdAt,
  });

  final String id;
  final String companyId;
  final int year;
  final int? month;
  final int scope;
  final String category;
  final double? valueKwh;
  final double? valueLiters;
  final double? valueKm;
  final double co2Kg;
  final String? source;
  final String? notes;
  final DateTime? createdAt;

  factory EmissionRecord.fromJson(Map<String, dynamic> json) {
    return EmissionRecord(
      id: json['id'] as String,
      companyId: json['company_id'] as String,
      year: (json['year'] as num).toInt(),
      month: (json['month'] as num?)?.toInt(),
      scope: (json['scope'] as num).toInt(),
      category: json['category'] as String,
      valueKwh: (json['value_kwh'] as num?)?.toDouble(),
      valueLiters: (json['value_liters'] as num?)?.toDouble(),
      valueKm: (json['value_km'] as num?)?.toDouble(),
      co2Kg: (json['co2_kg'] as num).toDouble(),
      source: json['source'] as String?,
      notes: json['notes'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
    );
  }
}
