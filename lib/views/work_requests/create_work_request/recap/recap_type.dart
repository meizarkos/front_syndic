import 'package:flutter/material.dart';
import 'package:front_syndic/views/work_requests/create_work_request/recap/recap.dart';

import '../../../../api_handler/work_request/work_request_post.dart';
import '../../../../models/work_request/create_work_request.dart';

class RecapCouncilWorkRequest extends StatelessWidget {
  const RecapCouncilWorkRequest({
    super.key,
    required this.createWorkRequest,
  });

  final CreateWorkRequest createWorkRequest;

  @override
  Widget build(BuildContext context) {
    return RecapForCreateWorkRequest(
      createWorkRequest: createWorkRequest,
        onPost: (CreateWorkRequest createWorkRequest) async {
          await postWorkRequestCouncil(createWorkRequest);
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/co_owner/work_requests',
                (Route<dynamic> route) => false,
          );
        }
    );
  }
}

class RecapUnionWorkRequest extends StatelessWidget {
  const RecapUnionWorkRequest({
    super.key,
    required this.createWorkRequest,
  });

  final CreateWorkRequest createWorkRequest;

  @override
  Widget build(BuildContext context) {
    return RecapForCreateWorkRequest(
      createWorkRequest: createWorkRequest,
      onPost: (CreateWorkRequest createWorkRequest) async {
          await postWorkRequestUnion(createWorkRequest);
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/union/work_requests',
                (Route<dynamic> route) => false,
          );
        }
    );
  }
}
