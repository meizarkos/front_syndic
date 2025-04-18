import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/timing/timing.dart';
import '../request.dart';

Future<List<Timing>?> fetchTimings(String route) async {
  try{
    final response = await request(url: route, method: "GET");
    final records = (response.data as List)
        .map((recordJson) => Timing.fromJson(recordJson))
        .toList();
    print(route);
    return records;
  } catch(e) {
    return null;
  }
}


Future<List<Timing>?> fetchTimingFromWorkRequestCouncil(String uuid) async {
  return await fetchTimings('${APIValue.unionCouncil}timings_detail/$uuid');
}

Future<List<Timing>?> fetchTimingFromWorkRequestUnion(String uuid) async {
  return await fetchTimings('${APIValue.union}timings_detail_union/$uuid');
}

Future<List<Timing>?> fetchTimingFromWorkRequestUser(String uuid) async {
  return await fetchTimings('${APIValue.user}timings_detail_user/$uuid');
}

Future<List<Timing>?> fetchTimingsCouncil() async {
  return await fetchTimings('${APIValue.unionCouncil}all_meetings_council');
}

Future<List<Timing>?> fetchTimingsArtisan() async {
  return await fetchTimings('${APIValue.artisan}all_meetings_artisan');
}

Future<List<Timing>?> fetchTimingsUnion() async {
  return await fetchTimings('${APIValue.union}all_meetings_union');
}
