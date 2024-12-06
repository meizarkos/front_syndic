import 'package:flutter/material.dart';

import '../../../../models/work_request/create_work_request.dart';
import 'category.dart';

class CategoryCouncil extends StatelessWidget {
  const CategoryCouncil({
    super.key,
    required this.createWorkRequest,
  });

  final CreateWorkRequest createWorkRequest;

  @override
  Widget build(BuildContext context) {
    return WorkRequestCategory(
      createWorkRequest: createWorkRequest,
      route : '/work_requests/chose_date_time'
    );
  }
}

class CategoryUnion extends StatelessWidget {
  const CategoryUnion({
    super.key,
    required this.createWorkRequest,
  });

  final CreateWorkRequest createWorkRequest;

  @override
  Widget build(BuildContext context) {
    return WorkRequestCategory(
        createWorkRequest: createWorkRequest,
        route : 'union/work_requests/chose_date_time'
    );
  }
}
