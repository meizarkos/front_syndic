import 'dart:convert';

import 'package:front_syndic/api_handler/request_with_body.dart';
import 'package:front_syndic/models/surf/surf.dart';

import '../../core_value.dart';

Future<void> patchSurf(String route, Surf surf)async{
  try{
    final body = jsonEncode({
      'email': surf.email,
      'password': surf.passwd,
    });
    final res = await requestWithBody(url: route, method:"PATCH", body: body);
    return;
  }
  catch(e){
    return;
  }
}

Future<void> patchSurfArtisan(Surf surf)async{
  return await patchSurf('${APIValue.artisan}surf_artisan', surf);
}