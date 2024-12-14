import 'package:flutter/material.dart';
import 'package:front_syndic/views/timing_estimate/list_timing_estimate/timing_estimate.dart';

import '../../../api_handler/timing_estimate/accept_timing_estimate.dart';
import '../../../api_handler/timing_estimate/delete_timing_estimate.dart';
import '../../../api_handler/timing_estimate/get_timing_estimate.dart';
import '../../../api_handler/timing_estimate/refuse_timing_estimate.dart';
import '../../../models/to_screen/see_conv_arg.dart';

class TimingEstimateArtisan extends StatelessWidget {
  const TimingEstimateArtisan({
    super.key,
    required this.fetchData,
    required this.uuid,
  });

  final Function(String?) fetchData;
  final String? uuid;

  @override
  Widget build(BuildContext context) {
    return TimingEstimateView(
      fetchData: fetchData,
      uuid: uuid,
      //valueOfValidation: 1,
      valueValidateByYou: [1,3,5], //all value where the timing is validated by you
      routeToPost:  '/artisan/create_timing_estimate',
      onAccept: (String? uuid) async {
        await acceptTimingEstimateArtisan(uuid);
        goToTimingEstimate(context);
      },
      onRefuse: (String? uuid) async {
        await refuseTimingEstimateArtisan(uuid);
        goToTimingEstimate(context);
      },
      onDelete: (String? uuid) async {
        await deleteTimingEstimateArtisan(uuid);
        goToTimingEstimate(context);
      },
    );
  }

  void goToTimingEstimate(BuildContext context){
    if(uuid == null) return;
    Navigator.pushReplacementNamed(
      context,
      'artisan/timing_estimate',
      arguments: SeeConvArg(uuid: uuid!, futureToFetchData: fetchTimingEstimateArtisan),
    );
  }
}

class TimingEstimateCouncil extends StatelessWidget {
  const TimingEstimateCouncil({
    super.key,
    required this.fetchData,
    required this.uuid,
  });

  final Function(String?) fetchData;
  final String? uuid;

  @override
  Widget build(BuildContext context) {
    return TimingEstimateView(
      fetchData: fetchData,
      uuid: uuid,
      //valueOfValidation: 1,
      valueValidateByYou: [2,3,6], //all value where the timing is validated by you
      routeToPost:  '/council/create_timing_estimate',
      onAccept: (String? uuid) async {
        await acceptTimingEstimateCouncil(uuid);
        goToTimingEstimate(context);
      },
      onRefuse: (String? uuid) async {
        await refuseTimingEstimateCouncil(uuid);
        goToTimingEstimate(context);
      },
      onDelete: (String? uuid) async {
        await deleteTimingEstimateCouncil(uuid);
        goToTimingEstimate(context);
      },
    );
  }

  void goToTimingEstimate(BuildContext context){
    if(uuid == null) return;
    Navigator.pushReplacementNamed(
      context,
      '/council/timing_estimate',
      arguments: SeeConvArg(uuid: uuid!, futureToFetchData: fetchTimingEstimateCouncil),
    );
  }
}

class TimingEstimateUnion extends StatelessWidget {
  const TimingEstimateUnion({
    super.key,
    required this.fetchData,
    required this.uuid,
  });

  final Function(String?) fetchData;
  final String? uuid;

  @override
  Widget build(BuildContext context) {
    return TimingEstimateView(
      fetchData: fetchData,
      uuid: uuid,
      //valueOfValidation: 1,
      valueValidateByYou: [4,6], //all value where the timing is validated by you
      routeToPost:  '/union/create_timing_estimate',
      onAccept: (String? uuid) async {
        await acceptTimingEstimateUnion(uuid);
        goToTimingEstimate(context);
      },
      onRefuse: (String? uuid) async {
        await refuseTimingEstimateUnion(uuid);
        goToTimingEstimate(context);
      },
      onDelete: (String? uuid) async {
        await deleteTimingEstimateUnion(uuid);
        goToTimingEstimate(context);
      },
    );
  }

  void goToTimingEstimate(BuildContext context){
    if(uuid == null) return;
    Navigator.pushReplacementNamed(
      context,
      '/union/timing_estimate',
      arguments: SeeConvArg(uuid: uuid!, futureToFetchData: fetchTimingEstimateUnion),
    );
  }
}
