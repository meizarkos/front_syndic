import 'package:flutter/material.dart';

import '../../../api_handler/conversation/fetch_conversation.dart';
import '../../../text/fr.dart';
import 'first_conv.dart';

class FirstConvCouncil extends StatelessWidget {
  const FirstConvCouncil({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FirstConv(
      title: AppText.titleCouncilMessage,
      future: fetchFirstConvCouncil(),
      routeToDetailConv: '/council/see_conv',
    );
  }
}

class FirstConvArtisan extends StatelessWidget {
  const FirstConvArtisan({super.key});

  @override
  Widget build(BuildContext context) {
    return FirstConv(
      title: AppText.titleCouncilMessage,
      future: fetchFirstConvArtisan(),
      routeToDetailConv: '/artisan/see_conv',
    );
  }
}

