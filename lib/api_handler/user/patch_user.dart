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
    print(e);
    return;
  }
}

Future<void> patchUserFromUnion(String? apartmentUuid, User user) async {
  if (apartmentUuid == null) {
    return;
  }
  return await patchUser('${APIValue.union}user/$apartmentUuid', user);
}