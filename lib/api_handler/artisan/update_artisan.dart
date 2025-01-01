import 'dart:convert';

import 'package:front_syndic/api_handler/request_with_body.dart';
import 'package:front_syndic/core_value.dart';

import '../../models/artisan/artisan.dart';

Future<void> updateArtisanApi(Artisan artisan)async {
  try{
    final body = jsonEncode({
      AttributesArtisan.companyName : artisan.companyName,
      AttributesArtisan.firstName : artisan.firstName,
      AttributesArtisan.lastName : artisan.lastName,
      AttributesArtisan.siretNumber : artisan.siretNumber,
      AttributesArtisan.phone : artisan.phone,
    });
    final res = await requestWithBody(url: "${APIValue.artisan}artisan", method: "PATCH", body: body);
    return;
  }catch(e){
    rethrow;
  }
}