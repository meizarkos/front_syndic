import 'package:flutter/material.dart';
import 'package:front_syndic/views/conversation/list_of_conv/post_meeting.dart';

import '../../../api_handler/timing/post_artisan.dart';

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
      routeAllConv: '/work_requests/artisan/first_conv',
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
      routeAllConv: '/artisan/see_conv',
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
      routeAllConv: '/council/see_conv',
      postMeeting: postTimingFromConvCouncil,
    );
  }
}
