import 'package:flutter/material.dart';

import '../../../api_handler/user/get_user_current.dart';
import '../../../api_handler/user/patch_user.dart';
import 'modify_user.dart';

class ModifyUserForUnion extends StatelessWidget {
  const ModifyUserForUnion({
    super.key,
    required this.userUuid,
  });

  final String? userUuid;

  @override
  Widget build(BuildContext context) {
    return ModifyUser(
      fetchData: getUserFromUnion,
      patchData: patchUserFromUnion,
      userUuid: userUuid,
      showAppBar: false,
    );
  }
}

class ModifyUserFromUser extends StatelessWidget {
  const ModifyUserFromUser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ModifyUser(
      fetchData: getUserFromUser,
      patchData: patchUserFromUser,
      userUuid: null,
    );
  }
}