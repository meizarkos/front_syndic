import 'package:flutter/material.dart';
import 'package:front_syndic/views/work_requests/modify_work_request/body/modify_demand/modify_demand_type.dart';

import '../../../../text/fr.dart';

Widget handlerBodyUnion(String category,String workRequestUuid){
  if(category == AppText.demand){
    return RecapWorkRequestUnion(workRequestUuid: workRequestUuid);
  }
  else if(category == AppText.dispo){
    return const Text('T');
  }
  else if(category == AppText.adress){
    return const Text('Adress');
  }
  else{
    return const Text('Demand');
  }
}