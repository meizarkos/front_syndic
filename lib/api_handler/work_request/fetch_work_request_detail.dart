import 'package:front_syndic/core_value.dart';
import '../../models/work_request/work_request.dart';
import '../request.dart';

Future<WorkRequest?> fetchWorkRequestDetail(String route) async {
  try{
    final response = await request(url: route, method: "GET");
    final record = WorkRequest.fromJson(response.data);
    return record;
  } catch(e) {
    return null;
  }
}

Future<WorkRequest?> fetchWorkRequestDetailArtisan(String? uuidWorkRequest) async {
  if(uuidWorkRequest == null) return null;
  return fetchWorkRequestDetail('${APIValue.artisan}detail_work_request_artisan/$uuidWorkRequest');
}

Future<WorkRequest?> fetchWorkRequestDetailArtisanFromConv(String? convId) async{
  if(convId == null) return null;
  return fetchWorkRequestDetail('${APIValue.artisan}detail_work_request_artisan_from_conv/$convId');
}

Future<WorkRequest?> fetchWorkRequestDetailCouncil(String? uuid) async {
  if(uuid == null) return null;
  return fetchWorkRequestDetail('${APIValue.unionCouncil}work_request_detail/$uuid');
}

Future<WorkRequest?> fetchWorkRequestDetailCouncilFromConversation(String? uuid) async {
  if(uuid == null) return null;
  return fetchWorkRequestDetail('${APIValue.unionCouncil}work_request_detail_from_conv/$uuid');
}

Future<WorkRequest?> fetchWorkRequestDetailUnionFromConversation(String? uuid) async {
  if(uuid == null) return null;
  return fetchWorkRequestDetail('${APIValue.unionCouncil}work_request_detail_from_conv/$uuid');
}