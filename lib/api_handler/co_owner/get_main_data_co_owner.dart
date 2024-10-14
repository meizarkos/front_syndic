import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/co_owner/co_owner.dart';
import 'package:front_syndic/models/timing/timing.dart';
import 'package:front_syndic/models/timing/timing_estimate.dart';
import '../../models/estimate/estimate.dart';
import '../../models/work_request/work_request.dart';
import '../request.dart';

Future<Map<String, dynamic>> fetchCoOwnerMainData(String uuid) async {
  try{
    final response = await request(url: '${APIValue.baseUnion}co_owner_main_data/$uuid', method: "GET");
    final records = response.data;
    final coOwner = CoOwner.fromJson(records["co_owner"]);
    final workRequest = WorkRequest.fromJson(records["work_request"]);
    final estimate = Estimate.fromJson(records["estimate"]);
    final timingEstimate = TimingEstimate.fromJson(records["timing_estimate"]);
    final timing = Timing.fromJson(records["timing"]);
    return {
      "co_owner": coOwner,
      "work_request": workRequest,
      "estimate": estimate,
      "timing_estimate": timingEstimate,
      "timing": timing,
    };
  } catch(e) {
    return {};
  }
}