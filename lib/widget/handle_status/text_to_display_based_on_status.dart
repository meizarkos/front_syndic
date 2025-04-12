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
    return AppText.estimateWaitingForClient;
  }
  if(status == 1){
    if(statusGoal == 3){
      return AppText.estimateWaitingForUser;
    }
    return '${AppText.estimateWaitingForUnion}\n${AppText.estimateWaitingForClient}';
  }
  return '';
}

Text textEstimateStatus(int? status, int? statusGoal, BuildContext context){
  return Text(
    textStatusEstimate(status, statusGoal),
    style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: status == statusGoal ? Colors.green : Colors.red,
    ),
  );
}
