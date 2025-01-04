import 'package:front_syndic/api_handler/request.dart';
import 'package:front_syndic/core_value.dart';

import '../../models/union/union.dart';

Future<UnionApi?> getUnion()async{
  try{
    final res = await request(url: '${APIValue.union}union_current', method: "GET");
    final union = UnionApi.fromJson(res.data);
    return union;
  }
  catch(e){
    return null;
  }
}