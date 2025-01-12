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


Future<TimingEstimate?> fetchTimingEstimateCouncil(String? uuid) async {
  if(uuid == null)return null;
  return await fetchTimings('${APIValue.unionCouncil}all_timings_estimates_council/$uuid');
}

Future<TimingEstimate?> fetchTimingEstimateArtisan(String? uuid) async {
  if(uuid == null)return null;
  return await fetchTimings('${APIValue.artisan}all_timings_estimates_artisan/$uuid');
}

Future<TimingEstimate?> fetchTimingEstimateUnion(String? uuid) async {
  if(uuid == null)return null;
  return await fetchTimings('${APIValue.union}all_timings_estimates_union/$uuid');
}