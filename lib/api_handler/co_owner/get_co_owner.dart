import 'package:front_syndic/api_handler/request.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/co_owner/co_owner.dart';

Future<CoOwner?> getCoOwner(String route) async {
  try{
    final res = await request(url: route, method: "GET");
    final coOwner = CoOwner.fromJson(res.data["co_owner"]);
    return coOwner;
  }
  catch(e){
    return null;
  }
}

Future<CoOwner?> getCoOwnerFromCouncil(String? _)async{
  return await getCoOwner('${APIValue.unionCouncil}co_owner_current');
}

Future<CoOwner?> getCoOwnerFromUnion(String? councilId)async{
  if(councilId == null){
    return null;
  }
  return await getCoOwner('${APIValue.union}co_owner_current_from_union/$councilId');
}