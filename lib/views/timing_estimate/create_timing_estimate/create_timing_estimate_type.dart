import 'package:flutter/material.dart';
import 'package:front_syndic/models/to_screen/see_conv_arg.dart';
import 'package:front_syndic/views/timing_estimate/create_timing_estimate/create_timing_estimate.dart';

import '../../../api_handler/timing_estimate/get_timing_estimate.dart';
import '../../../api_handler/timing_estimate/post_timing_estimate.dart';
import '../../../models/timing/timing_estimate.dart';

class CreateTimingEstimateArtisan extends StatelessWidget {
  const CreateTimingEstimateArtisan({
    super.key,
    required this.timingEstimate,
  });

  final TimingEstimate timingEstimate;

  @override
  Widget build(BuildContext context) {
    return CreateTimingEstimate(
        timingEstimate: timingEstimate,
        onBack: (){
          goToTimingEstimate(context);
        },
        onRegister: (TimingEstimate timingEstimate)async{
          await postTimingEstimateArtisan(timingEstimate);
          goToTimingEstimate(context);
        },
    );
  }

  void goToTimingEstimate(BuildContext context){
    if(timingEstimate.estimateId == null) return;
    Navigator.pushReplacementNamed(
      context,
      'artisan/timing_estimate',
      arguments: SeeConvArg(uuid: timingEstimate.estimateId!, futureToFetchData: fetchTimingEstimateArtisan),
    );
  }
}

class CreateTimingEstimateCouncil extends StatelessWidget {
  const CreateTimingEstimateCouncil({
    super.key,
    required this.timingEstimate,
  });

  final TimingEstimate timingEstimate;

  @override
  Widget build(BuildContext context) {
    return CreateTimingEstimate(
      timingEstimate: timingEstimate,
      onBack: (){
        goToTimingEstimate(context);
      },
      onRegister: (TimingEstimate timingEstimate)async{
        //call API to create timing estimate
        await postTimingEstimateCouncil(timingEstimate);
        goToTimingEstimate(context);
      },
    );
  }

  void goToTimingEstimate(BuildContext context){
    if(timingEstimate.estimateId == null) return;
    Navigator.pushReplacementNamed(
      context,
      '/council/timing_estimate',
      arguments: SeeConvArg(uuid: timingEstimate.estimateId!, futureToFetchData: fetchTimingEstimateCouncil),
    );
  }
}


class CreateTimingEstimateUnion extends StatelessWidget {
  const CreateTimingEstimateUnion({
    super.key,
    required this.timingEstimate,
  });

  final TimingEstimate timingEstimate;

  @override
  Widget build(BuildContext context) {
    return CreateTimingEstimate(
      timingEstimate: timingEstimate,
      onBack: (){
        goToTimingEstimate(context);
      },
      onRegister: (TimingEstimate timingEstimate)async{
        //call API to create timing estimate
        await postTimingEstimateUnion(timingEstimate);
        goToTimingEstimate(context);
      },
    );
  }

  void goToTimingEstimate(BuildContext context){
    if(timingEstimate.estimateId == null) return;
    Navigator.pushReplacementNamed(
      context,
      '/union/timing_estimate',
      arguments: SeeConvArg(uuid: timingEstimate.estimateId!, futureToFetchData: fetchTimingEstimateUnion),
    );
  }
}
