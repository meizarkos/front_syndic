import 'dart:convert';

import 'package:front_syndic/api_handler/request_with_body.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/timing/timing.dart';

Future<void> postTiming(String? uuid,Timing timing,String route) async {
  if(uuid == null){
    return;
  }
  try{
    final body = jsonEncode({
        AttributesTiming.date: timing.date,
        AttributesTiming.time: timing.time,
      });

    await requestWithBody(url: route, method: "POST", body: body);
    return;
  } catch(e) {
    return;
  }
}

Future<void> postTimingFromWorkRequestArtisan(String? uuid,Timing timing) async {
  await postTiming(uuid, timing,'${APIValue.artisan}timing_artisan_from_first_conv/$uuid');
}

Future<void> postTimingFromConvArtisan(String? uuid,Timing timing) async {
  await postTiming(uuid, timing,'${APIValue.artisan}timing_artisan/$uuid');
}

Future<void> postTimingFromConvCouncil(String? uuid,Timing timing) async {
  await postTiming(uuid, timing,'${APIValue.unionCouncil}timing_council/$uuid');
}

