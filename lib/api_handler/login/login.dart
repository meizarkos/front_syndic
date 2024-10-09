import 'dart:convert';
import 'package:front_syndic/api_handler/request_with_body.dart';
import '../credential.dart';

Future<List<String>> sendConnexionRequest(String email, String password,Function handleVisibility) async {
  var body = jsonEncode({
    'email': email,
    'password': password,
  });

  try{
    var response = await requestWithBody(url: '/login', method: "POST", body: body);
    if(response.statusCode == 200) {
      Credential.instance.token = 'Bearer ${response.data['token']}';
      return ['0', response.data['route']];
    }
    else{
      handleVisibility(true);
      return ['1','1'];
    }
  } catch(e) {
      handleVisibility(true);
      return ['1','1'];
  }
}