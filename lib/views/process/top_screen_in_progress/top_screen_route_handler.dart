import 'package:flutter/material.dart';
import 'package:front_syndic/views/process/body_in_progress/council/body_in_progress_council.dart';

import '../../../text/fr.dart';
import '../body_in_progress/artisan/body_in_progress_artisan.dart';

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

Widget topScreenRouteHandlerArtisan(String searchValue,String category){
  if(category == AppText.conversation){
    return BodyInProgressArtisanConversation(searchValue: searchValue);
  }
  else if(category == AppText.timing){
    return BodyInProgressArtisanTiming(searchValue: searchValue);
  }
  else if(category == AppText.estimate){
    return BodyInProgressArtisanEstimate(searchValue: searchValue);
  }
  else if(category == AppText.timingEstimate){
    return BodyInProgressArtisanTimingEstimate(searchValue: searchValue);
  }
  else{
    return Container();
  }
}