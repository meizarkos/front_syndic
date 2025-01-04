import 'package:flutter/cupertino.dart';
import 'package:front_syndic/text/fr.dart';

import '../../account/council/modify_council/modify_council_type.dart';
import 'modify_adress_council_from_union.dart';

Widget handlerBodyForModifyCouncilFromUnion(String category,String? councilId){
  if(category == AppText.council){
    return ModifyCouncilForUnion(councilId: councilId);
  }
  else if(category == AppText.adress){
    return ModifyAdressCouncilFromUnion(councilId: councilId);
  }
  else{
    return ModifyCouncilForUnion(councilId: councilId);
  }
}