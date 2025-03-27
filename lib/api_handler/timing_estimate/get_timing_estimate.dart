import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/timing/timing_estimate.dart';
import '../request.dart';

Future<TimingEstimate?> fetchTimings(String route) async {
  try{
    final response = await request(url: route, method: "GET");
    final record = TimingEstimate.fromJson(response.data);
    return record;
  } catch(e) {
    return null;
  }
}

Future<TimingEstimate?> fetchTimingEstimateArtisan(String? convUuid) async {
  if(convUuid == null)return null;
  return await fetchTimings('${APIValue.artisan}timing_estimate_detail_from_conv_artisan/$convUuid');
}

Future<TimingEstimate?> fetchTimingEstimateUnion(String? convUuid) async {
  if(convUuid == null)return null;
  return await fetchTimings('${APIValue.union}timing_estimate_detail_from_conv_union/$convUuid');
}

Future<TimingEstimate?> fetchTimingEstimateCouncil(String? convUuid) async {
  if(convUuid == null)return null;
  return await fetchTimings('${APIValue.unionCouncil}timing_estimate_detail_from_conv_council/$convUuid');
}