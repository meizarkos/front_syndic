import 'package:flutter/material.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/utils/date_to_string/date.dart';
import 'package:front_syndic/utils/string_handler/handle_string.dart';

import '../../../../models/timing/timing.dart';
import '../../../../text/fr.dart';
import '../../../../widget/decoration/decoration_round_main_color.dart';
import '../../../../widget/text_style/text_style_main_color.dart';

class WorkRequestCell extends StatelessWidget {
  const WorkRequestCell({
    super.key,
    required this.title,
    required this.subtitle,
    required this.timings,
  });

  final String? title;
  final String? subtitle;
  final List<Timing>? timings;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
      child: Card(
        elevation: AppUIValue.elevation,
        child: Container(
          decoration: decorationRoundMainColor(),
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Text(
                trimText(stringNullOrDefaultValue(title, AppText.noTitleForWork), 22),
                style: getTextStyleMainColor(22.0),
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 35),
              Text(
                "${AppText.preTextWorkRequest} ${stringNullOrDefaultValue(getTiming(), AppText.noTimingFound)}",
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
              const SizedBox(height: 50),
              Text(
                trimText(stringNullOrDefaultValue(subtitle, AppText.noDateForWork), 100),
                style: Theme.of(context).textTheme.displaySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? getTiming() {
    if (timings == null || timings!.isEmpty) {
      return AppText.noTimingFound;
    }
    final timingDate = timings![0].date;
    final timingHour = timings![0].time;
    if(timingDate == null || timingHour == null){
      return AppText.noTimingFound;
    }
    return "${formatStringToApiDate(timingDate, 'dd/MM/yyyy')} ${AppText.at} ${formatTimeString(timingHour)}";
  }
}
