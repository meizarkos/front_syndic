import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:front_syndic/core_value.dart';

import '../../../models/timing/timing_estimate.dart';
import '../../../text/fr.dart';
import '../../../utils/date_to_string/date.dart';
import '../../../widget/decoration/decoration_round_main_color.dart';

class CellTimingEstimate extends StatelessWidget {
  const CellTimingEstimate({
    super.key,
    required this.timingEstimate,
    required this.isValidate,
    required this.isAtYou,
    required this.onValidate,
    required this.onDelete,
    required this.onRefuse,
  });

  final TimingEstimate timingEstimate;
  final bool isValidate;
  final bool isAtYou;
  final Function(String?) onValidate;
  final Function(String?) onDelete;
  final Function(String?) onRefuse;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: decorationRoundMainColor(),
          padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  '${AppText.workStart}: ${formatStringToApiDate(timingEstimate.dateStart, 'dd/MM/yyyy') ?? AppText.noDate} ${AppText.at} ${formatTimeString(timingEstimate.timeStart)}',
                  style: Theme.of(context).textTheme.displaySmall
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              Text(
                  '${AppText.workEnd}: ${AppText.le} ${formatStringToApiDate(timingEstimate.dateStart, 'dd/MM/yyyy') ?? AppText.noDate}',
                  style: Theme.of(context).textTheme.displaySmall
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if(isValidate)
                    IconButton(
                        onPressed: ()=>{},
                        icon: Icon(Icons.delete),
                    ),
                  if(!isValidate)
                    IconButton(
                      onPressed: ()=>{},
                      icon: Icon(Icons.check),
                    ),
                  const SizedBox(width: AppUIValue.spaceScreenToAny),
                  if(isAtYou)
                    GestureDetector(
                      onTap: ()=>{},
                      child: SvgPicture.asset(
                      'assets/close.svg',
                      colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
                      width: 20.0,
                      height: 20.0,
                      ),
                    ),
                ],
              )
            ],
          )
        ),
        const SizedBox(height: AppUIValue.spaceScreenToAny),
      ],
    );
  }
}
