import 'package:flutter/material.dart';
import 'package:front_syndic/text/fr.dart';

class RoleBasedText{
  static const String union = 'union';
  static const String council = 'council';
  static const String user = 'user';
  static const String artisan = 'artisan';
}

class ValidateByYou{
  static const List<int> artisan = [1,3,5,7];
  static const List<int> council = [2,3,6,7];
  static const List<int> union = [4,5,6,7];
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
    if(role == RoleBasedText.council || role == RoleBasedText.user){
      return AppText.estimateWaitingForYou;
    }
    return AppText.estimateWaitingForClient;
  }
  if(status == 1){
    if(statusGoal == 3){
      return AppText.estimateWaitingForYou;
    }
    if(role == RoleBasedText.union){
      return "${AppText.estimateWaitingForYou}\n${AppText.estimateWaitingForClient}";
    }
    if(role == RoleBasedText.council || role == RoleBasedText.user){
      return "${AppText.estimateWaitingForYou}\n${AppText.estimateWaitingForUnion}";
    }
    return '${AppText.estimateWaitingForUnion}\n${AppText.estimateWaitingForClient}';
  }
  return '';
}

Text textEstimateStatusUser(int? status, int? statusGoal, BuildContext context,String role){
  return Text(
    textStatusEstimate(status, statusGoal,role),
    style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: status == statusGoal ? Colors.green : Colors.red,
    ),
  );
}

String timingEstimateHandleValidation(int? status, int? statusGoal,String role){
  if(status == null || statusGoal == null){
    return '';
  }

  if(status == statusGoal){
    return AppText.validTimingEstimate;
  }

  String res = '';

  if(role == RoleBasedText.union){
    if(!ValidateByYou.union.contains(status)){
      res += '${AppText.estimateWaitingForYou}\n';
    }
    if(!ValidateByYou.council.contains(status)){
      res += '${AppText.estimateWaitingForClient}\n';
    }
    if(!ValidateByYou.artisan.contains(status)){
      res += AppText.estimateWaitingForArtisan;
    }
  }
  else if(role == RoleBasedText.council){
    if(!ValidateByYou.council.contains(status)){
      res += '${AppText.estimateWaitingForYou}\n';
    }
    if(!ValidateByYou.union.contains(status)){
      res += '${AppText.estimateWaitingForUnion}\n';
    }
    if(!ValidateByYou.artisan.contains(status)){
      res += AppText.estimateWaitingForArtisan;
    }
  }
  else if(role == RoleBasedText.artisan){
    if(!ValidateByYou.artisan.contains(status)){
      res += '${AppText.estimateWaitingForYou}\n';
    }
    if(!ValidateByYou.union.contains(status)){
      res += '${AppText.estimateWaitingForUnion}\n';
    }
    if(!ValidateByYou.council.contains(status)){
      res += AppText.estimateWaitingForClient;
    }
  }

  return res;
}
