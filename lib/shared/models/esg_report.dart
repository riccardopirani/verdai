class EsgReport {
  const EsgReport({
    required this.id,
    required this.companyId,
    required this.title,
    required this.reportYear,
    required this.standard,
    this.status = 'draft',
    this.esgScore,
    this.environmentalScore,
    this.socialScore,
    this.governanceScore,
    this.totalCo2Tons,
    this.pdfUrl,
    this.createdAt,
    this.publishedAt,
  });

  final String id;
  final String companyId;
  final String title;
  final int reportYear;
  final String standard;
  final String status;
  final double? esgScore;
  final double? environmentalScore;
  final double? socialScore;
  final double? governanceScore;
  final double? totalCo2Tons;
  final String? pdfUrl;
  final DateTime? createdAt;
  final DateTime? publishedAt;

  factory EsgReport.fromJson(Map<String, dynamic> json) {
    return EsgReport(
      id: json['id'] as String,
      companyId: json['company_id'] as String,
      title: json['title'] as String,
      reportYear: (json['report_year'] as num).toInt(),
      standard: json['standard'] as String,
      status: json['status'] as String? ?? 'draft',
      esgScore: (json['esg_score'] as num?)?.toDouble(),
      environmentalScore: (json['environmental_score'] as num?)?.toDouble(),
      socialScore: (json['social_score'] as num?)?.toDouble(),
      governanceScore: (json['governance_score'] as num?)?.toDouble(),
      totalCo2Tons: (json['total_co2_tons'] as num?)?.toDouble(),
      pdfUrl: json['pdf_url'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
      publishedAt: json['published_at'] != null
          ? DateTime.tryParse(json['published_at'] as String)
          : null,
    );
  }
}
