import 'package:front_syndic/core_value.dart';
import '../../models/work_request/work_request.dart';
import '../request.dart';

Future<WorkRequest?> fetchWorkRequestDetail(String uuid) async {
  try{
    final response = await request(url: '${APIValue.unionCouncil}work_request_detail/$uuid', method: "GET");
    final record = WorkRequest.fromJson(response.data['work_request']);
    return record;
  } catch(e) {
    return null;
  }
}