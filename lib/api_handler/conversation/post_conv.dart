import 'dart:convert';

import 'package:front_syndic/api_handler/request_with_body.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/conversation/conversation.dart';

Future<Conversation?> postConv(String? uuid, String conversation,String route) async {
  if(uuid == null) return null;
  if(conversation == '') return null;
  try{
    final body = jsonEncode({
      AttributesConversation.message : conversation,
    });
    final response = await requestWithBody(url: route, method: "POST", body: body);
    final conv = Conversation.fromJson(response.data);
    return conv;
  } catch(e) {
    return null;
  }
}

Future<Conversation?> postFirstConvArtisanWorkRequest(String? uuid,String conversation) async {
  return await postConv(uuid, conversation,'${APIValue.artisan}first_conv_artisan/$uuid');
}

Future<Conversation?> postConvArtisan(String? uuid,String conversation) async {
  return await postConv(uuid, conversation,'${APIValue.artisan}conversation_artisan/$uuid');
}

Future<Conversation?> postConvCouncil(String? uuid,String conversation) async {
  return await postConv(uuid, conversation,'${APIValue.unionCouncil}conversation_council/$uuid');
}






