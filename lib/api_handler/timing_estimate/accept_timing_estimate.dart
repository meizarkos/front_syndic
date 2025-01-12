
import '../../core_value.dart';
import '../request.dart';


Future<void> acceptTimingEstimate(String route)async{
  try{
    final responsse = await request(url: route, method: 'PATCH');
    return;
  }
  catch(e){
    return;
  }
}

Future<void> acceptTimingEstimateArtisan(String? uuid)async{
  if(uuid == null) return;
  await acceptTimingEstimate('${APIValue.artisan}accept_timing_estimate_artisan/$uuid');
}

Future<void> acceptTimingEstimateCouncil(String? uuid)async{
  if(uuid == null) return;
  await acceptTimingEstimate('${APIValue.unionCouncil}accept_timing_estimate_council/$uuid');
}

Future<void> acceptTimingEstimateUnion(String? uuid)async{
  if(uuid == null) return;
  await acceptTimingEstimate('${APIValue.union}accept_timing_estimate_union/$uuid');
}