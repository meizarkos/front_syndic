import 'package:front_syndic/core_value.dart';
import '../../models/conversation/conversation.dart';
import '../request.dart';

Future<List<Conversation>?> fetchConversation(String route) async {
  try{
    final response = await request(url: route, method: "GET");
    final records = (response.data as List)
        .map((recordJson) => Conversation.fromJson(recordJson))
        .toList();
    return records;
  } catch(e) {
    return null;
  }
}


Future<List<Conversation>?> fetchConversationFromWorkRequest(String? uuid) async {
  if(uuid == null) return null;
  return await fetchConversation('${APIValue.artisan}get_conv_one_work_request/$uuid');
}

Future<List<Conversation>?> fetchSpecificConvArtisan(String? uuid) async {
  if(uuid == null) return null;
  return await fetchConversation('${APIValue.artisan}all_conv_artisan/$uuid');
}

Future<List<Conversation>?> fetchFirstConvCouncil() async {
  return await fetchConversation('${APIValue.unionCouncil}first_conv_council');
}

Future<List<Conversation>?> fetchSpecificConvCouncil(String? uuid) async {
  if(uuid == null) return null;
  return await fetchConversation('${APIValue.unionCouncil}all_conv_council/$uuid');
}

Future<List<Conversation>?> fetchSpecificConvCouncilFromTiming(String? uuid) async {
  if(uuid == null) return null;
  return await fetchConversation('${APIValue.unionCouncil}all_conv_council_from_timing/$uuid');
}

Future<List<Conversation>?> fetchFirstConvArtisan() async {
  return await fetchConversation('${APIValue.artisan}first_conv_artisan');
}

Future<List<Conversation>?> fetchSpecificConvArtisanFromTiming(String? uuid) async {
  if(uuid == null) return null;
  return await fetchConversation('${APIValue.artisan}all_conv_artisan_from_timing/$uuid');
}

Future<List<Conversation>?> fetchSpecificConvArtisanFromEstimate(String? uuid) async {
  if(uuid == null) return null;
  return await fetchConversation('${APIValue.artisan}all_conv_artisan_from_estimate/$uuid');
}

Future<List<Conversation>?> fetchSpecificConvCouncilFromEstimate(String? uuid) async {
  if(uuid == null) return null;
  return await fetchConversation('${APIValue.unionCouncil}all_conv_council_from_estimate/$uuid');
}

Future<List<Conversation>?> fetchFirstConvUnion() async {
  return await fetchConversation('${APIValue.union}first_conv_union');
}

Future<List<Conversation>?> fetchSpecificConvUnion(String? uuid) async {
  if(uuid == null) return null;
  return await fetchConversation('${APIValue.union}all_conv_union/$uuid');
}

