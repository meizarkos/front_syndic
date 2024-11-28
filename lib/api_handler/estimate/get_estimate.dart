import 'package:front_syndic/models/estimate/estimate.dart';

import '../../core_value.dart';
import '../request.dart';

Future<List<Estimate>?> fetchEstimate(String route) async {
  try{
    final response = await request(url: route, method: "GET");
    final records = (response.data as List)
        .map((recordJson) => Estimate.fromJson(recordJson))
        .toList();
    return records;
  } catch(e) {
    print(e);
    return null;
  }
}

Future<List<Estimate>?> fetchAllEstimateCouncil() async {
  return await fetchEstimate('${APIValue.unionCouncil}all_estimates_council');
}

Future<List<Estimate>?> fetchAllEstimateArtisan() async {
  return await fetchEstimate('${APIValue.artisan}all_estimates_artisan');
}