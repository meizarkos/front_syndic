import 'dart:convert';

import 'package:front_syndic/api_handler/request_with_body.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/conversation/conversation.dart';

Future<Conversation?> postFirstConvArtisan(String? uuid, String conversation) async {
  if(uuid == null) return null;
  try{
    final body = jsonEncode({
      AttributesConversation.message : conversation,
    });
    final response = await requestWithBody(url: '${APIValue.artisan}first_conv/$uuid', method: "POST", body: body);
    final conv = Conversation.fromJson(response.data);
    return conv;
  } catch(e) {
    return null;
  }
}
