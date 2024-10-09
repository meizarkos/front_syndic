import 'package:front_syndic/models/adress/adress.dart';

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
  final Adress? adress;
  final String? createdAt;
  final String? updatedAt;


  const CoOwner({
    this.uuid,
    this.name,
    this.adressId,
    this.syndicId,
    // this.councilId,
    this.adress,
    this.updatedAt,
    this.createdAt,
  });

  factory CoOwner.fromJson(Map<String, dynamic> json) {
    return CoOwner(
      uuid: json[AttributesCoOwner.uuid],
      name: json[AttributesCoOwner.name],
      adressId: json[AttributesCoOwner.adress_id],
      syndicId: json[AttributesCoOwner.syndic_id],
      // councilId: json[attributesCoOwner.council_id],
      adress: Adress.fromJson(json['adress']),
      updatedAt: json[AttributesCoOwner.updatedAt],
      createdAt: json[AttributesCoOwner.createdAt],
    );
  }
}
