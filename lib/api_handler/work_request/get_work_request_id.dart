import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/work_request/work_request.dart';
import '../request.dart';

Future<List<WorkRequest>?> fetchWorkRequestFromParticularOrCouncil(String route) async {
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

Future<List<WorkRequest>?> fetchWorkRequestFromCoOwnerPending() async {
  return await fetchWorkRequestFromParticularOrCouncil('${APIValue.unionCouncil}work_requests');
}

Future<List<WorkRequest>?> fetchWorkRequestFromCoOwnerPast() async {
  return await fetchWorkRequestFromParticularOrCouncil('${APIValue.unionCouncil}work_requests_past');
}

Future<List<WorkRequest>?> fetchWorkRequestFromUserPending() async {
  return await fetchWorkRequestFromParticularOrCouncil('${APIValue.user}work_requests_user_pending');
}
