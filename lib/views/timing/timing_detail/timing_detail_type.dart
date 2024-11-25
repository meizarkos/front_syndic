import 'package:flutter/material.dart';
import 'package:front_syndic/models/artisan/artisan.dart';
import 'package:front_syndic/models/to_screen/see_conv_arg.dart';
import 'package:front_syndic/views/timing/timing_detail/timing_detail.dart';

import '../../../api_handler/conversation/fetch_conversation.dart';
import '../../../api_handler/timing/refuse_timing_detail.dart';
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
      routeToConv: (String? uuid) {
        if(uuid == null) return;
        Navigator.pushReplacementNamed(context, '/council/see_conv',
          arguments: SeeConvArg(uuid: uuid, futureToFetchData: fetchSpecificConvCouncilFromTiming)
        );
      },
      routeToEstimateDetail:  (String? uuid) {
        /*if(uuid == null) return;
        Navigator.pushNamed(context, '/council/see_conv',
            arguments: SeeConvArg(uuid: uuid, futureToFetchData: fetchSpecificConvCouncilFromTiming)
        );*/
      },
      routeToRefuse: (String? uuid) async{
        if(uuid == null) return;
        await refuseTimingDetailCouncil(uuid);
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

class TimingDetailArtisan extends StatelessWidget {
  const TimingDetailArtisan({
    super.key,
    required this.timingUuid,
    required this.fetchTimingDetail,
  });

  final String? timingUuid;
  final Function(String?) fetchTimingDetail;

  @override
  Widget build(BuildContext context) {
    return TimingDetail(
      routeToConv: (String? uuid) {
        if(uuid == null) return;
        Navigator.pushReplacementNamed(context, '/artisan/see_conv',
            arguments: SeeConvArg(uuid: uuid, futureToFetchData: fetchSpecificConvArtisanFromTiming)
        );
      },
      routeToEstimateDetail:  (String? uuid) {
        /*if(uuid == null) return;
        Navigator.pushNamed(context, '/artisan/see_conv',
        arguments: SeeConvArg(uuid: uuid, futureToFetchData: fetchSpecificConvArtisanFromTiming)
        );*/
      },
      routeToRefuse: (String? uuid)async{
        await refuseTimingDetailArtisan(uuid);
        if(uuid == null) return;
        Navigator.pushReplacementNamed(context, '/artisan/see_conv',
            arguments: SeeConvArg(uuid: uuid, futureToFetchData: fetchSpecificConvArtisanFromTiming)
        );
      },
      future: fetchTimingDetail(timingUuid),
      getYou: (dynamic){
        final artisan = dynamic.artisan as Artisan?;
        return "${AppText.phoneContact} ${artisan?.phone ?? AppText.noPhone}";
      },
      getClient: (dynamic) {
        final  council = dynamic.council as Council?;
        return "${AppText.contact} ${toUpperFirst(council?.lastName ?? '')} ${toLowerFirst(AppText.to)} ${council?.phone ?? AppText.noPhone} ${AppText.contactUs}";
      },
    );
  }
}
