import 'package:flutter/material.dart';
import 'package:front_syndic/models/artisan/artisan.dart';
import 'package:front_syndic/models/to_screen/see_conv_arg.dart';
import 'package:front_syndic/views/timing/timing_detail/timing_detail.dart';

import '../../../api_handler/conversation/fetch_conversation.dart';
import '../../../models/council/council.dart';
import '../../../models/union/union.dart';
import '../../../text/fr.dart';
import '../../../utils/string_handler/handle_string.dart';

class TimingDetailCouncil extends StatelessWidget {
  const TimingDetailCouncil({
    super.key,
    required this.timingUuid,
    required this.fetchTimingDetail,
  });

  final String? timingUuid;
  final Function(String?) fetchTimingDetail;

  @override
  Widget build(BuildContext context) {
    return TimingDetail(
      routToConv: (String? uuid) {
        if(uuid == null) return;
        Navigator.pushNamed(context, '/council/see_conv',
          arguments: SeeConvArg(uuid: uuid, futureToFetchData: fetchSpecificConvCouncilFromTiming)
        );
      },
      routeToEstimateDetail:  (String? uuid) {
        if(uuid == null) return;
        Navigator.pushNamed(context, '/council/see_conv',
            arguments: SeeConvArg(uuid: uuid, futureToFetchData: fetchSpecificConvCouncilFromTiming)
        );
      },
      routeToRefuse: (String? uuid) {
        if(uuid == null) return;
        Navigator.pushReplacementNamed(context, '/council/see_conv',
            arguments: SeeConvArg(uuid: uuid, futureToFetchData: fetchSpecificConvCouncilFromTiming)
        );
      },
      future: fetchTimingDetail(timingUuid),
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
