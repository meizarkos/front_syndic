import 'package:flutter/material.dart';
import 'package:front_syndic/views/timing_estimate/list_timing_estimate/timing_estimate.dart';

import '../../../api_handler/paiement/paiement_council.dart';
import '../../../api_handler/timing_estimate/accept_timing_estimate.dart';
import '../../../api_handler/timing_estimate/delete_timing_estimate.dart';
import '../../../api_handler/timing_estimate/get_timing_estimate.dart';
import '../../../models/to_screen/see_conv_arg.dart';
import '../../../widget/handle_status/text_based_on_user.dart';

class TimingEstimateArtisan extends StatelessWidget {
  const TimingEstimateArtisan({
    super.key,
    required this.uuid,
  });

  final String? uuid;

  @override
  Widget build(BuildContext context) {
    return TimingEstimateView(
      fetchData: fetchTimingEstimateArtisan,
      uuid: uuid,
      valueValidateByYou: ValidateByYou.artisan,
      routeToPost:  '/artisan/create_timing_estimate',
      onAccept: (String? uuid) async {
        await acceptTimingEstimateArtisan(uuid);
        goToTimingEstimate(context);
      },
      onRefuse: (String? uuid) async {
        await deleteTimingEstimateArtisan(uuid);
        goToTimingEstimate(context);
      },
      role: RoleBasedText.artisan,
    );
  }

  void goToTimingEstimate(BuildContext context){
    if(uuid == null) return;
    Navigator.pushReplacementNamed(
      context,
      '/artisan/timing_estimate',
      arguments: uuid!,
    );
  }
}

class TimingEstimateCouncil extends StatelessWidget {
  const TimingEstimateCouncil({
    super.key,
    required this.uuid,
  });

  final String? uuid;

  @override
  Widget build(BuildContext context) {
    return TimingEstimateView(
      fetchData: fetchTimingEstimateCouncil,
      uuid: uuid,
      valueValidateByYou: ValidateByYou.council, //all value where the timing is validated by you
      routeToPost:  '/council/create_timing_estimate',
      onAccept: (String? uuid) async {
        await acceptTimingEstimateCouncil(uuid);
        goToTimingEstimate(context);
      },
      onRefuse: (String? uuid) async {
        await deleteTimingEstimateCouncil(uuid);
        goToTimingEstimate(context);
      },
      role: RoleBasedText.council,
      apiPaiement: (int amount,String currency) => createPaymentCouncil(amount, 'EUR'),
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
    required this.uuid,
  });

  final String? uuid;

  @override
  Widget build(BuildContext context) {
    return TimingEstimateView(
      fetchData: fetchTimingEstimateUnion,
      uuid: uuid,
      //valueOfValidation: 1,
      valueValidateByYou: ValidateByYou.union, //all value where the timing is validated by you
      routeToPost:  '/union/create_timing_estimate',
      onAccept: (String? uuid) async {
        await acceptTimingEstimateUnion(uuid);
        goToTimingEstimate(context);
      },
      onRefuse: (String? uuid) async {
        await deleteTimingEstimateUnion(uuid);
        goToTimingEstimate(context);
      },
      role: RoleBasedText.union,
      apiPaiement: (int amount,String currency) => createPaymentUnion(amount, 'EUR'),
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
