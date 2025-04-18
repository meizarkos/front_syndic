import 'package:flutter/material.dart';
import 'package:front_syndic/views/timing_estimate/timing_estimate_detail/timing_estimate.dart';

import '../../../api_handler/paiement/paiement_council.dart';
import '../../../api_handler/timing_estimate/accept_timing_estimate.dart';
import '../../../api_handler/timing_estimate/delete_timing_estimate.dart';
import '../../../api_handler/timing_estimate/get_timing_estimate.dart';
import '../../../widget/handle_status/text_based_on_user.dart';

class TimingEstimateArtisan extends StatelessWidget {
  const TimingEstimateArtisan({
    super.key,
    required this.convUuid,
  });

  final String? convUuid;

  @override
  Widget build(BuildContext context) {
    return TimingEstimateView(
      fetchData: fetchTimingEstimateArtisan,
      uuid: convUuid,
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
      goBack: () {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/artisan/see_conv', arguments: convUuid);
      },
      role: RoleBasedText.artisan,
    );
  }

  void goToTimingEstimate(BuildContext context){
    if(convUuid == null) return;
    Navigator.pushReplacementNamed(
      context,
      '/artisan/timing_estimate',
      arguments: convUuid!,
    );
  }
}

class TimingEstimateUnion extends StatelessWidget {
  const TimingEstimateUnion({
    super.key,
    required this.convUuid,
  });

  final String? convUuid;

  @override
  Widget build(BuildContext context) {
    return TimingEstimateView(
      fetchData: fetchTimingEstimateUnion,
      uuid: convUuid,
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
      goBack: () {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, 'union/specific_conv', arguments: convUuid);
      },
      role: RoleBasedText.union,
      apiPaiement: (int amount,String currency) => createPaymentUnion(amount, 'EUR'),
    );
  }

  void goToTimingEstimate(BuildContext context){
    if(convUuid == null) return;
    Navigator.pushReplacementNamed(
      context,
      '/union/timing_estimate',
      arguments: convUuid!,
    );
  }
}

class TimingEstimateCouncil extends StatelessWidget {
  const TimingEstimateCouncil({
    super.key,
    required this.convUuid,
  });

  final String? convUuid;

  @override
  Widget build(BuildContext context) {
    return TimingEstimateView(
      fetchData: fetchTimingEstimateCouncil,
      uuid: convUuid,
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
      goBack: () {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/council/see_conv', arguments: convUuid);
      },
      role: RoleBasedText.council,
      apiPaiement: (int amount,String currency) => createPaymentCouncil(amount, 'EUR'),
    );
  }

  void goToTimingEstimate(BuildContext context){
    if(convUuid == null) return;
    Navigator.pushReplacementNamed(
      context,
      '/council/timing_estimate',
      arguments: convUuid!,
    );
  }
}

class TimingEstimateUser extends StatelessWidget {
  const TimingEstimateUser({
    super.key,
    required this.convUuid,
  });

  final String? convUuid;

  @override
  Widget build(BuildContext context) {
    return TimingEstimateView(
      fetchData: fetchTimingEstimateUser,
      uuid: convUuid,
      valueValidateByYou: ValidateByYou.council, // is council but work for user
      routeToPost:  '/user/create_timing_estimate',
      onAccept: (String? uuid) async {
        await acceptTimingEstimateUser(uuid);
        goToTimingEstimate(context);
      },
      onRefuse: (String? uuid) async {
        await deleteTimingEstimateUser(uuid);
        goToTimingEstimate(context);
      },
      goBack: () {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/user/see_conv', arguments: convUuid);
      },
      role: RoleBasedText.council,
      apiPaiement: (int amount,String currency) => createPaymentCouncil(amount, 'EUR'),
    );
  }

  void goToTimingEstimate(BuildContext context){
    if(convUuid == null) return;
    Navigator.pushReplacementNamed(
      context,
      '/user/timing_estimate',
      arguments: convUuid!,
    );
  }
}



