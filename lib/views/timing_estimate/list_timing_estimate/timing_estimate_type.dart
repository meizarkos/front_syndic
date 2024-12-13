import 'package:flutter/material.dart';
import 'package:front_syndic/views/timing_estimate/list_timing_estimate/timing_estimate.dart';

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
    );
  }
}
