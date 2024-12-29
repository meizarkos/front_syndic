import 'dart:convert';

import 'package:front_syndic/core_value.dart';

import '../../models/adress/adress.dart';
import '../request_with_body.dart';

Future<void> patchAdress(String route, Adress adress)async{
  try{
    final body = jsonEncode({
        AttributesAdress.country: adress.country,
        AttributesAdress.city: adress.city,
        AttributesAdress.street: adress.street,
        AttributesAdress.postalCode: adress.postalCode,
        AttributesAdress.region: adress.region,
        AttributesAdress.comment: adress.comment,
    });
    final res = await requestWithBody(url: route, method: "PATCH", body: body);
    return;
  } catch(e) {
    return;
  }
}

Future<void> patchAdressUnion(String workRequestUuid,Adress adress)async{
  return await patchAdress("${APIValue.union}adress_union/$workRequestUuid", adress);
}

Future<void> patchAdressCouncil(String workRequestUuid,Adress adress)async{
  return await patchAdress("${APIValue.unionCouncil}adress_council/$workRequestUuid", adress);
}