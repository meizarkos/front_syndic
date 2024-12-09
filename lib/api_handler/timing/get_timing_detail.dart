import 'package:front_syndic/models/timing/timing.dart';
import '../../core_value.dart';
import '../request.dart';

Future<Timing?> fetchTimingDetail(String route) async {
  try{
    final response = await request(url: route, method: "GET");
    final records = Timing.fromJson(response.data);
    return records; 
  } catch(e) {
    return null;
  }
}

Future<Timing?> fetchTimingDetailCouncil(String? uuid) async {
  if(uuid == null) return null;
  return await fetchTimingDetail('${APIValue.unionCouncil}timing_detail_council/$uuid');
}

Future<Timing?> fetchTimingDetailCouncilFromConversation(String? uuid) async {
  if(uuid == null) return null;
  return await fetchTimingDetail('${APIValue.unionCouncil}timing_detail_council_from_conversation/$uuid');
}

Future<Timing?> fetchTimingDetailArtisan(String? uuid) async {
  if(uuid == null) return null;
  return await fetchTimingDetail('${APIValue.artisan}timing_detail_artisan/$uuid');
}

Future<Timing?> fetchTimingDetailArtisanFromConv(String? uuid) async {
  if(uuid == null) return null;
  return await fetchTimingDetail('${APIValue.artisan}timing_detail_artisan_from_conv/$uuid');
}


Future<Timing?> fetchTimingDetailUnion(String? uuid) async {
  if(uuid == null) return null;
  return await fetchTimingDetail('${APIValue.union}timing_detail_union/$uuid');
}

Future<Timing?> fetchTimingDetailUnionFromConversation(String? uuid) async {
  if(uuid == null) return null;
  return await fetchTimingDetail('${APIValue.union}timing_detail_union_from_conversation/$uuid');
}
