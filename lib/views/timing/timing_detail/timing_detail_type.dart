import 'package:flutter/material.dart';
import 'package:front_syndic/views/timing/timing_detail/timing_detail.dart';

import '../../../api_handler/timing/get_timing_detail.dart';
import '../../../api_handler/timing/refuse_timing_detail.dart';
import '../../../models/timing/timing.dart';
import '../../../text/fr.dart';
import '../../../utils/string_handler/handle_string.dart';

class TimingDetailArtisan extends StatelessWidget {
  const TimingDetailArtisan({
    super.key,
    required this.convUuid,
  });

  final String? convUuid;

  @override
  Widget build(BuildContext context) {
    return TimingDetail(
      routeToRefuse: (String? uuid)async{
        if(uuid == null) return;
        await refuseTimingDetailArtisan(uuid);
        if(convUuid == null) return;
        Navigator.pop(context);
        Navigator.pushReplacementNamed(
          context,
          '/artisan/see_conv',
          arguments: convUuid!,
        );
      },
      routeToCreateMeeting: () {
        if(convUuid == null) return;
        Navigator.pushNamed(context, '/artisan/create_timing',
            arguments: convUuid
        );
      },
      future: fetchTimingDetailArtisanFromConversation(convUuid),
      textContact : (TimingAndCreator timing){
        if(timing.council != null){
          return "${AppText.contactCouncilActive} ${toUpperFirst(timing.council?.lastName ?? '')} ${toUpperFirst(timing.council?.firstName ?? '')} ${toLowerFirst(AppText.to)} ${timing.council?.phone ?? AppText.noPhone}.\n\n"
              "${timing.union != null ? "${AppText.contactUnionForArtisan} ${toUpperFirst(timing.union?.name ?? AppText.noNameUnion)} ${toLowerFirst(AppText.to)} ${timing.union?.phone ?? AppText.noPhone}." : ""}";

        }
        return "";
      },
    );
  }
}


class TimingDetailUnion extends StatelessWidget {
  const TimingDetailUnion({
    super.key,
    required this.convUuid,
  });

  final String? convUuid;

  @override
  Widget build(BuildContext context) {
    return TimingDetail(
      routeToRefuse: (String? uuid)async{
        await refuseTimingDetailUnion(uuid);
        if(uuid == null) return;
        Navigator.pushReplacementNamed(context, 'union/specific_conv',
            arguments: convUuid
        );
      },
      routeToCreateMeeting: () {
        if(convUuid == null) return;
        Navigator.pushNamed(context, '/union/create_timing',
            arguments: convUuid
        );
      },
      future: fetchTimingDetailUnionFromConversation(convUuid),
      textContact: (TimingAndCreator timing){
        final contactArtisan = "${AppText.contactez} ${toUpperFirst(timing.artisan?.companyName ?? '')} ${toLowerFirst(AppText.to)} ${timing.artisan?.phone ?? AppText.noPhone} ${AppText.contactUs}";
        return "$contactArtisan\n\n${AppText.contactCouncil} ${timing.council?.phone ?? AppText.noPhone}";
      },
    );
  }
}

class TimingDetailCouncil extends StatelessWidget {
  const TimingDetailCouncil({
    super.key,
    required this.convUuid,
  });

  final String? convUuid;


  @override
  Widget build(BuildContext context) {
    return TimingDetail(
      routeToRefuse: (String? uuid) async{
        if(uuid == null) return;
        await refuseTimingDetailCouncil(uuid);
        Navigator.pushReplacementNamed(context, '/council/see_conv',
            arguments: convUuid
        );
      },
      routeToCreateMeeting: () {
        if(convUuid == null) return;
        Navigator.pushNamed(context, '/council/create_timing',
            arguments: convUuid
        );
      },
      future: fetchTimingDetailCouncilFromConversation(convUuid),
      textContact: (TimingAndCreator timing){
        final contactArtisan = "${AppText.contactez} ${toUpperFirst(timing.artisan?.companyName ?? '')} ${toLowerFirst(AppText.to)} ${timing.artisan?.phone ?? AppText.noPhone} ${AppText.contactUs}";
        if(timing.union != null){
          return "$contactArtisan\n\n${AppText.contactUnion} ${timing.union?.phone ?? AppText.noPhone}.";
        }
        return contactArtisan;
      },
    );
  }
}