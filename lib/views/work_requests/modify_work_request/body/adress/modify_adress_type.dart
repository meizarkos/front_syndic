import 'package:flutter/material.dart';

import '../../../../../api_handler/adress/fetch_prefill_adress.dart';
import '../../../../../api_handler/adress/patch_adress.dart';
import 'modify_adress.dart';

class ModifyAdressWorkRequestUnion extends StatelessWidget {
  const ModifyAdressWorkRequestUnion({
    super.key,
    required this.workRequestUuid,
  });

  final String workRequestUuid;

  @override
  Widget build(BuildContext context) {
    return ChoseAdressPatchWorkRequest(
      workRequestUuid: workRequestUuid,
      fetchAdress: fetchAdressWorkRequestUnion,
      onRegister: patchAdressWorkRequestFromUnion,
    );
  }
}

class ModifyAdressWorkRequestCouncil extends StatelessWidget {
  const ModifyAdressWorkRequestCouncil({
    super.key,
    required this.workRequestUuid,
  });

  final String workRequestUuid;

  @override
  Widget build(BuildContext context) {
    return ChoseAdressPatchWorkRequest(
      workRequestUuid: workRequestUuid,
      fetchAdress: fetchAdressWorkRequestCouncil,
      onRegister: patchAdressWorkRequestForCouncil,
    );
  }
}

class ModifyAdressWorkRequestUser extends StatelessWidget {
  const ModifyAdressWorkRequestUser({
    super.key,
    required this.workRequestUuid,
  });

  final String workRequestUuid;

  @override
  Widget build(BuildContext context) {
    return ChoseAdressPatchWorkRequest(
      workRequestUuid: workRequestUuid,
      fetchAdress: fetchAdressWorkRequestUser,
      onRegister: patchAdressWorkRequestFromUser,
    );
  }
}


