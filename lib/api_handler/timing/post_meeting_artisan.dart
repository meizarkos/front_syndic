import 'dart:convert';

import 'package:front_syndic/api_handler/request_with_body.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/timing/timing.dart';

Future<void> postTimingFromWorkRequestArtisan(String? uuid,Timing timing) async {
  if(uuid == null){
    return;
  }
  try{
    final body = jsonEncode({
        AttributesTiming.date: timing.date,
        AttributesTiming.time: timing.time,
      });
    await requestWithBody(url: '${APIValue.artisan}meeting/$uuid', method: "POST", body: body);
    return;
  } catch(e) {
    return;
  }
}
