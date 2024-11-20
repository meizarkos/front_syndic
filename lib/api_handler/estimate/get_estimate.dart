import 'package:front_syndic/models/estimate/estimate.dart';

import '../../core_value.dart';
import '../request.dart';

Future<List<Estimate>?> fetchConversation(String route) async {
  try{
    final response = await request(url: route, method: "GET");
    final records = (response.data as List)
        .map((recordJson) => Estimate.fromJson(recordJson))
        .toList();
    print(records);
    return records;
  } catch(e) {
    print(e);
    return null;
  }
}

Future<List<Estimate>?> fetchAllEstimateCouncil() async {
  return await fetchConversation('${APIValue.unionCouncil}all_estimates_council');
}