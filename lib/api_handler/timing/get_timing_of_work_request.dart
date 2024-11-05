import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/timing/timing.dart';
import '../request.dart';

Future<List<Timing>?> fetchTimingFromWorkRequest(String uuid) async {
  try{
    final response = await request(url: '${APIValue.unionCouncil}timings_detail/$uuid', method: "GET");
    final records = (response.data as List)
        .map((recordJson) => Timing.fromJson(recordJson))
        .toList();
    return records;
  } catch(e) {
    return null;
  }
}
