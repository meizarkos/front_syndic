import 'package:front_syndic/models/timing/timing.dart';
import 'package:front_syndic/models/union/union.dart';
import '../../core_value.dart';
import '../../models/artisan/artisan.dart';
import '../../models/council/council.dart';
import '../request.dart';

Future<TimingAndCreator?> fetchTimingDetail(String route) async {
  try{
    final response = await request(url: route, method: "GET");
    final timing = Timing.fromJson(response.data['timing']);
    final artisan = Artisan.fromJson(response.data['artisan']);
    final union = UnionApi.fromJson(response.data['union']);
    final council = Council.fromJson(response.data['council']);
    final timingAndCreator = TimingAndCreator(
      timing,
      artisan,
      union,
      council,
    );
    return timingAndCreator;
  } catch(e) {
    return null;
  }
}

Future<TimingAndCreator?> fetchTimingDetailCouncil(String? uuid) async {
  if(uuid == null) return null;
  return await fetchTimingDetail('${APIValue.unionCouncil}timing_detail_council/$uuid');
}

Future<TimingAndCreator?> fetchTimingDetailCouncilFromConversation(String? uuid) async {
  if(uuid == null) return null;
  return await fetchTimingDetail('${APIValue.unionCouncil}timing_detail_council_from_conversation/$uuid');
}

Future<TimingAndCreator?> fetchTimingDetailArtisan(String? uuid) async {
  if(uuid == null) return null;
  return await fetchTimingDetail('${APIValue.artisan}timing_detail_artisan/$uuid');
}

Future<TimingAndCreator?> fetchTimingDetailArtisanFromConversation(String? uuid) async {
  if(uuid == null) return null;
  return await fetchTimingDetail('${APIValue.artisan}timing_detail_artisan_from_conv/$uuid');
}


Future<TimingAndCreator?> fetchTimingDetailUnion(String? uuid) async {
  if(uuid == null) return null;
  return await fetchTimingDetail('${APIValue.union}timing_detail_union/$uuid');
}

Future<TimingAndCreator?> fetchTimingDetailUnionFromConversation(String? uuid) async {
  if(uuid == null) return null;
  return await fetchTimingDetail('${APIValue.union}timing_detail_union_from_conversation/$uuid');
}
