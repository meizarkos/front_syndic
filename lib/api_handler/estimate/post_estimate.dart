import 'dart:convert';

import 'package:front_syndic/api_handler/request_with_body.dart';
import 'package:front_syndic/models/estimate/estimate.dart';

import '../../core_value.dart';

Future<void> postEstimate(String route,Estimate estimate) async {
  try{
    final body = jsonEncode({
      AttributesEstimate.price: estimate.price,
      AttributesEstimate.commentary: estimate.commentary,
      AttributesEstimate.description: estimate.description,
    });
    final response = await requestWithBody(url: route, method: "POST", body: body);
    return;
  } catch(e) {
    return;
  }
}

Future<void> postEstimateArtisan(Estimate estimate) async {
  if(estimate.conversationId == null) {
    return;
  }
  return await postEstimate('${APIValue.artisan}estimate_artisan/${estimate.conversationId}',estimate);
}