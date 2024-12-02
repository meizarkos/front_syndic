import 'package:flutter/material.dart';
import 'package:front_syndic/views/estimate/estimate_detail/estimate_detail.dart';

class EstimateDetailCouncil extends StatelessWidget {
  const EstimateDetailCouncil({
    super.key,
    required this.fetchData,
    required this.uuid,
  });

  final Function(String?) fetchData;
  final String? uuid;

  @override
  Widget build(BuildContext context) {
    return EstimateDetail(
      fetchData: fetchData,
      uuid: uuid,
    );
  }
}
