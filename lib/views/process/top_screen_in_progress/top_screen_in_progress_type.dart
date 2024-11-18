import 'package:flutter/material.dart';
import 'package:front_syndic/views/process/top_screen_in_progress/top_screen_in_progress.dart';

import '../../../text/fr.dart';

void pushToRouteCouncil(String value, BuildContext context) {
  if(value == AppText.conversation){

  }
  else if(value == AppText.timing){

  }
  else if(value == AppText.estimate){

  }
  else if(value == AppText.timingEstimate){

  }
}


class TopScreenInProgressCouncil extends StatefulWidget {
  const TopScreenInProgressCouncil({
    super.key,
    required this.onChangedSearchValue,
    required this.category,
  });

  final Function(String) onChangedSearchValue;
  final String category;

  @override
  State<TopScreenInProgressCouncil> createState() => _TopScreenInProgressCouncilState();
}

class _TopScreenInProgressCouncilState extends State<TopScreenInProgressCouncil> {
  @override
  Widget build(BuildContext context) {
    return TopScreenInProgress(
        onChangedSearchValue: widget.onChangedSearchValue,
        onCategoryChanged: pushToRouteCouncil,
        category: widget.category,
        listOfCategory: AppText.inProgressListCouncil,
    );
  }
}
