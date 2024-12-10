class AttributesAdress {
  static String uuid = "uuid";
  static String country = "country";
  static String city = "city";
  static String street = "street";
  static String postalCode = "postal_code";
  static String region = "region";
  static String comment = "comment";
  static String createdAt = "created_at";
  static String updatedAt = "updated_at";
}

class Adress{
   String? uuid;
   String? country;
   String? city;
   String? street;
   String? postalCode;
   String? region;
   String? comment;
   String? createdAt;
   String? updatedAt;

  Adress({
    this.uuid,
    this.country,
    this.city,
    this.region,
    this.postalCode,
    this.street,
    this.comment,
    this.updatedAt,
    this.createdAt,
  });

  factory Adress.fromJson(Map<String, dynamic> json) {
    return Adress(
      uuid: json[AttributesAdress.uuid],
      country: json[AttributesAdress.country],
      city: json[AttributesAdress.city],
      region: json[AttributesAdress.region],
      postalCode: json[AttributesAdress.postalCode],
      street: json[AttributesAdress.street],
      comment: json[AttributesAdress.comment],
      updatedAt: json[AttributesAdress.updatedAt],
      createdAt: json[AttributesAdress.createdAt],
    );
  }
}
