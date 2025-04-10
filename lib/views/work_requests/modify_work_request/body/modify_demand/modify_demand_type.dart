import 'package:flutter/material.dart';
import 'package:front_syndic/views/work_requests/modify_work_request/body/modify_demand/modify_demand.dart';

import '../../../../../api_handler/work_request/delete_work_request.dart';
import '../../../../../api_handler/work_request/fetch_work_request_detail.dart';
import '../../../../../api_handler/work_request/patch_work_request.dart';

class RecapWorkRequestCouncil extends StatelessWidget {
  const RecapWorkRequestCouncil({
    super.key,
    required this.workRequestUuid,
  });

  final String workRequestUuid;

  @override
  Widget build(BuildContext context) {
    return RecapPatchWorkRequest(
      uuid: workRequestUuid,
      fetchDetailWorkRequest: fetchWorkRequestDetailCouncil,
      onDelete: (String? uuid)async{
        if(uuid == null) return;
        await deleteWorkRequestDetailCouncil(uuid);
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/council_main',
              (Route<dynamic> route) => false,
        );
      },
      onPatchApi: patchWorkRequestDetailCouncil,
    );
  }
}

class RecapWorkRequestUnion extends StatelessWidget {
  const RecapWorkRequestUnion({
    super.key,
    required this.workRequestUuid,
  });

  final String workRequestUuid;

  @override
  Widget build(BuildContext context) {
    return RecapPatchWorkRequest(
      uuid: workRequestUuid,
      fetchDetailWorkRequest: fetchWorkRequestDetailUnion,
      onDelete: (String? uuid) async {
        if (uuid == null) return;
        await deleteWorkRequestDetailUnion(uuid);
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/union/work_requests',
          (Route<dynamic> route) => false,
        );
      },
      onPatchApi: patchWorkRequestDetailUnion,
    );
  }
}

class RecapWorkRequestUser extends StatelessWidget {
  const RecapWorkRequestUser({
    super.key,
    required this.workRequestUuid,
  });

  final String workRequestUuid;

  @override
  Widget build(BuildContext context) {
    return RecapPatchWorkRequest(
      uuid: workRequestUuid,
      fetchDetailWorkRequest: fetchWorkRequestDetailUser,
      onDelete: (String? uuid) async {
        if (uuid == null) return;
        await deleteWorkRequestDetailUser(uuid);
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/user_main',
              (Route<dynamic> route) => false,
        );
      },
      onPatchApi: patchWorkRequestDetailUser,
    );
  }
}
