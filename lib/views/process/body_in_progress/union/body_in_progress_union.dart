import 'package:flutter/material.dart';
import 'package:front_syndic/api_handler/estimate/get_estimate.dart';
import 'package:front_syndic/views/process/body_in_progress/body_in_progress.dart';

import '../../../../api_handler/conversation/fetch_conversation.dart';
import '../../../../api_handler/estimate/get_estimate_detail.dart';
import '../../../../api_handler/timing/get_timing_detail.dart';
import '../../../../api_handler/timing/get_timings.dart';
import '../../../../models/to_screen/see_conv_arg.dart';
import '../function_access_param.dart';

class BodyInProgressUnionConversation extends StatelessWidget {
  const BodyInProgressUnionConversation({
    super.key,
    required this.searchValue,
  });

  final String? searchValue;

  @override
  Widget build(BuildContext context) {
    return BodyInProgress(
        future: fetchFirstConvUnion(),
        goToDetail: (uuid) => {
          Navigator.pushNamed(
            context,
            'union/specific_conv',
            arguments: SeeConvArg(
              uuid: uuid,
              futureToFetchData: fetchSpecificConvUnion,
            ),
          )
        },
        searchValue: searchValue,
        returnWorkRequestTitle: getTitleWorkRequest,
        returnDesc: getMessage,
        descSize: 75,
        descStyle: Theme.of(context).textTheme.displaySmall,
        returnThirdText: getDateOfMessage,
        thirdTextSize: 16);
  }
}

class BodyInProgressUnionTiming extends StatelessWidget {
  const BodyInProgressUnionTiming({
    super.key,
    required this.searchValue,
  });

  final String? searchValue;

  @override
  Widget build(BuildContext context) {
    return BodyInProgress(
      future: fetchTimingsUnion(),
      goToDetail: (uuid) => {
        Navigator.pushNamed(
          context,
          'union/detail_timing',
          arguments: SeeConvArg(
            uuid: uuid,
            futureToFetchData: fetchTimingDetailCouncil,
          ),
        )
      },
      searchValue: searchValue,
      returnWorkRequestTitle: getTitleAndAddPrefix,
      returnDesc: getDateMeeting,
      descSize: 50,
      descStyle: Theme.of(context).textTheme.displayMedium,
    );
  }
}

class BodyInProgressUnionEstimate extends StatelessWidget {
  const BodyInProgressUnionEstimate({
    super.key,
    required this.searchValue,
  });

  final String? searchValue;

  @override
  Widget build(BuildContext context) {
    return BodyInProgress(
      future: fetchAllEstimateUnion(),
      goToDetail: (uuid) => {
        Navigator.pushNamed(
          context,
          '/estimate/union/detail',
          arguments: SeeConvArg(
            uuid: uuid,
            futureToFetchData: fetchEstimateDetailUnion,
          ),
        )
      },
      searchValue: searchValue,
      returnWorkRequestTitle: getTitleWorkRequest,
      returnDesc: getPriceEstimate,
      descSize: 10,
      descStyle: Theme.of(context).textTheme.displayMedium,
      returnThirdText: getEstimateDesc,
      thirdTextSize: 100,
    );
  }
}

/*class BodyInProgressCouncilTimingEstimate extends StatelessWidget {
  const BodyInProgressCouncilTimingEstimate({
    super.key,
    required this.searchValue,
  });

  final String? searchValue;

  @override
  Widget build(BuildContext context) {
    return BodyInProgress(
      future: fetchTimingEstimateCouncil(),
      goToDetail: (uuid) => {
        Navigator.pushNamed(
          context,
          '/council/see_conv',
          arguments: SeeConvArg(
            uuid: uuid,
            futureToFetchData: fetchTimingDetailCouncil,
          ),
        )
      },
      searchValue: searchValue,
      returnWorkRequestTitle: getTitleWorkRequest,
      returnDesc: getDateMeetingEstimate,
      descSize: 100,
      descStyle: Theme.of(context).textTheme.displayMedium,
    );
  }
}*/
