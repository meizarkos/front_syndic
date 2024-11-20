

class AttributesCouncil{
 static const String uuid = 'uuid';
 static const String lastName = 'last_name';
 static const String firstName = 'first_name';
 static const String phone = 'phone';
 static const String unionId = 'union_id';
 static const String createdAt = 'created_at';
 static const String updatedAt = 'upadated_at';
}

class Council{
 final String? uuid;
 final String? lastName;
 final String? firstName;
 final String? phone;
 final String? unionId;
 final String? createdAt;
 final String? updatedAt;

 const Council({
   this.uuid,
   this.lastName,
   this.firstName,
   this.phone,
   this.unionId,
   this.createdAt,
   this.updatedAt,
 });

 factory Council.fromJson(Map<String, dynamic> json) {
   return Council(
     uuid: json[AttributesCouncil.uuid],
     lastName: json[AttributesCouncil.lastName],
     firstName: json[AttributesCouncil.firstName],
     phone: json[AttributesCouncil.phone],
     unionId: json[AttributesCouncil.unionId],
     createdAt: json[AttributesCouncil.createdAt],
     updatedAt: json[AttributesCouncil.updatedAt],
   );
 }
}