import 'dart:convert';

import 'package:front_syndic/api_handler/request_with_body.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/co_owner/co_owner.dart';

Future<void> patchCoOwner(CoOwner coOwner) async {
  try{
    final body = jsonEncode({
      "name": coOwner.name,
      "lot_size": coOwner.lotSize,
      "first_name": coOwner.council?.firstName,
      "last_name": coOwner.council?.lastName,
      "phone": coOwner.council?.phone
    });
    final res = await requestWithBody(url: '${APIValue.unionCouncil}co_owner_current', method: "PATCH", body: body);
    print(res.data);
    return;
  }
  catch(e){
    return;
  }
}