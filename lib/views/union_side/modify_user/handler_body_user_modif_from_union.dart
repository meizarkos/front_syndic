import 'package:flutter/cupertino.dart';
import 'package:front_syndic/text/fr.dart';

import '../../user/modify_user/modify_user_type.dart';
import 'modify_adress_user_from_union.dart';

Widget handlerBodyForModifyUserFromUnion(String category,String? userUuid){
  if(category == AppText.user){
    return ModifyUserForUnion(userUuid: userUuid);
  }
  else if(category == AppText.adress){
    return ModifyAdressUserFromUnion(userUuid: userUuid);
  }
  else{
    return ModifyUserForUnion(userUuid: userUuid);
  }
}