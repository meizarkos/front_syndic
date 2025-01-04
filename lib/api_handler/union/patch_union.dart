import 'dart:convert';

import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/union/union.dart';

import '../request_with_body.dart';

Future<void> patchUnion(UnionApi union)async{
  // "/patch_union"
  try{
    final body = jsonEncode({
      AttributesUnion.name: union.name,
      AttributesUnion.siretNumber: union.siretNumber,
      AttributesUnion.phone: union.phone,
      AttributesUnion.administratorName: union.administratorName,
      AttributesUnion.administratorFirstName: union.administratorFirstName,
    });
    final response = await requestWithBody(url: '${APIValue.union}union_current', method: "PATCH", body: body);
    return;
  }
  catch(e){
    return;
  }
}