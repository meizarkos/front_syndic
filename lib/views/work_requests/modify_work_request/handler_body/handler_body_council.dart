import 'package:flutter/material.dart';

import '../../../../text/fr.dart';
import '../body/dispo/timing_recap_type.dart';
import '../body/modify_demand/modify_demand_type.dart';

Widget handlerBodyCouncil(String category,String workRequestUuid){
  if(category == AppText.demand){
    return RecapWorkRequestCouncil(workRequestUuid: workRequestUuid);
  }
  else if(category == AppText.dispo){
    return TimingRecapCouncil(workRequestUuid: workRequestUuid);
  }
  else if(category == AppText.adress){
    return const Text('Adress');
  }
  else{
    return const Text('Demand');
  }
}