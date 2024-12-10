import 'package:front_syndic/models/adress/adress.dart';

class AttributesCoOwner {
  static String uuid = 'uuid';
  static String name = 'name';
  static String adressId = 'adress_id';
  static String lotSize = 'lot_size';
  static String unionId = 'union_id';
  static String councilId = 'council_id';
  static String createdAt = 'created_at';
  static String updatedAt = 'updated';
}

class CoOwner{
   String? uuid;
   String? name;
   int? lotSize;
   String? adressId;
   String? unionId;
   String? councilId;
   Adress? adress;
   String? createdAt;
   String? updatedAt;


  CoOwner({
    this.uuid,
    this.name,
    this.lotSize,
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
      lotSize: json[AttributesCoOwner.lotSize],
      adressId: json[AttributesCoOwner.adressId],
      unionId: json[AttributesCoOwner.unionId],
      councilId: json[AttributesCoOwner.councilId],
      adress: Adress.fromJson(json['adress']),
      updatedAt: json[AttributesCoOwner.updatedAt],
      createdAt: json[AttributesCoOwner.createdAt],
    );
  }
}
