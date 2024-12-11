import 'dart:convert';

import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/adress/adress.dart';
import 'package:front_syndic/models/co_owner/co_owner.dart';
import 'package:front_syndic/models/council/createCouncil.dart';

import '../../models/council/council.dart';
import '../request_with_body.dart';

Future<void> postCouncilUnion(CreateCouncil createCouncil)async{
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
    final response = await requestWithBody(url: '${APIValue.union}register_council_from_union', method: "POST", body: body);
    return;
  }
  catch(e){
    return;
  }
}