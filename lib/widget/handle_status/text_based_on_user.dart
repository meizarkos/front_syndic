import 'package:flutter/material.dart';
import 'package:front_syndic/text/fr.dart';

class RoleBasedText{
  static const String union = 'union';
  static const String council = 'council';
  static const String user = 'user';
}

String textStatusEstimate(int? status, int? statusGoal,String role){
  if(status == null || statusGoal == null){
    return '';
  }
  if(status == statusGoal){
    return AppText.estimateValidate;
  }
  if(status == 3){
    if(role == RoleBasedText.union){
      return AppText.estimateWaitingForYou;
    }
    return AppText.estimateWaitingForUnion;
  }
  if(status == 5){
    if(role == RoleBasedText.council){
      return AppText.estimateWaitingForYou;
    }
    return AppText.estimateWaitingForCouncil;
  }
  if(status == 1){
    if(statusGoal == 3){
      return AppText.estimateWaitingForYou;
    }
    if(role == RoleBasedText.union){
      return "${AppText.estimateWaitingForYou}\n${AppText.estimateWaitingForCouncil}";
    }
    if(role == RoleBasedText.council){
      return "${AppText.estimateWaitingForYou}\n${AppText.estimateWaitingForUnion}";
    }
    return '${AppText.estimateWaitingForUnion}\n${AppText.estimateWaitingForCouncil}';
  }
  return '';
}

Text textEstimateStatusUser(int? status, int? statusGoal, BuildContext context,String role){
  return Text(
    textStatusEstimate(status, statusGoal,role),
    style: Theme.of(context).textTheme.displaySmall,
  );
}
