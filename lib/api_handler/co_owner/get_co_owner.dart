import 'package:front_syndic/api_handler/request.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/co_owner/co_owner.dart';

Future<CoOwner?> getCoOwner() async {
  try{
    final res = await request(url: '${APIValue.unionCouncil}co_owner_current', method: "GET");
    final coOwner = CoOwner.fromJson(res.data["co_owner"]);
    return coOwner;
  }
  catch(e){
    return null;
  }
}