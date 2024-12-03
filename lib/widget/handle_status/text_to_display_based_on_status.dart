import 'package:flutter/material.dart';
import 'package:front_syndic/text/fr.dart';

String textStatusEstimate(int? status, int? statusGoal){
  if(status == null || statusGoal == null){
    return '';
  }
  if(status == statusGoal){
    return AppText.estimateValidate;
  }
  if(status == 3){
    return AppText.estimateWaitingForUnion;
  }
  if(status == 5){
    return AppText.estimateWaitingForCouncil;
  }
  if(status == 1){
    if(statusGoal == 3){
      return AppText.estimateWaitingForUser;
    }
    return '${AppText.estimateWaitingForUnion}\n${AppText.estimateWaitingForCouncil}';
  }
  return '';
}

Text textEstimateStatus(int? status, int? statusGoal, BuildContext context){
  return Text(
    textStatusEstimate(status, statusGoal),
    style: Theme.of(context).textTheme.displayMedium,
  );
}
