import 'package:flutter/material.dart';
import 'package:front_syndic/views/work_requests/modify_work_request/body/modify_demand/modify_demand_type.dart';

import '../../../../text/fr.dart';
import '../body/adress/modify_adress_type.dart';
import '../body/dispo/timing_recap_type.dart';

Widget handlerBodyUser(String category,String workRequestUuid){
  if(category == AppText.demand){
    return RecapWorkRequestUser(workRequestUuid: workRequestUuid);
  }
  else if(category == AppText.dispo){
    return TimingRecapUser(workRequestUuid: workRequestUuid);
  }
  else if(category == AppText.adress){
    return ModifyAdressWorkRequestUser(workRequestUuid: workRequestUuid);
  }
  else{
    return RecapWorkRequestUser(workRequestUuid: workRequestUuid);
  }
}