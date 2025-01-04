import 'dart:convert';

import 'package:front_syndic/api_handler/request_with_body.dart';

import '../../core_value.dart';
import '../../models/union/union.dart';

Future<bool> isSiretUnique(String? siret) async {
  try {
    final body = jsonEncode({
      AttributesUnion.siretNumber: siret,
    });
    final res = await requestWithBody(url: '${APIValue.union}is_siret_unique', method: "POST", body: body);
    print(body);
    print(res);
    if(res.statusCode == 200)return true;
    return false;
  } catch (e) {
    return false;
  }
}