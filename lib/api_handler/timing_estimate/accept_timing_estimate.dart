import 'package:front_syndic/api_handler/timing_estimate/refuse_timing_estimate.dart';

import '../../core_value.dart';

Future<void> acceptTimingEstimateArtisan(String? uuid)async{
  if(uuid == null) return;
  await refuseTimingEstimate('${APIValue.artisan}accept_timing_estimate_artisan/$uuid');
}

Future<void> acceptTimingEstimateCouncil(String? uuid)async{
  if(uuid == null) return;
  await refuseTimingEstimate('${APIValue.unionCouncil}accept_timing_estimate_council/$uuid');
}

Future<void> acceptTimingEstimateUnion(String? uuid)async{
  if(uuid == null) return;
  await refuseTimingEstimate('${APIValue.union}accept_timing_estimate_union/$uuid');
}