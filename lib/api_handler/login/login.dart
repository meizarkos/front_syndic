import 'dart:convert';
import 'dart:ui';
import 'package:front_syndic/api_handler/request_with_body.dart';
import '../credential.dart';

Future<List<String?>> sendConnexionRequest(String email, String password,VoidCallback handleVisibility) async {
  var body = jsonEncode({
    'email': email,
    'password': password,
  });

  try{
    var response = await requestWithBody(url: '/login', method: "POST", body: body);
    if(response.statusCode == 200) {
      Credential.instance.token = 'Bearer ${response.data['token']}';
      final route = response.data['route'] as String?;
      final uuid = response.data['uuid'] as String?;
      return ['0',route,uuid];
    }
    else{
      handleVisibility();
      return ['1','1'];
    }
  } catch(e) {
      handleVisibility;
      return ['1','1'];
  }
}