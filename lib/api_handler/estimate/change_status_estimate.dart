import 'dart:ui';

import 'package:front_syndic/core_value.dart';
import '../request.dart';

Future<void> patchEstimateRequest(String route, VoidCallback changeTextButton) async {
  try{
    final response = await request(url: route, method: "PATCH");
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

Future<void> patchEstimateUser(String? uuid,VoidCallback changeText) async {
  if(uuid == null) return;
  return await patchEstimateRequest('${APIValue.user}change_status_estimate_user/$uuid',changeText);
}

Future<void> refuseEstimateUnion(String? uuid,VoidCallback changeText) async {
  if(uuid == null) return;
  return await patchEstimateRequest('${APIValue.union}refuse_estimate_union/$uuid',changeText);
}

Future<void> refuseEstimateCouncil(String? uuid,VoidCallback changeText) async {
  if(uuid == null) return;
  return await patchEstimateRequest('${APIValue.unionCouncil}refuse_estimate_council/$uuid',changeText);
}

Future<void> refuseEstimateUser(String? uuid,VoidCallback changeText) async {
  if(uuid == null) return;
  return await patchEstimateRequest('${APIValue.user}refuse_estimate_user/$uuid',changeText);
}