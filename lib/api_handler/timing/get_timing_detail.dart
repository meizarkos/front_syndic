import 'package:front_syndic/models/timing/timing.dart';
import 'package:front_syndic/models/union/union.dart';
import '../../core_value.dart';
import '../../models/artisan/artisan.dart';
import '../../models/council/council.dart';
import '../../models/user/user.dart';
import '../request.dart';

Future<TimingAndCreator?> fetchTimingDetail(String route) async {
  try {
    final response = await request(url: route, method: "GET");

    Timing? timing;
    Artisan? artisan;
    UnionApi? union;
    Council? council;
    User? user;

    // Only run fromJson if the key exists
    if (response.data.containsKey('timing') && response.data['timing'] != null) {
      timing = Timing.fromJson(response.data['timing']);
    }

    if (response.data.containsKey('artisan') && response.data['artisan'] != null) {
      artisan = Artisan.fromJson(response.data['artisan']);
    }

    if (response.data.containsKey('union') && response.data['union'] != null) {
      union = UnionApi.fromJson(response.data['union']);
    }

    if (response.data.containsKey('council') && response.data['council'] != null) {
      council = Council.fromJson(response.data['council']);
    }

    if (response.data.containsKey('user') && response.data['user'] != null) {
      user = User.fromJson(response.data['user']);
    }

    final timingAndCreator = TimingAndCreator(
      timing,
      artisan,
      union,
      council,
      user,
    );
    return timingAndCreator;
  } catch (e) {
    print('Error fetching timing details: $e');
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

Future<TimingAndCreator?> fetchTimingDetailUserFromConversation(String? uuid) async {
  if(uuid == null) return null;
  return await fetchTimingDetail('${APIValue.user}timing_detail_user_from_conversation/$uuid');
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
