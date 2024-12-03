import 'package:front_syndic/core_value.dart';
import '../request.dart';

Future<void> patchEstimateRequest(String route) async {
  try{
    final response = await request(url: route, method: "PATCH");
    print(response);
    return;
  } catch(e) {
    return;
  }
}

Future<void> patchEstimateCouncil(String? uuid) async {
  if(uuid == null) return;
  return await patchEstimateRequest('${APIValue.unionCouncil}change_status_estimate_council/$uuid');
}