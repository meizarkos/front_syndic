import 'package:flutter/material.dart';
import 'package:front_syndic/views/estimate/estimate_artisan/estimate_detail_artisan.dart';

class EstimateDetailArtisan extends StatelessWidget {
  const EstimateDetailArtisan({
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
