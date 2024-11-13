import 'package:flutter/material.dart';
import 'package:front_syndic/views/conversation/list_of_conv/post_meeting.dart';

import '../../../api_handler/timing/post_meeting_artisan.dart';

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
      routeAllConv: '/work_requests/artisan/first_conv',
      postMeeting: postTimingFromWorkRequestArtisan,
    );
  }
}
