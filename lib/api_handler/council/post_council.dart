import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/adress/adress.dart';
import 'package:front_syndic/models/co_owner/co_owner.dart';
import 'package:front_syndic/models/council/createCouncil.dart';

import '../../models/council/council.dart';
import '../request_with_body.dart';

Future<Response<dynamic>?> postCouncil(CreateCouncil createCouncil, String route)async{
  try{
    final body = jsonEncode({
      "adress" : {
        AttributesAdress.country : createCouncil.adress.country,
        AttributesAdress.city : createCouncil.adress.city,
        AttributesAdress.street : createCouncil.adress.street,
        AttributesAdress.postalCode : createCouncil.adress.postalCode,
        AttributesAdress.region : createCouncil.adress.region,
        AttributesAdress.comment : createCouncil.adress.comment,
      },
      "surf" : {
        "email" : createCouncil.email,
        "password" : createCouncil.password,
      },
      "council" : {
        AttributesCouncil.firstName : createCouncil.council.firstName,
        AttributesCouncil.lastName : createCouncil.council.lastName,
        AttributesCouncil.phone : createCouncil.council.phone,
      },
      "co_owner" : {
        AttributesCoOwner.name : createCouncil.coOwner.name,
        AttributesCoOwner.lotSize : createCouncil.coOwner.lotSize,
      }
    });
    final response = await requestWithBody(url: route, method: "POST", body: body);
    return response;
  }
  catch(e){
    return null;
  }
}

Future<void> postCouncilUnion(CreateCouncil createCouncil)async{
  final response = await postCouncil(createCouncil, '${APIValue.union}register_council_from_union');
}

Future<String> registerCouncil(CreateCouncil createCouncil)async{
  final response = await postCouncil(createCouncil, 'register_council');
  if(response == null){
    return '';
  }
  return response.data['token'];
}