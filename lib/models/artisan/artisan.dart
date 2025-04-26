import '../adress/adress.dart';

class AttributesArtisan {
  static const uuid = 'uuid';
  static const companyName = 'company_name';
  static const firstName = 'first_name';
  static const lastName = 'last_name';
  static const siretNumber = 'siret_number';
  static const phone = 'phone';
  static const adress = 'adress';
  static const adressId = 'adress_id';
  static const createdAt = 'created_at';
  static const updatedAt = 'updated_at';
}

class Artisan{
   String? uuid;
   String? companyName;
   String? firstName;
   String? lastName;
   String? siretNumber;
   String? phone;
   String? adressId;
   Adress? adress;
   String? createdAt;
   String? updatedAt;

  Artisan({
    this.uuid,
    this.companyName,
    this.firstName,
    this.lastName,
    this.siretNumber,
    this.phone,
    this.adressId,
    this.adress,
    this.createdAt,
    this.updatedAt,
  });

  factory Artisan.fromJson(Map<String, dynamic> json) {
    return Artisan(
      uuid: json[AttributesArtisan.uuid],
      companyName: json[AttributesArtisan.companyName],
      firstName: json[AttributesArtisan.firstName],
      lastName: json[AttributesArtisan.lastName],
      siretNumber: json[AttributesArtisan.siretNumber],
      phone: json[AttributesArtisan.phone],
      adressId: json[AttributesArtisan.adressId],
      adress: json[AttributesArtisan.adress] != null
          ? Adress.fromJson(json[AttributesArtisan.adress])
          : null,
      createdAt: json[AttributesArtisan.createdAt],
      updatedAt: json[AttributesArtisan.updatedAt],
    );
  }
}
