import 'package:front_syndic/core_value.dart';
import '../request.dart';

Future<void> deleteWorkRequestDetail(String route) async {
  try{
    await request(url: route, method: "DELETE");
  } catch(e) {
    return;
  }
}

Future<void> deleteWorkRequestDetailUnion(String workRequestUuid) async {
  return await deleteWorkRequestDetail('${APIValue.union}work_requests_detail_union/$workRequestUuid');
}

Future<void> deleteWorkRequestDetailCouncil(String workRequestUuid) async {
  return await deleteWorkRequestDetail('${APIValue.unionCouncil}work_requests_detail/$workRequestUuid');
}