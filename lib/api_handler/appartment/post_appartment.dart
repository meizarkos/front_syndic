import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/user/createUser.dart';

import '../../models/adress/adress.dart';
import '../../models/user/user.dart';
import '../request_with_body.dart';

Future<Response<dynamic>?> postUser(CreateUser createUser)async{
  try{
    final body = jsonEncode({
      "adress" : {
        AttributesAdress.country : createUser.adress.country,
        AttributesAdress.city : createUser.adress.city,
        AttributesAdress.street : createUser.adress.street,
        AttributesAdress.postalCode : createUser.adress.postalCode,
        AttributesAdress.region : createUser.adress.region,
        AttributesAdress.comment : createUser.adress.comment,
      },
      "surf" : {
        "email" : createUser.email,
      },
      "user" : {
        AttributesUser.firstName : createUser.user.firstName,
        AttributesUser.name : createUser.user.name,
        AttributesUser.phone : createUser.user.phone,
      },
    });
    final response = await requestWithBody(url: '${APIValue.union}register_user_from_union', method: "POST", body: body);
    return null;
  }
  catch(e){
    print(e);
    return null;
  }
}