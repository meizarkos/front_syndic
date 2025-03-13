import 'package:flutter/material.dart';
import 'package:front_syndic/views/conversation/conversation_in_progress/conversation_in_progress.dart';
import 'package:front_syndic/widget/bottom/nav_bar_artisan.dart';
import 'package:front_syndic/widget/bottom/nav_bar_council.dart';

import '../../../api_handler/conversation/fetch_conversation.dart';
import '../../../models/to_screen/see_conv_arg.dart';
import '../../../widget/bottom/nav_bar_union.dart';

class ConversationInProgressUnion extends StatelessWidget {
  const ConversationInProgressUnion({super.key});

  @override
  Widget build(BuildContext context) {
    return ConversationInProgress(
        goToConvDetail: (uuid) => {
          Navigator.pushNamed(
            context,
            'union/specific_conv',
            arguments: SeeConvArg(
              uuid: uuid,
              futureToFetchData: fetchSpecificConvUnion,
            ),
          )
        },
        fetchConversationInProgress: fetchFirstConvUnion(),
        bottomNavigationBar: bottomNavigationBarUnion(context, 2)
    );
  }
}

class ConversationInProgressArtisan extends StatelessWidget {
  const ConversationInProgressArtisan({super.key});

  @override
  Widget build(BuildContext context) {
    return ConversationInProgress(
        goToConvDetail: (uuid) => {
          Navigator.pushNamed(
            context,
            '/artisan/see_conv',
            arguments: SeeConvArg(
              uuid: uuid,
              futureToFetchData: fetchSpecificConvArtisan,
            ),
          )
        },
        fetchConversationInProgress: fetchFirstConvArtisan(),
        bottomNavigationBar: bottomNavigationBarArtisan(context, 1)
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
            arguments: SeeConvArg(
              uuid: uuid,
              futureToFetchData: fetchSpecificConvCouncil,
            ),
          )
        },
        fetchConversationInProgress: fetchFirstConvCouncil(),
        bottomNavigationBar: bottomNavigationBarCouncil(context, 1)
    );
  }
}


