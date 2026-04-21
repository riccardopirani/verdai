class Company {
  const Company({
    required this.id,
    required this.userId,
    required this.name,
    this.vatNumber,
    this.sector,
    this.size,
    this.country = 'IT',
    this.website,
    this.logoUrl,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String userId;
  final String name;
  final String? vatNumber;
  final String? sector;
  final String? size;
  final String country;
  final String? website;
  final String? logoUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      name: json['name'] as String,
      vatNumber: json['vat_number'] as String?,
      sector: json['sector'] as String?,
      size: json['size'] as String?,
      country: json['country'] as String? ?? 'IT',
      website: json['website'] as String?,
      logoUrl: json['logo_url'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'name': name,
        'vat_number': vatNumber,
        'sector': sector,
        'size': size,
        'country': country,
        'website': website,
        'logo_url': logoUrl,
      };
}
