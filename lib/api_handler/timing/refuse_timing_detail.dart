import 'package:front_syndic/api_handler/request.dart';
import 'package:front_syndic/core_value.dart';

Future<void> refuseTimingDetail(String route)async{
  try{
      request(url: route, method: "PATCH");
      return;
  }
  catch(e){
    return;
  }
}

Future<void> refuseTimingDetailCouncil(String? uuid)async{
  if(uuid == null){
    return;
  }
  await refuseTimingDetail('${APIValue.unionCouncil}timing_refuse/$uuid');
}