import 'package:flutter/material.dart';
import 'package:front_syndic/views/process/body_in_progress/body_in_progress_type.dart';

import '../../../text/fr.dart';

Widget topScreenRouteHandlerCouncil(String searchValue,String category){
  if(category == AppText.conversation){
    return BodyInProgressCouncilConversation(searchValue: searchValue);
  }
  else if(category == AppText.timing){
    return BodyInProgressCouncilTiming(searchValue: searchValue);
  }
  else if(category == AppText.estimate){
    return BodyInProgressCouncilEstimate(searchValue: searchValue);
  }
  else if(category == AppText.timingEstimate){
    return BodyInProgressCouncilTimingEstimate(searchValue: searchValue);
  }
  else{
    return Container();
  }
}