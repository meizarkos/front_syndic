import 'package:flutter/material.dart';

import '../../../../models/work_request/create_work_request.dart';
import 'chose_date_time.dart';

class ChoseDateTimeCouncil extends StatelessWidget {
  const ChoseDateTimeCouncil({
    super.key,
    required this.createWorkRequest,
  });

  final CreateWorkRequest createWorkRequest;

  @override
  Widget build(BuildContext context) {
    return ChoseDateTime(
      createWorkRequest: createWorkRequest,
      route: '/work_requests/recap',
    );
  }
}

class ChoseDateTimeUnion extends StatelessWidget {
  const ChoseDateTimeUnion({
    super.key,
    required this.createWorkRequest,
  });

  final CreateWorkRequest createWorkRequest;

  @override
  Widget build(BuildContext context) {
    return ChoseDateTime(
      createWorkRequest: createWorkRequest,
      route: 'union/work_requests/recap',
    );
  }
}

class ChoseDateTimeUser extends StatelessWidget {
  const ChoseDateTimeUser({
    super.key,
    required this.createWorkRequest,
  });

  final CreateWorkRequest createWorkRequest;

  @override
  Widget build(BuildContext context) {
    return ChoseDateTime(
      createWorkRequest: createWorkRequest,
      route: '/user/work_requests/recap',
    );
  }
}
