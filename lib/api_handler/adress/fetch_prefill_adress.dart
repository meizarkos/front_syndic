import 'package:front_syndic/api_handler/request.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/adress/adress.dart';

Future<Adress> fetchPrefillAdress(String route) async {
  try{
    final res = await request(url: route, method: "GET");
    final data = res.data;
    return Adress.fromJson(data);
  }
  catch(e){
    return Adress();
  }
}

Future<Adress> fetchAdressCouncilFromUnion(String? councilId)async{
  if(councilId == null){
    return Adress();
  }
  return await fetchPrefillAdress('${APIValue.union}adress_council_by_id/$councilId');
}

Future<Adress> fetchAdressUserFromUnion(String? userId)async{
  if(userId == null){
    return Adress();
  }
  return await fetchPrefillAdress('${APIValue.union}adress_user/$userId');
}

Future<Adress> fetchAdressWorkRequestUnion(String? workRequestUuid)async{
  if(workRequestUuid == null){
    return Adress();
  }
  return await fetchPrefillAdress('${APIValue.union}adress_work_request_union/$workRequestUuid');
}

Future<Adress> fetchAdressWorkRequestCouncil(String? workRequestUuid)async{
  if(workRequestUuid == null){
    return Adress();
  }
  return await fetchPrefillAdress('${APIValue.unionCouncil}adress_work_request_council/$workRequestUuid');
}

Future<Adress> fetchAdressWorkRequestUser(String? workRequestUuid)async{
  if(workRequestUuid == null){
    return Adress();
  }
  return await fetchPrefillAdress('${APIValue.user}adress_work_request_user/$workRequestUuid');
}

Future<Adress> fetchAdressCouncil()async{
  return await fetchPrefillAdress('${APIValue.unionCouncil}adress_council');
}

Future<Adress> fetchAdressUser(String? n)async{
  return await fetchPrefillAdress('${APIValue.user}adress_user');
}

Future<Adress> fetchAdressArtisan(String? useless)async{
  return await fetchPrefillAdress('${APIValue.artisan}adress_artisan');
}

Future<Adress> fetchAdressCouncilForModification(String? useless)async{
  return await fetchPrefillAdress('${APIValue.unionCouncil}adress_council');
}

Future<Adress> fetchAdressUnion(String? useless)async{
  return await fetchPrefillAdress('${APIValue.union}adress_union');
}