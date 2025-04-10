import 'package:flutter/material.dart';
import 'package:front_syndic/views/work_requests/modify_work_request/body/dispo/timing_recap.dart';

import '../../../../../api_handler/timing/get_timings.dart';
import '../../../../../api_handler/timing/patch_timing_of_work_request.dart';

class TimingRecapCouncil extends StatelessWidget {
  const TimingRecapCouncil({
    super.key,
    required this.workRequestUuid,
  });

  final String workRequestUuid;

  @override
  Widget build(BuildContext context) {
    return RecapTimingChange(
      uuid: workRequestUuid,
      fetchAllTimingFromWorkRequest: fetchTimingFromWorkRequestCouncil,
      patchAllTimingFromWorkRequest: patchTimingFromWorkRequestCouncil,
    );
  }
}

class TimingRecapUnion extends StatelessWidget {
  const TimingRecapUnion({
    super.key,
    required this.workRequestUuid,
  });

  final String workRequestUuid;

  @override
  Widget build(BuildContext context) {
    return RecapTimingChange(
      uuid: workRequestUuid,
      fetchAllTimingFromWorkRequest: fetchTimingFromWorkRequestUnion,
      patchAllTimingFromWorkRequest: patchTimingFromWorkRequestUnion,
    );
  }
}

class TimingRecapUser extends StatelessWidget {
  const TimingRecapUser({
    super.key,
    required this.workRequestUuid,
  });

  final String workRequestUuid;

  @override
  Widget build(BuildContext context) {
    return RecapTimingChange(
      uuid: workRequestUuid,
      fetchAllTimingFromWorkRequest: fetchTimingFromWorkRequestUser,
      patchAllTimingFromWorkRequest: patchTimingFromWorkRequestUser,
    );
  }
}
