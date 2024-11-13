import 'package:flutter/material.dart';
import 'package:front_syndic/views/conversation/list_of_conv/all_conv.dart';

import '../../../api_handler/conversation/fetch_all_conv.dart';
import '../../../api_handler/conversation/post_first_conv.dart';

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
      futureForGetConv: fetchConversationFromWorkRequest(id),
      futureForPostConv: postFirstConvArtisan,
      route: '/work_requests/artisan/post_meeting',
    );
  }
}
