import 'package:front_syndic/api_handler/request.dart';

import '../../core_value.dart';

Future<void> patchStatusAccountUser(String route)async{
  try{
    final response = await request(url: route, method: "PATCH");
    return;
  }
  catch(e){
    return;
  }
}

Future<void> activateAccountUser(String? apartmentUuid)async{
  if(apartmentUuid == null){
    return;
  }
  return await patchStatusAccountUser('${APIValue.union}allow_user/$apartmentUuid');
}

Future<void> deactivateAccountUser(String? apartmentUuid)async{
  if(apartmentUuid == null){
    return;
  }
  return await patchStatusAccountUser('${APIValue.union}disallow_user/$apartmentUuid');
}