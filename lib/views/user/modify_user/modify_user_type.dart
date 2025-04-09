import 'package:flutter/material.dart';

import '../../../api_handler/appartment/get_detail_apartment.dart';
import '../../../api_handler/user/patch_user.dart';
import 'modify_user.dart';

class ModifyUserForUnion extends StatelessWidget {
  const ModifyUserForUnion({
    super.key,
    required this.apartmentUuid,
  });

  final String? apartmentUuid;

  @override
  Widget build(BuildContext context) {
    return ModifyUser(
      fetchData: getDetailApartmentForUnion,
      patchData: patchUserFromUnion,
      showAppBar: false,
      apartmentUuid: apartmentUuid,
    );
  }
}