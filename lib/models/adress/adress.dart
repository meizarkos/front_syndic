class AttributesAdress {
  static String uuid = "uuid";
  static String country = "country";
  static String city = "city";
  static String location = "location";
  static String postalCode = "postal_code";
  static String region = "region";
  static String comment = "comment";
  static String createdAt = "created_at";
  static String updatedAt = "updated_at";
}

class Adress{
  final String? uuid;
  final String? country;
  final String? city;
  final String? adress;
  final String? postalCode;
  final String? region;
  final String? comment;
  final String? createdAt;
  final String? updatedAt;

  const Adress({
    required this.uuid,
    required this.country,
    required this.city,
    required this.region,
    required this.postalCode,
    required this.adress,
    required this.comment,
    required this.updatedAt,
    required this.createdAt,
  });

  factory Adress.fromJson(Map<String, dynamic> json) {
    return Adress(
      uuid: json[AttributesAdress.uuid],
      country: json[AttributesAdress.country],
      city: json[AttributesAdress.city],
      region: json[AttributesAdress.region],
      postalCode: json[AttributesAdress.postalCode],
      adress: json[AttributesAdress.location],
      comment: json[AttributesAdress.comment],
      updatedAt: json[AttributesAdress.updatedAt],
      createdAt: json[AttributesAdress.createdAt],
    );
  }
}
