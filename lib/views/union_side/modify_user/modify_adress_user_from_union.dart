import 'package:flutter/material.dart';

import '../../../api_handler/adress/fetch_prefill_adress.dart';
import '../../../api_handler/adress/patch_adress.dart';
import '../../work_requests/modify_work_request/body/adress/modify_adress.dart';


class ModifyAdressUserFromUnion extends StatelessWidget {
  const ModifyAdressUserFromUnion({
    super.key,
    required this.userUuid,
  });

  final String? userUuid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ChoseAdressPatchWorkRequest(
          fetchAdress: fetchAdressUserFromUnion,
          onRegister: patchAdressUserFromUnion,
          workRequestUuid: userUuid, //it work even if its not a work request uuid
        )
    );
  }
}