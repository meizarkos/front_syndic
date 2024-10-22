import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/work_request/work_request.dart';
import '../request.dart';

Future<List<WorkRequest>?> fetchWorkRequestFromCoOwner(String uuid) async {
  try{
    final response = await request(url: '${APIValue.unionCouncil}work_requests/$uuid', method: "GET");
    final records = (response.data as List)
        .map((recordJson) => WorkRequest.fromJson(recordJson))
        .toList();
    return records;
  } catch(e) {
    return null;
  }
}