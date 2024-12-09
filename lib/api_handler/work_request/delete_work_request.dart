import 'package:front_syndic/core_value.dart';
import '../request.dart';

Future<void> deleteWorkRequestDetail(String workRequestUuid) async {
  try{
    await request(url: '${APIValue.unionCouncil}work_requests_detail/$workRequestUuid', method: "DELETE");
  } catch(e) {
    return;
  }
}