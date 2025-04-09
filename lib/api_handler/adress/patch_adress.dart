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

Future<void> patchAdressWorkRequestFromUnion(String? workRequestUuid,Adress adress)async{
  if(workRequestUuid == null){
    return;
  }
  return await patchAdress("${APIValue.union}adress_union/$workRequestUuid", adress);
}

Future<void> patchAdressWorkRequestForCouncil(String? workRequestUuid,Adress adress)async{
  if(workRequestUuid == null){
    return;
  }
  return await patchAdress("${APIValue.unionCouncil}adress_council/$workRequestUuid", adress);
}

Future<void> patchAdressCouncilFromUnion(String? councilId,Adress adress)async{
  if(councilId == null){
    return;
  }
  return await patchAdress("${APIValue.union}adress_council_from_union/$councilId", adress);
}

Future<void> patchAdressUserFromUnion(String? apartmentId,Adress adress)async{
  if(apartmentId == null){
    return;
  }
  return await patchAdress("${APIValue.union}adress_user_from_union/$apartmentId", adress);
}

Future<void> patchAdressArtisan(String? useless,Adress adress)async{
  return await patchAdress("${APIValue.artisan}adress_artisan", adress);
}

Future<void> patchAdressCouncil(String? useless,Adress adress)async{
  return await patchAdress("${APIValue.unionCouncil}adress_council", adress);
}

Future<void> patchAdressUnion(String? useless,Adress adress)async{
  return await patchAdress("${APIValue.union}adress_union", adress);
}

