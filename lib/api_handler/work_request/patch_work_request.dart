import 'dart:convert';

import 'package:front_syndic/api_handler/request_with_body.dart';
import 'package:front_syndic/core_value.dart';
import '../../models/work_request/work_request.dart';

Future<void> patchWorkRequesDetail(String workRequestUuid, WorkRequest workRequest) async {
  try{
    final body = jsonEncode({
      AttributesWorkRequest.description : workRequest.description,
      AttributesWorkRequest.title : workRequest.title,
      AttributesWorkRequest.category : workRequest.category,
    });

    await requestWithBody(url: '${APIValue.unionCouncil}work_requests_detail/$workRequestUuid', method: "PATCH", body: body);
  } catch(e) {
    return;
  }
}