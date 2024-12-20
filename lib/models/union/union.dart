class AttributesUnion {
  static const String id = 'id';
  static const String name = 'name';
  static const String uuid = 'uuid';
  static const String administratorName = 'administrator_name';
  static const String administratorFirstName = 'administrator_first_name';
  static const String siretNumber = 'siret_number';
  static const String phone = 'phone';
  static const String adressId = 'adress_id';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'upadated_at';
}

class UnionApi {
   int? id;
   String? name;
   String? uuid;
   String? administratorName;
   String? administratorFirstName;
   String? siretNumber;
   String? phone;
   String? adressId;
   String? createdAt;
   String? updatedAt;

   UnionApi({
    this.id,
    this.name,
    this.uuid,
    this.administratorName,
    this.administratorFirstName,
    this.siretNumber,
    this.phone,
    this.adressId,
    this.createdAt,
    this.updatedAt,
  });

  factory UnionApi.fromJson(Map<String, dynamic> json) {
    return UnionApi(
      id: json[AttributesUnion.id],
      name: json[AttributesUnion.name],
      uuid: json[AttributesUnion.uuid],
      administratorName: json[AttributesUnion.administratorName],
      administratorFirstName: json[AttributesUnion.administratorFirstName],
      siretNumber: json[AttributesUnion.siretNumber],
      phone: json[AttributesUnion.phone],
      adressId: json[AttributesUnion.adressId],
      createdAt: json[AttributesUnion.createdAt],
      updatedAt: json[AttributesUnion.updatedAt],
    );
  }
}
