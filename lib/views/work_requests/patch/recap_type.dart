import 'package:flutter/material.dart';
import 'package:front_syndic/views/work_requests/patch/recap.dart';

import '../../../api_handler/work_request/delete_work_request.dart';
import '../../../api_handler/work_request/fetch_work_request_detail.dart';

class RecapWorkRequestCouncil extends StatelessWidget {
  const RecapWorkRequestCouncil({
    super.key,
    required this.workRequestUuid,
    required this.fetchWorkRequestDetail,
    required this.onBack,
    required this.onDelete,
  });

  final String? workRequestUuid;
  final Function(String?) fetchWorkRequestDetail;
  final Function() onBack;
  final Function(String?) onDelete;

  @override
  Widget build(BuildContext context) {
    return RecapPatchWorkRequest(
      uuid: workRequestUuid,
      fetchDetailWorkRequest: fetchWorkRequestDetail,
      onBack: onBack,
      onDelete: onDelete,
    );
  }
}

class RecapWorkRequestUnion extends StatelessWidget {
  const RecapWorkRequestUnion({
    super.key,
    required this.workRequestUuid,
  });

  final String? workRequestUuid;

  @override
  Widget build(BuildContext context) {
    return RecapPatchWorkRequest(
      uuid: workRequestUuid,
      fetchDetailWorkRequest: fetchWorkRequestDetailCouncil,
      onBack: ()=>{
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/union/work_requests', // The new route
              (Route<dynamic> route) => false, // Remove all previous routes
        )
      },
      onDelete: (String? uuid)async{
        if(uuid == null) return;
        await deleteWorkRequesDetail(uuid);
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/union/work_requests',
              (Route<dynamic> route) => false,
        );
      },
    );
  }
}
