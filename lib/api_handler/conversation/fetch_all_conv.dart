import '../../core_value.dart';
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