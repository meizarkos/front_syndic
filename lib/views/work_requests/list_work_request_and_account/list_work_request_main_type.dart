import 'package:flutter/material.dart';
import 'package:front_syndic/views/work_requests/list_work_request_and_account/list_work_request_main.dart';

import '../../../api_handler/work_request/get_work_request_id.dart';
import '../../../models/adress/adress.dart';
import '../../../models/work_request/create_work_request.dart';
import '../../../models/work_request/work_request.dart';
import '../../../widget/bottom/nav_bar_council.dart';
import '../../../widget/bottom/nav_bar_user.dart';

class CouncilMain extends StatelessWidget {
  const CouncilMain({super.key});

  @override
  Widget build(BuildContext context) {
    return ListWorkRequestMain(
        goToAccount: ()=>{
          Navigator.pushNamed(context, '/council/account'),
        },
        fetchWorkRequestPending: fetchWorkRequestFromCoOwnerPending,
        goToModifyDemand: (uuid)=>{
          Navigator.pushNamed(context, '/council/modify_demand', arguments: uuid),
        },
        goToCreateWorkRequest: () async {
          var createWorkRequest =
          CreateWorkRequest([], WorkRequest(), null, Adress());
          Navigator.pushNamed(context, '/work_requests/title_and_desc',
              arguments: createWorkRequest);
        },
        bottom: bottomNavigationBarCouncil(context, 0),
    );
  }
}

class UserMain extends StatelessWidget {
  const UserMain({super.key});

  @override
  Widget build(BuildContext context) {
    return ListWorkRequestMain(
      goToAccount: ()=>{
        Navigator.pushNamed(context, '/user/account'),
      },
      fetchWorkRequestPending: fetchWorkRequestFromUserPending,
      goToModifyDemand: (uuid)=>{
        Navigator.pushNamed(context, '/user/modify_demand', arguments: uuid),
      },
      goToCreateWorkRequest: () async {
        var createWorkRequest =
        CreateWorkRequest([], WorkRequest(), null, Adress());
        Navigator.pushNamed(context, '/user/work_requests/title_and_desc',
            arguments: createWorkRequest);
      },
      bottom: bottomNavigationBarUser(context, 0),
    );
  }
}
