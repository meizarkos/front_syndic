import 'package:flutter/material.dart';
import 'package:front_syndic/views/conversation/list_of_conv/all_conv.dart';
import '../../../api_handler/conversation/fetch_conversation.dart';
import '../../../api_handler/conversation/post_conv.dart';

class SideConv{
  static const artisan = 'artisan';
  static const other = 'other';
}

class AllConvArtisanForWorkRequest extends StatelessWidget {
  const AllConvArtisanForWorkRequest({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return SeeConv(
      uuid: id,
      futureForGetConv: fetchConversationFromWorkRequest(id),
      futureForPostConv: postFirstConvArtisanWorkRequest,
      route: '/work_requests/artisan/post_meeting',
      sideText: SideConv.artisan,
    );
  }
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
      route: '/artisan/post_meeting',
      sideText: SideConv.artisan,
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
      route: '/council/post_meeting',
      sideText: SideConv.other,
    );
  }
}


