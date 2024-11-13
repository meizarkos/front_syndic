import 'package:flutter/material.dart';

import '../../../api_handler/conversation/fetch_first_conversation.dart';
import '../../../text/fr.dart';
import 'first_conv.dart';

class FirstConvCouncil extends StatelessWidget {
  const FirstConvCouncil({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return FirstConv(
      title: AppText.titleCouncilMessage,
      future: fetchFirstConvCouncil(id),
    );
  }
}
