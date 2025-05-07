import 'dart:convert';

import 'package:front_syndic/api_handler/request_with_body.dart';
import 'package:front_syndic/models/timing/timing.dart';
import 'package:front_syndic/models/work_request/create_work_request.dart';
import 'package:front_syndic/models/work_request/work_request.dart';
import '../../core_value.dart';
import '../../models/adress/adress.dart';
import '../../utils/date_to_string/date.dart';

Future<void> postWorkRequest(CreateWorkRequest createWorkRequest,String route) async {

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
    AttributesWorkRequest.councilId: createWorkRequest.workRequest.councilId,
    AttributesWorkRequest.userId: createWorkRequest.workRequest.userId,
    AttributesWorkRequest.title: createWorkRequest.workRequest.title,
    AttributesWorkRequest.description: createWorkRequest.workRequest.description,
    AttributesWorkRequest.category: createWorkRequest.workRequest.category,
    "adress":{
      AttributesAdress.country : createWorkRequest.adress.country,
      AttributesAdress.city : createWorkRequest.adress.city,
      AttributesAdress.street : createWorkRequest.adress.street,
      AttributesAdress.postalCode : createWorkRequest.adress.postalCode,
      AttributesAdress.region :createWorkRequest.adress.region,
      AttributesAdress.comment : createWorkRequest.adress.comment,
    },
    "timings" : createWorkRequest.workRequest.timings?.map((timing) => {
      AttributesTiming.date: formatStringToApiDate(timing.date, "yyyy-MM-dd"),
      AttributesTiming.time: timing.time,
    }).toList(),
  });

  try {
    final response = await requestWithBody(
        url: route,
        method: "POST",
        body: body
    );
    return;
  }
  catch (e) {
    return;
  }
}

Future<void> postWorkRequestCouncil(CreateWorkRequest createWorkRequest) async {
  return postWorkRequest(createWorkRequest, '${APIValue.unionCouncil}work_request');
}

Future<void> postWorkRequestUnion(CreateWorkRequest createWorkRequest) async {
  return postWorkRequest(createWorkRequest, '${APIValue.union}work_request_union');
}

Future<void> postWorkRequestUser(CreateWorkRequest createWorkRequest) async {
  return postWorkRequest(createWorkRequest, '${APIValue.user}work_request_user');
}


