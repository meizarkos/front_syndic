import 'package:front_syndic/models/adress/adress.dart';

class AttributesCoOwner {
  static String uuid = 'uuid';
  static String name = 'name';
  static String adressId = 'adress_id';
  static String unionId = 'union_id';
  static String councilId = 'council_id';
  static String createdAt = 'created_at';
  static String updatedAt = 'updated';
}

class CoOwner{
  final String? uuid;
  final String? name;
  final String? adressId;
  final String? unionId;
  final String? councilId;
  final Adress? adress;
  final String? createdAt;
  final String? updatedAt;


  const CoOwner({
    this.uuid,
    this.name,
    this.adressId,
    this.unionId,
    this.councilId,
    this.adress,
    this.updatedAt,
    this.createdAt,
  });

  factory CoOwner.fromJson(Map<String, dynamic> json) {
    return CoOwner(
      uuid: json[AttributesCoOwner.uuid],
      name: json[AttributesCoOwner.name],
      adressId: json[AttributesCoOwner.adressId],
      unionId: json[AttributesCoOwner.unionId],
      councilId: json[AttributesCoOwner.councilId],
      adress: Adress.fromJson(json['adress']),
      updatedAt: json[AttributesCoOwner.updatedAt],
      createdAt: json[AttributesCoOwner.createdAt],
    );
  }
}
