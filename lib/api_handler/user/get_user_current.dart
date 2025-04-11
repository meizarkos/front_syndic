import 'dart:convert';

import '../../core_value.dart';
import '../../models/user/user.dart';
import '../request.dart';
import '../request_with_body.dart';

Future<User?> getUser(String route) async {
  try {
    final response = await request(url: route, method: "GET");
    final user = User.fromJson(response.data);
    return user;
  } catch (e) {
    print(e);
    return null;
  }
}

Future<User?> getUserFromUser(String? n) async {
  return await getUser('${APIValue.user}user_current');
}

Future<User?> getUserFromUnion(String? userUuid) async {
  if (userUuid == null) {
    return null;
  }
  return await getUser('${APIValue.union}user_from_union/$userUuid');
}