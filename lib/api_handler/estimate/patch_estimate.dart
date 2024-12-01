import 'dart:convert';

import 'package:front_syndic/api_handler/request_with_body.dart';

import '../../core_value.dart';
import '../../models/estimate/estimate.dart';

Future<void> patchEstimate(String route,Estimate estimate) async {
  try{
    final body = jsonEncode({
      AttributesEstimate.price: estimate.price,
      AttributesEstimate.commentary: estimate.commentary,
      AttributesEstimate.description: estimate.description,
    });
    final response = await requestWithBody(url: route, method: "PATCH", body: body);
    return;
  } catch(e) {
    return;
  }
}

Future<void> patchEstimateArtisan(Estimate estimate) async {
  if(estimate.uuid == null) return;
  return await patchEstimate('${APIValue.artisan}estimate_detail_artisan/${estimate.uuid}',estimate);
}