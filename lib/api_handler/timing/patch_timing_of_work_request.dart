import 'dart:convert';

import 'package:front_syndic/api_handler/request_with_body.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/timing/timing.dart';

import '../../utils/date_to_string/date.dart';

Future<void> patchTimingFromWorkRequest(String route,List<Timing>? timings) async {
  if(timings == null || timings.isEmpty){
    return;
  }
  try{
    final body = jsonEncode({
      "timings" : timings.map((timing) => {
        AttributesTiming.uuid: timing.uuid,
        AttributesTiming.date: formatStringToApiDate(timing.date, "yyyy-MM-dd"),
        AttributesTiming.time: timing.time,
      }).toList(),
    });
    final res = await requestWithBody(url: route, method: "PATCH", body: body);
    return;
  } catch(e) {
    return;
  }
}

Future<void> patchTimingFromWorkRequestCouncil(String uuid,List<Timing>? timings) async {
  return await patchTimingFromWorkRequest('${APIValue.unionCouncil}timings_detail/$uuid', timings);
}

Future<void> patchTimingFromWorkRequestUnion(String uuid,List<Timing>? timings) async {
  return await patchTimingFromWorkRequest('${APIValue.union}timings_detail_union/$uuid', timings);
}

Future<void> patchTimingFromWorkRequestUser(String uuid,List<Timing>? timings) async {
  return await patchTimingFromWorkRequest('${APIValue.user}timings_detail_user/$uuid', timings);
}
