import 'package:flutter/material.dart';
import 'package:front_syndic/views/work_requests/patch/recap.dart';

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
