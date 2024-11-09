import 'package:flutter/material.dart';

import '../../../widget/header/app_bar_back_button.dart';

class PostMeetingWorkRequest extends StatefulWidget {
  const PostMeetingWorkRequest({
    super.key,
    required this.uuid,
  });

  final String uuid;

  @override
  State<PostMeetingWorkRequest> createState() => _PostMeetingWorkRequestState();
}

class _PostMeetingWorkRequestState extends State<PostMeetingWorkRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBackButton(context),
    );
  }
}
