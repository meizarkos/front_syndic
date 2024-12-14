import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/timing/timing_estimate.dart';
import '../request.dart';

Future<List<TimingEstimate>?> fetchTimings(String route) async {
  try{
    final response = await request(url: route, method: "GET");
    final records = (response.data as List)
        .map((recordJson) => TimingEstimate.fromJson(recordJson))
        .toList();
    return records;
  } catch(e) {
    return null;
  }
}


Future<List<TimingEstimate>?> fetchTimingEstimateCouncil(String? uuid) async {
  if(uuid == null)return null;
  return await fetchTimings('${APIValue.unionCouncil}all_timings_estimates_council/$uuid');
}

Future<List<TimingEstimate>?> fetchTimingEstimateArtisan(String? uuid) async {
  if(uuid == null)return null;
  return await fetchTimings('${APIValue.artisan}all_timings_estimates_artisan/$uuid');
}

Future<List<TimingEstimate>?> fetchTimingEstimateUnion(String? uuid) async {
  if(uuid == null)return null;
  return await fetchTimings('${APIValue.union}all_timings_estimates_union/$uuid');
}