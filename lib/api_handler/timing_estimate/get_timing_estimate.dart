import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/timing/timing_estimate.dart';
import '../request.dart';

Future<List<TimingEstimate>?> fetchTimings(String route) async {
  try{
    final response = await request(url: route, method: "GET");
    print(response.data);
    final records = (response.data as List)
        .map((recordJson) => TimingEstimate.fromJson(recordJson))
        .toList();
    return records;
  } catch(e) {
    print(e);
    return null;
  }
}


Future<List<TimingEstimate>?> fetchTimingEstimateCouncil() async {
  return await fetchTimings('${APIValue.unionCouncil}all_timings_estimates_council');
}
