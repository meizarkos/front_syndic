import 'package:flutter/material.dart';
import 'package:front_syndic/views/work_requests/create_work_request/title_desc/title_and_desc.dart';

import '../../../../models/work_request/create_work_request.dart';

class TitleAndDescCouncil extends StatelessWidget {
  const TitleAndDescCouncil({
    super.key,
    required this.createWorkRequest,
  });

  final CreateWorkRequest createWorkRequest;

  @override
  Widget build(BuildContext context) {
    return TitleAndDesc(
      createWorkRequest: createWorkRequest,
      route: '/work_requests/category',
    );
  }
}

class TitleAndDescUnion extends StatelessWidget {
  const TitleAndDescUnion({
    super.key,
    required this.createWorkRequest,
  });

  final CreateWorkRequest createWorkRequest;

  @override
  Widget build(BuildContext context) {
    return TitleAndDesc(
      createWorkRequest: createWorkRequest,
      route: 'union/work_requests/category',
    );
  }
}

class TitleAndDescUser extends StatelessWidget {
  const TitleAndDescUser({
    super.key,
    required this.createWorkRequest,
  });

  final CreateWorkRequest createWorkRequest;

  @override
  Widget build(BuildContext context) {
    return TitleAndDesc(
      createWorkRequest: createWorkRequest,
      route: '/user/work_requests/category',
    );
  }
}
