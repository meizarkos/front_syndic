import 'package:flutter/material.dart';

import '../../../api_handler/adress/fetch_prefill_adress.dart';
import '../../../api_handler/adress/patch_adress.dart';
import '../../work_requests/modify_work_request/body/adress/modify_adress.dart';


class ModifyAdressCouncilFromUnion extends StatelessWidget {
  const ModifyAdressCouncilFromUnion({
    super.key,
    required this.councilId,
  });

  final String? councilId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ChoseAdressPatchWorkRequest(
          fetchAdress: fetchAdressCouncilFromUnion,
          onRegister: patchAdressCouncilFromUnion,
          workRequestUuid: councilId, //it work even if its not a work request uuid
        )
    );
  }
}