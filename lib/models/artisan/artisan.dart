class AttributesArtisan {
  static const uuid = 'uuid';
  static const companyName = 'company_name';
  static const siretNumber = 'siret_number';
  static const phone = 'phone';
  static const adressId = 'adress_id';
  static const createdAt = 'created_at';
  static const upadatedAt = 'upadated_at';
}
class Artisan{
  final String? uuid;
  final String? companyName;
  final String? siretNumber;
  final String? phone;
  final String? adressId;
  final String? createdAt;
  final String? updatedAt;

  const Artisan({
    this.uuid,
    this.companyName,
    this.siretNumber,
    this.phone,
    this.adressId,
    this.createdAt,
    this.updatedAt,
  });

  factory Artisan.fromJson(Map<String, dynamic> json) {
    return Artisan(
      uuid: json[AttributesArtisan.uuid],
      companyName: json[AttributesArtisan.companyName],
      siretNumber: json[AttributesArtisan.siretNumber],
      phone: json[AttributesArtisan.phone],
      adressId: json[AttributesArtisan.adressId],
      createdAt: json[AttributesArtisan.createdAt],
      updatedAt: json[AttributesArtisan.upadatedAt],
    );
  }
}
