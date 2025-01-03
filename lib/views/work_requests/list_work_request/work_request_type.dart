import 'package:flutter/material.dart';
import 'package:front_syndic/views/work_requests/list_work_request/work_requests_list.dart';
import 'package:front_syndic/widget/bottom/nav_bar_council.dart';

import '../../../api_handler/work_request/delete_work_request.dart';
import '../../../api_handler/work_request/fetch_all_work_request.dart';
import '../../../api_handler/work_request/fetch_work_request_detail.dart';
import '../../../api_handler/work_request/get_work_request_id.dart';
import '../../../models/adress/adress.dart';
import '../../../models/to_screen/council_work_request_detail.dart';
import '../../../models/work_request/create_work_request.dart';
import '../../../models/work_request/work_request.dart';
import '../../../widget/bottom/nav_bar_union.dart';

class WorkRequestListCouncil extends StatelessWidget {
  const WorkRequestListCouncil({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return WorkRequestsList(
      futureList: [fetchWorkRequestFromCoOwnerPending, fetchWorkRequestFromCoOwnerPast],
      goDoDetail: (String? uuid){
        if(uuid == null) return;
        Navigator.pushNamed(context, '/council/modify_demand',arguments: uuid);
        /*Navigator.pushNamed(context,'/work_requests/detail',
          arguments: CouncilWorkRequestDetail(
            uuid : uuid,
            futureToFetchData: fetchWorkRequestDetailCouncil,
            onBack: ()=>{
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/co_owner/work_requests', // The new route
                (Route<dynamic> route) => false, // Remove all previous routes
              )
            },
            onDelete: (String? uuid)async{
              if(uuid == null) return;
              await deleteWorkRequestDetail(uuid);
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/co_owner/work_requests',
                (Route<dynamic> route) => false,
              );
            },
          ),
        );*/
      },
      bottomBar: bottomNavigationBarCouncil(context, 1),
      addWorkRequest: ()async {
        var createWorkRequest = CreateWorkRequest([],WorkRequest(),null,Adress());
        Navigator.pushNamed(context, '/work_requests/title_and_desc',arguments: createWorkRequest);
      },
    );
  }
}

class WorkRequestListUnion extends StatelessWidget {
  const WorkRequestListUnion({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return WorkRequestsList(
      futureList: [fetchAllWorkRequestActiveUnion, fetchAllWorkRequestCompletedUnion],
      goDoDetail: (String? uuid){
        if(uuid == null) return;
        Navigator.pushNamed(context, '/union/modify_demand',arguments: uuid);
        /*Navigator.pushNamed(context,'union/work_requests/detail',
          arguments: CouncilWorkRequestDetail(
            uuid : uuid,
            futureToFetchData: fetchWorkRequestDetailUnion,
            onBack: ()=>{
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/union/work_requests',
                    (Route<dynamic> route) => false,
              )
            },
            onDelete: (String? uuid)async{
              if(uuid == null) return;
              await deleteWorkRequestDetail(uuid);
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/union/work_requests',
                    (Route<dynamic> route) => false,
              );
            },
          ),
        );*/
      },
      bottomBar: bottomNavigationBarUnion(context, 1),
    );
  }
}
