import 'package:flutter/material.dart';
import 'package:front_syndic/api_handler/conversation/fetch_conversation.dart';
import 'package:front_syndic/api_handler/work_request/fetch_work_request_detail.dart';
import 'package:front_syndic/models/to_screen/see_conv_arg.dart';
import 'package:front_syndic/views/conversation/list_of_conv/all_conv.dart';
import '../../../api_handler/conversation/post_conv.dart';
import '../../../api_handler/estimate/get_estimate_detail.dart';
import '../../../api_handler/work_request/fetch_uuid_work_request/get_work_request_id_from_conv.dart';
import '../../../models/to_screen/artisan_detail_work_request.dart';

class SideConv{
  static const artisan = 'artisan';
  static const other = 'other';
  static const union = 'union';
}

class AllConvArtisan extends StatelessWidget {
  const AllConvArtisan({
    super.key,
    required this.id,
  });
  final String id;

  @override
  Widget build(BuildContext context) {
    return SeeConv(
      uuid: id,
      futureForGetConv: fetchSpecificConvArtisan(id),
      futureForPostConv: postConvArtisan,
      routeToBack: () {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/artisan/conversation');
      },
      goToRequest: (String? id) {
        Navigator.pushNamed(context,'/work_requests/artisan/detail',
            arguments: ArtisanWorkRequestDetailArg(
              futureToFetchData: fetchWorkRequestDetailArtisanFromConv,
              workRequestUuid: id,
              showContact: false,
            )
        );
      },
      goToMeeting: (String? id) {
        if(id == null) return;
        Navigator.pushNamed(context,'/timing/artisan/detail',
            arguments: id
        );
      },
      goToEstimate: (String? id) {
        if(id == null) return;
        Navigator.pushNamed(context,'/estimate/artisan/detail',
            arguments: id
        );
      },
      goToTimingEstimate: (String? id) {},
      sideText: SideConv.artisan,
    );
  }
}

class AllConvUnion extends StatelessWidget {
  const AllConvUnion({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return SeeConv(
      uuid: id,
      futureForGetConv: fetchSpecificConvUnion(id),
      futureForPostConv: postConvUnion,
      routeToBack: () {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/union/conversation');
      },
      goToRequest: (String? id) async{
        if(id == null) return;
        await fetchUuidWorkRequestUnion(id).then((uuid){
          if(uuid == null) return;
          Navigator.pushNamed(context,'/union/modify_demand/from_conv',
            arguments: uuid,
          );
        });
      },
      goToMeeting: (String? id) {
        if(id == null) return;
        Navigator.pushNamed(context,'union/detail_timing',
            arguments: id
        );
      },
      goToEstimate: (String? id) {
        if(id == null) return;
        Navigator.pushNamed(context,'/estimate/union/detail',
            arguments: id
        );
      },
      goToTimingEstimate: (String? id) {},
      sideText: SideConv.union,
    );
  }
}

class AllConvCouncil extends StatelessWidget {
  const AllConvCouncil({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return SeeConv(
      uuid: id,
      futureForGetConv: fetchSpecificConvCouncil(id),
      futureForPostConv: postConvCouncil,
      routeToBack: () {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/council/conversation');
      },
      goToRequest: (String? id) async{
        if(id == null) return;
        await fetchUuidWorkRequestCouncil(id).then((uuid){
          if(uuid == null) return;
          Navigator.pushNamed(context,'/council/modify_demand/from_conv',
            arguments: uuid,
          );
        });
      },
      goToMeeting: (String? id) {
        if(id == null) return;
        Navigator.pushNamed(context,'/council/timing_detail',
            arguments: id
        );
      },
      goToEstimate: (String? id) {
        if(id == null) return;
        Navigator.pushNamed(context,'/estimate/council/detail',
            arguments: id
        );
      },
      goToTimingEstimate: (String? id) {},
      sideText: SideConv.other,
    );
  }
}



