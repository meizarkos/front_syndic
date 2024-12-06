import 'package:front_syndic/core_value.dart';

import '../../models/work_request/work_request.dart';
import '../request.dart';

Future<List<WorkRequest>?> fetchAllWorkRequest(String route) async {
  try{
    final response = await request(url: route, method: "GET");
    final records = (response.data as List)
        .map((recordJson) => WorkRequest.fromJson(recordJson))
        .toList();
    return records;
  } catch(e) {
    return null;
  }
}

Future<List<WorkRequest>?> fetchAllWorkRequestArtisan() async {
  return await fetchAllWorkRequest('${APIValue.artisan}all_work_requests');
}

Future<List<WorkRequest>?> fetchAllWorkRequestActiveUnion() async {
  return await fetchAllWorkRequest('${APIValue.union}work_requests_union');
}

Future<List<WorkRequest>?> fetchAllWorkRequestCompletedUnion() async {
  return await fetchAllWorkRequest('${APIValue.union}work_requests_past_union');
}