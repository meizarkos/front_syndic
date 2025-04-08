import 'package:front_syndic/models/adress/adress.dart';
import 'package:front_syndic/models/user/user.dart';

class AttributesApartment {
  static const uuid = 'uuid';
  static const unionId = 'union_id';
  static const userId = 'user_id';
  static const user = 'user';
  static const adressId = 'adress_id';
  static const adress = 'adress';
  static const createdAt = 'created_at';
  static const updatedAt = 'upadated_at';
}

class Apartment{
  String? uuid;
  String? unionId;
  String? userId;
  User? user;
  String? adressId;
  Adress? adress;
  String? createdAt;
  String? updatedAt;

  Apartment({
    this.uuid,
    this.unionId,
    this.userId,
    this.user,
    this.adressId,
    this.adress,
    this.createdAt,
    this.updatedAt,
  });

  factory Apartment.fromJson(Map<String, dynamic> json) {
    return Apartment(
      uuid: json[AttributesApartment.uuid],
      unionId: json[AttributesApartment.unionId],
      userId: json[AttributesApartment.userId],
      user: json[AttributesApartment.user] != null
          ? User.fromJson(json[AttributesApartment.user])
          : null,
      adressId: json[AttributesApartment.adressId],
      adress: json[AttributesApartment.adress] != null
          ? Adress.fromJson(json[AttributesApartment.adress])
          : null,
      createdAt: json[AttributesApartment.createdAt],
      updatedAt: json[AttributesApartment.updatedAt],
    );
  }
}
