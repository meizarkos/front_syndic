import 'package:front_syndic/core_value.dart';

import '../../request.dart';

Future<String?> fetchUuidWorkRequest(String route) async {
  try{
    final res = await request(url: route, method: 'GET');
    final data = res.data;
    return data['work_request_id'];
  }
  catch(e){
    return null;
  }
}

Future<String?> fetchUuidWorkRequestCouncil(String? convId) async {
  return await fetchUuidWorkRequest('${APIValue.unionCouncil}get_work_request_id/$convId');
}

Future<String?> fetchUuidWorkRequestUser(String? convId) async {
  return await fetchUuidWorkRequest('${APIValue.user}get_work_request_id_user/$convId');
}

Future<String?> fetchUuidWorkRequestUnion(String? convId) async {
  return await fetchUuidWorkRequest('${APIValue.union}get_work_request_id_union/$convId');
}