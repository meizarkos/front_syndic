import 'package:flutter/material.dart';
import 'package:front_syndic/api_handler/timing/get_timing_detail.dart';
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
    required this.future,
  });

  final Function(String) future;
  final String id;

  @override
  Widget build(BuildContext context) {
    return SeeConv(
      uuid: id,
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
            arguments: SeeConvArg(
              uuid: id,
              futureToFetchData: fetchEstimateDetailArtisanFromConversation,
            )
        );
      },
      futureForGetConv: future(id),
      futureForPostConv: postConvArtisan,
      route: '/artisan/post_meeting',
      sideText: SideConv.artisan,
    );
  }
}

class AllConvUnion extends StatelessWidget {
  const AllConvUnion({
    super.key,
    required this.id,
    required this.future,
  });

  final Function(String) future;
  final String id;

  @override
  Widget build(BuildContext context) {
    return SeeConv(
      uuid: id,
      routeToBack: () {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/union/conversation');
      },
      futureForGetConv: future(id),
      futureForPostConv: postConvUnion,
      route: 'union/post_meeting',
      sideText: SideConv.union,
      goToMeeting: (String? id) {
        if(id == null) return;
        Navigator.pushNamed(context,'union/detail_timing',
            arguments: id
        );
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
      goToEstimate: (String? id) {
        if(id == null) return;
        Navigator.pushNamed(context,'/estimate/union/detail',
            arguments: SeeConvArg(
              uuid: id,
              futureToFetchData: fetchEstimateDetailUnionFromConversation,
            )
        );
      },
    );
  }
}

class AllConvCouncil extends StatelessWidget {
  const AllConvCouncil({
    super.key,
    required this.id,
    required this.future,
  });

  final Function(String) future;
  final String id;

  @override
  Widget build(BuildContext context) {
    return SeeConv(
      uuid: id,
      routeToBack: () {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/council/conversation');
      },
      futureForGetConv: future(id),
      futureForPostConv: postConvCouncil,
      route: '/council/post_meeting',
      sideText: SideConv.other,
      goToMeeting: (String? id) {
        if(id == null) return;
        Navigator.pushNamed(context,'/council/timing_detail',
            arguments: id
        );
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
      goToEstimate: (String? id) {
        if(id == null) return;
        Navigator.pushNamed(context,'/estimate/council/detail',
            arguments: SeeConvArg(
              uuid: id,
              futureToFetchData: fetchEstimateDetailCouncilFromConversation,
            )
        );
      },
    );
  }
}



