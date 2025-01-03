import 'package:flutter/material.dart';
import 'package:front_syndic/text/fr.dart';
import 'package:front_syndic/widget/header/app_bar_back_button.dart';

import '../../../api_handler/adress/fetch_prefill_adress.dart';
import '../../../api_handler/adress/patch_adress.dart';
import '../../work_requests/modify_work_request/body/adress/modify_adress.dart';

class ModifyAdressCouncil extends StatelessWidget {
  const ModifyAdressCouncil({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarBackButton(context,title: AppText.adress),
        body: ChoseAdressPatchWorkRequest(
          fetchAdress: fetchAdressCouncilForModification,
          onRegister: patchAdressCouncil,
        )
    );
  }
}