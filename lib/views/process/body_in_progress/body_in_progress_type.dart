import 'package:flutter/material.dart';
import 'package:front_syndic/views/process/body_in_progress/body_in_progress.dart';

import '../../../api_handler/conversation/fetch_conversation.dart';
import 'function_access_param.dart';

class BodyInProgressCouncilConversation extends StatelessWidget {
  const BodyInProgressCouncilConversation({
    super.key,
    required this.searchValue,
  });

  final String? searchValue;

  @override
  Widget build(BuildContext context) {
    return BodyInProgress(
        future: fetchFirstConvCouncil(),
        routeToDetail: '/council/see_conv',
        searchValue: searchValue,
        returnWorkRequestTitle: getTitleWorkRequest,
        returnDesc: getMessage,
        descSize: 50,
        returnThirdText: getDateOfMessage,
        thirdTextSize: 16
    );
  }
}
