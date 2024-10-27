import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/co_owner/co_owner.dart';
import 'package:front_syndic/models/timing/timing.dart';
import 'package:front_syndic/models/timing/timing_estimate.dart';
import '../../models/estimate/estimate.dart';
import '../../models/work_request/work_request.dart';
import '../request.dart';

Future<Map<String, dynamic>> fetchCoOwnerMainData(String uuid) async {
  try{
    final response = await request(url: '${APIValue.unionCouncil}co_owner_main_data/$uuid', method: "GET");
    final records = response.data;
    final coOwner = CoOwner.fromJson(records["co_owner"]);

    var workRequest = WorkRequest();
    if(records["work_request"] != null) {
      workRequest = WorkRequest.fromJson(records["work_request"]);
    }
    var estimate = const Estimate();
    if(records["estimate"] != null) {
      estimate = Estimate.fromJson(records["estimate"]);
    }
    var timingEstimate = const TimingEstimate();
    if(records["timing_estimate"] != null) {
      timingEstimate = TimingEstimate.fromJson(records["timing_estimate"]);
    }
    var timing = const Timing();
    if(records["timing"] != null) {
      timing = Timing.fromJson(records["timing"]);
    }

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