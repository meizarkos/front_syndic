import 'package:flutter/material.dart';
import 'package:front_syndic/views/conversation/conversation_in_progress/conversation_in_progress.dart';
import 'package:front_syndic/widget/bottom/nav_bar_artisan.dart';
import 'package:front_syndic/widget/bottom/nav_bar_council.dart';

import '../../../api_handler/conversation/fetch_conversation.dart';
import '../../../widget/bottom/nav_bar_union.dart';
import '../../../widget/bottom/nav_bar_user.dart';

class ConversationInProgressArtisan extends StatelessWidget {
  const ConversationInProgressArtisan({super.key});

  @override
  Widget build(BuildContext context) {
    return ConversationInProgress(
        goToConvDetail: (uuid) => {
          Navigator.pushNamed(
            context,
            '/artisan/see_conv',
            arguments: uuid,
          )
        },
        fetchConversationInProgress: fetchFirstConvArtisan(),
        bottomNavigationBar: bottomNavigationBarArtisan(context, 1)
    );
  }
}

class ConversationInProgressUnion extends StatelessWidget {
  const ConversationInProgressUnion({super.key});

  @override
  Widget build(BuildContext context) {
    return ConversationInProgress(
        goToConvDetail: (uuid) => {
          Navigator.pushNamed(
            context,
            'union/specific_conv',
            arguments: uuid,
          )
        },
        fetchConversationInProgress: fetchFirstConvUnion(),
        bottomNavigationBar: bottomNavigationBarUnion(context, 2)
    );
  }
}

class ConversationInProgressCouncil extends StatelessWidget {
  const ConversationInProgressCouncil({super.key});

  @override
  Widget build(BuildContext context) {
    return ConversationInProgress(
        goToConvDetail: (uuid) => {
          Navigator.pushNamed(
            context,
            '/council/see_conv',
            arguments: uuid,
          )
        },
        fetchConversationInProgress: fetchFirstConvCouncil(),
        bottomNavigationBar: bottomNavigationBarCouncil(context, 1)
    );
  }
}

class ConversationInProgressUser extends StatelessWidget {
  const ConversationInProgressUser({super.key});

  @override
  Widget build(BuildContext context) {
    return ConversationInProgress(
        goToConvDetail: (uuid) => {
          Navigator.pushNamed(
            context,
            '/user/see_conv',
            arguments: uuid,
          )
        },
        fetchConversationInProgress: fetchFirstConvUser(),
        bottomNavigationBar: bottomNavigationBarUser(context, 1)
    );
  }
}


