import 'package:flutter/material.dart';
import 'package:front_syndic/models/artisan/artisan.dart';
import 'package:front_syndic/views/timing/timing_detail/timing_detail.dart';

import '../../../api_handler/timing/get_timing_detail.dart';
import '../../../models/council/council.dart';
import '../../../models/union/union.dart';
import '../../../text/fr.dart';
import '../../../utils/string_handler/handle_string.dart';

class TimingDetailCouncil extends StatelessWidget {
  const TimingDetailCouncil({
    super.key,
    required this.timingUuid,
  });

  final String? timingUuid;

  @override
  Widget build(BuildContext context) {
    return TimingDetail(
      future: fetchTimingDetailCouncil(timingUuid),
      getYou: (dynamic){
        final council = dynamic.council as Council?;
        return "${AppText.phoneContact} ${council?.phone ?? AppText.noPhone}";
      },
      getClient: (dynamic) {
        final artisan = dynamic.artisan as Artisan?;
        return "${AppText.contact} ${artisan?.companyName ?? ''} ${toLowerFirst(AppText.to)} ${artisan?.phone ?? AppText.noPhone} ${AppText.contactUs}";
      },
      getUnion: (dynamic) {
        final union = dynamic.union as UnionApi?;
        return "${AppText.contactUnion} ${union?.phone ?? AppText.noPhone}";
      },
    );
  }
}
