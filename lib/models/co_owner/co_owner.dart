class AttributesCoOwner {
  static String uuid = 'uuid';
  static String name = 'name';
  static String adress_id = 'adress_id';
  static String syndic_id = 'syndic_id';
  // static String council_id = 'council_id';
  static String createdAt = 'created_at';
  static String updatedAt = 'updated';
}

class CoOwner{
  final String? uuid;
  final String? name;
  final String? adressId;
  final String? syndicId;
  // final String? councilId;
  final String? createdAt;
  final String? updatedAt;


  const CoOwner({
    required this.uuid,
    required this.name,
    required this.adressId,
    required this.syndicId,
    required this.updatedAt,
    required this.createdAt,
  });

  factory CoOwner.fromJson(Map<String, dynamic> json) {
    return CoOwner(
      uuid: json[AttributesCoOwner.uuid],
      name: json[AttributesCoOwner.name],
      adressId: json[AttributesCoOwner.adress_id],
      syndicId: json[AttributesCoOwner.syndic_id],
      // councilId: json[attributesCoOwner.council_id],
      updatedAt: json[AttributesCoOwner.updatedAt],
      createdAt: json[AttributesCoOwner.createdAt],
    );
  }
}
