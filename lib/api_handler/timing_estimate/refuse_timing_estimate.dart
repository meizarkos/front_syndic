import 'package:front_syndic/api_handler/request.dart';
import 'package:front_syndic/core_value.dart';

Future<void> refuseTimingEstimate(String route)async{
  try{
    final responsse = await request(url: route, method: 'PATCH');
    return;
  }
  catch(e){
    return;
  }
}

Future<void> refuseTimingEstimateArtisan(String? uuid)async{
  if(uuid == null) return;
  await refuseTimingEstimate('${APIValue.artisan}refuse_timing_estimate_artisan/$uuid');
}

Future<void> refuseTimingEstimateCouncil(String? uuid)async{
  if(uuid == null) return;
  await refuseTimingEstimate('${APIValue.unionCouncil}refuse_timing_estimate_council/$uuid');
}

Future<void> refuseTimingEstimateUnion(String? uuid)async{
  if(uuid == null) return;
  await refuseTimingEstimate('${APIValue.union}refuse_timing_estimate_union/$uuid');
}