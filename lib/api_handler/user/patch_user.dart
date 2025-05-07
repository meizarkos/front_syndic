import 'dart:convert';

import '../../core_value.dart';
import '../../models/user/user.dart';
import '../request_with_body.dart';

Future<void> patchUser(String route, User user ) async {
  try {
    final body = jsonEncode({
      AttributesUser.name: user.name,
      AttributesUser.firstName: user.firstName,
      AttributesUser.phone: user.phone
    });
    final response = await requestWithBody(url: route, method: "PATCH", body: body);
    return;
  } catch (e) {
    return;
  }
}

Future<void> patchUserFromUnion(String? userUuid, User user) async {
  if (userUuid == null) {
    return;
  }
  return await patchUser('${APIValue.union}user_from_union/$userUuid', user);
}

Future<void> patchUserFromUser(String? n,User user) async {
  return await patchUser('${APIValue.user}user_current', user);
}