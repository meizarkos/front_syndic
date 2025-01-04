import 'dart:convert';

import 'package:front_syndic/api_handler/request_with_body.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/co_owner/co_owner.dart';

Future<void> patchCoOwner(String route,CoOwner coOwner) async {
  try{
    final body = jsonEncode({
      "name": coOwner.name,
      "lot_size": coOwner.lotSize,
      "first_name": coOwner.council?.firstName,
      "last_name": coOwner.council?.lastName,
      "phone": coOwner.council?.phone
    });
    final res = await requestWithBody(url: route, method: "PATCH", body: body);
    print(res.data);
    return;
  }
  catch(e){
    return;
  }
}

Future<void> patchCoOwnerFromCouncil(String? _,CoOwner coOwner)async{
  return await patchCoOwner('${APIValue.unionCouncil}co_owner_current',coOwner);
}

Future<void> patchCoOwnerFromUnion(String? councilId,CoOwner coOwner)async{
  if(councilId == null){
    return;
  }
  return await patchCoOwner('${APIValue.union}co_owner_current_from_union/$councilId',coOwner);
}