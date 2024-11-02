import 'dart:convert';

import 'package:front_syndic/api_handler/request_with_body.dart';
import 'package:front_syndic/models/timing/timing.dart';
import 'package:front_syndic/models/work_request/create_work_request.dart';
import 'package:front_syndic/models/work_request/work_request.dart';
import 'package:intl/intl.dart';
import '../../core_value.dart';
import '../../utils/date_to_string/date.dart';

Future<void> postWorkRequest(String? uuid,CreateWorkRequest createWorkRequest) async {
  if(uuid == null) {
    return;
  }

  List<String> dateFormatted = [];

  if(createWorkRequest.workRequest.timings == null) {
    return;
  }

  for (Timing timing in createWorkRequest.workRequest.timings!) {
    final date = formatStringToApiDate(timing.date, "yyyy-MM-dd");
    if(date != null) {
      dateFormatted.add(date);
    }
  }

  var body = jsonEncode({
    AttributesWorkRequest.title: createWorkRequest.workRequest.title,
    AttributesWorkRequest.description: createWorkRequest.workRequest.description,
    AttributesWorkRequest.category: createWorkRequest.workRequest.category,
    "timings" : createWorkRequest.workRequest.timings?.map((timing) => {
      AttributesTiming.date: formatStringToApiDate(timing.date, "yyyy-MM-dd"),
      AttributesTiming.time: timing.time,
    }).toList(),
  });

  try {
    final response = await requestWithBody(
        url: '${APIValue.unionCouncil}work_requests/$uuid',
        method: "POST",
        body: body
    );
    return;
  }
  catch (e) {
    return;
  }
}