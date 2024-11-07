import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/work_request/work_request.dart';
import '../request.dart';

Future<List<WorkRequest>?> fetchWorkRequestFromCoOwner(String uuid,String route) async {
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

Future<List<WorkRequest>?> fetchWorkRequestFromCoOwnerPending(String uuid) async {
  return await fetchWorkRequestFromCoOwner(uuid, '${APIValue.unionCouncil}work_requests/$uuid');
}

Future<List<WorkRequest>?> fetchWorkRequestFromCoOwnerPast(String uuid) async {
  return await fetchWorkRequestFromCoOwner(uuid, '${APIValue.unionCouncil}work_requests_past/$uuid');
}
