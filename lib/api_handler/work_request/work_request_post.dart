import 'dart:convert';

import 'package:front_syndic/api_handler/request_with_body.dart';
import 'package:front_syndic/models/timing/timing.dart';
import 'package:front_syndic/models/work_request/create_work_request.dart';
import 'package:front_syndic/models/work_request/work_request.dart';
import '../../core_value.dart';

Future<void> postWorkRequest(String? uuid,CreateWorkRequest createWorkRequest) async {
  if(uuid == null) {
    return;
  }
  var body = jsonEncode({
    AttributesWorkRequest.title: createWorkRequest.workRequest.title,
    AttributesWorkRequest.description: createWorkRequest.workRequest.description,
    AttributesWorkRequest.category: createWorkRequest.workRequest.category,
    "timings" : createWorkRequest.workRequest.timings?.map((timing) => {
      AttributesTiming.date: timing.date,
      AttributesTiming.time: timing.time,
    }).toList(),
  });

  try {
    final response = await requestWithBody(
        url: '${APIValue.unionCouncil}work_requests/$uuid',
        method: "POST",
        body: body
    );
    print("aaa  $body");
    return;
  }
  catch (e) {
    return;
  }
}