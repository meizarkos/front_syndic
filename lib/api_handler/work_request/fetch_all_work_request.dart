import 'package:front_syndic/core_value.dart';

import '../../models/work_request/work_request.dart';
import '../request.dart';

Future<List<WorkRequest>?> fetchAllWorkRequest() async {
  try{
    final response = await request(url: '${APIValue.artisan}all_work_requests', method: "GET");
    final records = (response.data as List)
        .map((recordJson) => WorkRequest.fromJson(recordJson))
        .toList();
    return records;
  } catch(e) {
    return null;
  }
}