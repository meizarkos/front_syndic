import 'dart:convert';

import 'package:front_syndic/api_handler/request_with_body.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/timing/timing_estimate.dart';

Future<void> postTimingEstimate(String route,TimingEstimate timingEstimate) async {
  try{
    final body = jsonEncode({
      AttributesTimingEstimate.dateStart: timingEstimate.dateStart,
      AttributesTimingEstimate.timeStart: timingEstimate.timeStart,
      AttributesTimingEstimate.dateEnd: timingEstimate.dateEnd,
    });
    final response = await requestWithBody(url: route, method: "POST",body: body);
    print(response);
    return;
  } catch(e) {
    return;
  }
}

Future<void> postTimingEstimateArtisan(TimingEstimate timingEstimate) async {
  return postTimingEstimate('${APIValue.artisan}timing_estimate_artisan/${timingEstimate.conversationId}', timingEstimate);
}

Future<void> postTimingEstimateUnion(TimingEstimate timingEstimate) async {
  return postTimingEstimate('${APIValue.union}timing_estimate_union/${timingEstimate.conversationId}', timingEstimate);
}

Future<void> postTimingEstimateCouncil(TimingEstimate timingEstimate) async {
  return postTimingEstimate('${APIValue.unionCouncil}timing_estimate_council/${timingEstimate.conversationId}', timingEstimate);
}


Future<void> postTimingEstimateUser(TimingEstimate timingEstimate) async {
  return postTimingEstimate('${APIValue.user}timing_estimate_user/${timingEstimate.conversationId}', timingEstimate);
}