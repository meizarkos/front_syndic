import 'dart:convert';

import 'package:front_syndic/api_handler/request_with_body.dart';

Future<void> requestNewPasswd(String email) async {
  try{
    final body = jsonEncode({
      'email': email,
    });
    final res = await requestWithBody(url: 'renew_passwd', method: "POST", body: body);
    return;
  }
  catch(e){
    print(e);
    return;
  }
}