import 'package:flutter/material.dart';
import 'package:front_syndic/models/to_screen/see_conv_arg.dart';
import 'package:front_syndic/views/conversation/list_of_conv/post_meeting.dart';

import '../../../api_handler/conversation/fetch_conversation.dart';
import '../../../api_handler/timing/post_timing.dart';

class PostMeetingArtisanFromWorkRequest extends StatelessWidget {
  const PostMeetingArtisanFromWorkRequest({
    super.key,
    required this.uuid,
  });

  final String uuid;

  @override
  Widget build(BuildContext context) {
    return PostMeeting(
      uuid: uuid,
      routeAllConv: (String uuid){
        Navigator.pushNamed(context,  '/work_requests/artisan/first_conv',
            arguments: SeeConvArg(uuid: uuid, futureToFetchData: fetchConversationFromWorkRequest)
        );
      },
      postMeeting: postTimingFromWorkRequestArtisan,
    );
  }
}

class PostMeetingArtisan extends StatelessWidget {
  const PostMeetingArtisan({
    super.key,
    required this.uuid,
  });

  final String uuid;

  @override
  Widget build(BuildContext context) {
    return PostMeeting(
      uuid: uuid,
      routeAllConv: (String uuid){
        Navigator.pushNamed(context,  '/artisan/see_conv',
            arguments: SeeConvArg(uuid: uuid, futureToFetchData: fetchSpecificConvArtisan)
        );
      },
      postMeeting: postTimingFromConvArtisan,
    );
  }
}

class PostMeetingCouncil extends StatelessWidget {
  const PostMeetingCouncil({
    super.key,
    required this.uuid,
  });

  final String uuid;

  @override
  Widget build(BuildContext context) {
    return PostMeeting(
      uuid: uuid,
      routeAllConv: (String uuid){
        Navigator.pushNamed(context, '/council/see_conv',
            arguments: SeeConvArg(uuid: uuid, futureToFetchData: fetchSpecificConvCouncil)
        );
      },
      postMeeting: postTimingFromConvCouncil,
    );
  }
}


class PostMeetingUnion extends StatelessWidget {
  const PostMeetingUnion({
    super.key,
    required this.uuid,
  });

  final String uuid;

  @override
  Widget build(BuildContext context) {
    return PostMeeting(
      uuid: uuid,
      routeAllConv: (String uuid){
        Navigator.pushNamed(context, 'union/specific_conv',
            arguments: SeeConvArg(uuid: uuid, futureToFetchData: fetchSpecificConvUnion)
        );
      },
      postMeeting: postTimingFromConvUnion,
    );
  }
}
