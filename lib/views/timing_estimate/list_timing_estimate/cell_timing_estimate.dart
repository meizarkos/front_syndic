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
    required this.onValidate,
    required this.onRefuse,
    required this.onDelete,
  });

  final TimingEstimate timingEstimate;
  final bool isValidate;
  final Function(String?) onValidate;
  final Function(String?) onRefuse;
  final Function(String?) onDelete;

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
                  '${AppText.workEnd}: ${AppText.le} ${formatStringToApiDate(timingEstimate.dateEnd, 'dd/MM/yyyy') ?? ''}',
                  style: Theme.of(context).textTheme.displaySmall
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if(isValidate)
                    GestureDetector(
                      onTap: ()=>{
                        onRefuse(timingEstimate.uuid)
                      },
                      child: SvgPicture.asset(
                        'assets/close.svg',
                        colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
                        width: 20.0,
                        height: 20.0,
                      ),
                    ),
                  if(!isValidate)
                    IconButton(
                      onPressed: ()=>{
                        onValidate(timingEstimate.uuid)
                      },
                      icon: Icon(Icons.check),
                    ),
                  IconButton(
                    onPressed: ()=>{
                      onDelete(timingEstimate.uuid)
                    },
                    icon: Icon(Icons.delete),
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
