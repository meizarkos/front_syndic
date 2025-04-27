import 'package:flutter/material.dart';

import '../../../api_handler/union_user_account/get_all_detail.dart';
import '../../../api_handler/union_user_account/patch_user_account.dart';
import '../../../text/fr.dart';
import 'change_status_account_user.dart';

class ChangeStatusAccountUserActivate extends StatelessWidget {
  const ChangeStatusAccountUserActivate({
    super.key,
    required this.apartmentUuid,
  });

  final String? apartmentUuid;

  @override
  Widget build(BuildContext context) {
    return UserChangeAccount(
      fetchApartment: getAllDetailForAccount(apartmentUuid),
      patchUser: activateAccountUser(apartmentUuid),
      text: AppText.unblock,
    );
  }
}

class ChangeStatusAccountUserDeActivate extends StatelessWidget {
  const ChangeStatusAccountUserDeActivate({
    super.key,
    required this.apartmentUuid,
  });

  final String? apartmentUuid;

  @override
  Widget build(BuildContext context) {
    return UserChangeAccount(
      fetchApartment: getAllDetailForAccount(apartmentUuid),
      patchUser: deactivateAccountUser(apartmentUuid),
      text: AppText.block,
    );
  }
}
