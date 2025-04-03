import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:front_syndic/api_handler/request_with_body.dart';


Future<bool> isEmailUnique(String email, VoidCallback handleVisibility) async {
  try{
    final body = jsonEncode({
      'email': email
    });

    final response = await requestWithBody(url: 'is_email_unique', body: body, method: 'POST');
    if(response.statusCode != 200){
      handleVisibility();
      return false;
    }
    else{
      return true;
    }
  }
  catch(e){
    return false;
  }
}