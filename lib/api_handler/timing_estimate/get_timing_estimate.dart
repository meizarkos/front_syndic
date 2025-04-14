import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/estimate/estimate.dart';
import 'package:front_syndic/models/timing/timing_estimate.dart';
import '../request.dart';

Future<TimingEstimateAndEstimate?> fetchTimings(String route) async {
  try{
    final response = await request(url: route, method: "GET");
    var estimate = Estimate();
    var timingEstimate = TimingEstimate();
    if(response.data['timingEstimate'] != null) {
      timingEstimate = TimingEstimate.fromJson(response.data['timingEstimate']);
    }
    if(response.data['estimate'] != null) {
      estimate = Estimate.fromJson(response.data['estimate']);
    }
    return TimingEstimateAndEstimate(
      estimate: estimate,
      timingEstimate: timingEstimate,
    );
  } catch(e) {
    return null;
  }
}

Future<TimingEstimateAndEstimate?> fetchTimingEstimateArtisan(String? convUuid) async {
  if(convUuid == null)return null;
  return await fetchTimings('${APIValue.artisan}timing_estimate_detail_from_conv_artisan/$convUuid');
}

Future<TimingEstimateAndEstimate?> fetchTimingEstimateUnion(String? convUuid) async {
  if(convUuid == null)return null;
  return await fetchTimings('${APIValue.union}timing_estimate_detail_from_conv_union/$convUuid');
}

Future<TimingEstimateAndEstimate?> fetchTimingEstimateCouncil(String? convUuid) async {
  if(convUuid == null)return null;
  return await fetchTimings('${APIValue.unionCouncil}timing_estimate_detail_from_conv_council/$convUuid');
}

Future<TimingEstimateAndEstimate?> fetchTimingEstimateUser(String? convUuid) async {
  if(convUuid == null)return null;
  return await fetchTimings('${APIValue.user}timing_estimate_detail_from_conv_user/$convUuid');
}