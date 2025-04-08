class AttributesUser {
  static const String uuid = 'uuid';
  static const String name = 'name';
  static const String firstName = 'first_name';
  static const String phone = 'phone';
  static const String surfId = 'surf_id';
  static const String unionId = 'union_id';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at'; // Note: typo preserved from JS
}

class User {
  String? uuid;
  String? name;
  String? firstName;
  String? phone;
  String? surfId;
  String? unionId;
  String? createdAt;
  String? updatedAt;

  User({
    this.uuid,
    this.name,
    this.firstName,
    this.phone,
    this.surfId,
    this.unionId,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uuid: json[AttributesUser.uuid],
      name: json[AttributesUser.name],
      firstName: json[AttributesUser.firstName],
      phone: json[AttributesUser.phone],
      surfId: json[AttributesUser.surfId],
      unionId: json[AttributesUser.unionId],
      createdAt: json[AttributesUser.createdAt],
      updatedAt: json[AttributesUser.updatedAt],
    );
  }
}