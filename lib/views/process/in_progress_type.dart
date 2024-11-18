import 'package:flutter/material.dart';
import 'package:front_syndic/views/process/in_progress_main.dart';
import 'package:front_syndic/views/process/top_screen_in_progress/top_screen_in_progress_type.dart';

import '../../text/fr.dart';
import 'body_in_progress/body_in_progress_type.dart';

class InProgressCouncilConversation extends StatefulWidget {
  const InProgressCouncilConversation({super.key});

  @override
  State<InProgressCouncilConversation> createState() => _InProgressCouncilConversationState();
}

class _InProgressCouncilConversationState extends State<InProgressCouncilConversation> {
  var searchValue = '';
  var category = AppText.conversation;

  @override
  Widget build(BuildContext context) {
    return InProgressMain(
      top : TopScreenInProgressCouncil(
        onChangedSearchValue: _searchValueChange,
        category: category,
      ),
      body : BodyInProgressCouncilConversation( //handle route
        searchValue: searchValue,
      ),
    );
  }

  void _searchValueChange(String value) {
    setState(() {
      searchValue = value;
    });
  }
}
