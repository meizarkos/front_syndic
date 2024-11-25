import 'package:flutter/material.dart';
import 'package:front_syndic/api_handler/timing/get_timing_detail.dart';
import 'package:front_syndic/api_handler/work_request/fetch_work_request_detail.dart';
import 'package:front_syndic/models/to_screen/see_conv_arg.dart';
import 'package:front_syndic/views/conversation/list_of_conv/all_conv.dart';
import '../../../api_handler/conversation/post_conv.dart';
import '../../../models/to_screen/artisan_detail_work_request.dart';
import '../../../models/to_screen/council_work_request_detail.dart';

class SideConv{
  static const artisan = 'artisan';
  static const other = 'other';
  static const union = 'union';
}

class AllConvArtisanForWorkRequest extends StatelessWidget {
  const AllConvArtisanForWorkRequest({
    super.key,
    required this.future,
    required this.id,
  });

  final Function(String) future;
  final String id;

  @override
  Widget build(BuildContext context) {
    return SeeConv(
      uuid: id,
      futureForGetConv: future(id),
      futureForPostConv: postFirstConvArtisanWorkRequest,
      route: '/work_requests/artisan/post_meeting',
      sideText: SideConv.artisan,
      goToRequest: (String? id) {
        Navigator.pushNamed(context,'/work_requests/artisan/detail',
            arguments: ArtisanWorkRequestDetailArg(
              futureToFetchData: fetchWorkRequestDetailArtisan,
              workRequestUuid: id,
              showContact: true,
            )
          );
        },
      goToMeeting: (String? no){},
    );
  }
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
            arguments: SeeConvArg(
              uuid: id,
              futureToFetchData: fetchTimingDetailArtisanFromConv,
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
      futureForGetConv: future(id),
      futureForPostConv: postConvCouncil,
      route: '/council/post_meeting',
      sideText: SideConv.other,
      goToMeeting: (String? id) {
        if(id == null) return;
        Navigator.pushNamed(context,'/council/timing_detail',
            arguments: SeeConvArg(
              uuid: id,
              futureToFetchData: fetchTimingDetailCouncilFromConversation,
            )
        );
      },
      goToRequest: (String? id) {
        if(id == null) return;
        Navigator.pushNamed(context,'/work_requests/detail',
            arguments: CouncilWorkRequestDetail(
              uuid: id,
              futureToFetchData: fetchWorkRequestDetailCouncilFromConversation,
              onGoBack: ()=>{ Navigator.pop(context)},
            )
        );
      },
    );
  }
}



