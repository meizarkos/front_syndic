import '../../core_value.dart';
import '../request.dart';

Future<void> deleteTimingEstimate(String route)async{
  try{
    final responsse = await request(url: route, method: 'DELETE');
    return;
  }
  catch(e){
    return;
  }
}

Future<void> deleteTimingEstimateArtisan(String? uuid)async{
  if(uuid == null) return;
  await deleteTimingEstimate('${APIValue.artisan}timing_estimate_artisan/$uuid');
}

Future<void> deleteTimingEstimateCouncil(String? uuid)async{
  if(uuid == null) return;
  await deleteTimingEstimate('${APIValue.unionCouncil}timing_estimate_council/$uuid');
}

Future<void> deleteTimingEstimateUnion(String? uuid)async{
  if(uuid == null) return;
  await deleteTimingEstimate('${APIValue.union}timing_estimate_union/$uuid');
}