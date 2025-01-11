import 'dart:ui';

import 'package:front_syndic/core_value.dart';
import '../request.dart';

Future<void> patchEstimateRequest(String route, VoidCallback changeTextButton) async {
  try{
    final response = await request(url: route, method: "PATCH");
    print(response.data);
    if(response.statusCode == 200){
      changeTextButton();
      return;
    }
    return;
  } catch(e) {
    return;
  }
}

Future<void> patchEstimateCouncil(String? uuid,VoidCallback changeText) async {
  if(uuid == null) return;
  return await patchEstimateRequest('${APIValue.unionCouncil}change_status_estimate_council/$uuid',changeText);
}

Future<void> patchEstimateUnion(String? uuid,VoidCallback changeText) async {
  if(uuid == null) return;
  return await patchEstimateRequest('${APIValue.union}change_status_estimate_union/$uuid',changeText);
}

Future<void> refuseEstimateUnion(String? uuid,VoidCallback changeText) async {
  if(uuid == null) return;
  return await patchEstimateRequest('${APIValue.union}refuse_estimate_union/$uuid',changeText);
}

Future<void> refuseEstimateCouncil(String? uuid,VoidCallback changeText) async {
  if(uuid == null) return;
  return await patchEstimateRequest('${APIValue.unionCouncil}refuse_estimate_council/$uuid',changeText);
}