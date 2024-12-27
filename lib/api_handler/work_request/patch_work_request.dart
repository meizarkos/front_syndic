import 'dart:convert';

import 'package:front_syndic/api_handler/request_with_body.dart';
import 'package:front_syndic/core_value.dart';
import '../../models/work_request/work_request.dart';

Future<void> patchWorkRequestDetail(String route, WorkRequest workRequest) async {
  try{
    final body = jsonEncode({
      AttributesWorkRequest.description : workRequest.description,
      AttributesWorkRequest.title : workRequest.title,
      AttributesWorkRequest.category : workRequest.category,
    });

    final response = await requestWithBody(url: route, method: "PATCH", body: body);

  } catch(e) {
    return;
  }
}

Future<void> patchWorkRequestDetailCouncil(String workRequestUuid, WorkRequest workRequest) async {
  return await patchWorkRequestDetail('${APIValue.unionCouncil}work_requests_detail/$workRequestUuid', workRequest);
}

Future<void> patchWorkRequestDetailUnion(String workRequestUuid, WorkRequest workRequest) async {
  return await patchWorkRequestDetail('${APIValue.union}work_requests_detail_union/$workRequestUuid', workRequest);
}