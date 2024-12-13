import 'package:flutter/material.dart';

import '../../../models/timing/timing_estimate.dart';
import '../../../widget/decoration/decoration_round_main_color.dart';

class CellTimingEstimate extends StatelessWidget {
  const CellTimingEstimate({
    super.key,
    required this.timingEstimate,
    required this.isValidate,
  });

  final TimingEstimate timingEstimate;
  final bool isValidate;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decorationRoundMainColor(),
      child: Text(
        timingEstimate.dateStart!,
        style: TextStyle(
          color: isValidate ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
