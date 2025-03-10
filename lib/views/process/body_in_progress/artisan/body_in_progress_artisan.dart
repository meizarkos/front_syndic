import 'package:flutter/material.dart';
import 'package:front_syndic/api_handler/estimate/get_estimate.dart';
import 'package:front_syndic/views/process/body_in_progress/body_in_progress.dart';

import '../../../../api_handler/conversation/fetch_conversation.dart';
import '../../../../api_handler/estimate/get_estimate_detail.dart';
import '../../../../api_handler/timing/get_timing_detail.dart';
import '../../../../api_handler/timing/get_timings.dart';
import '../../../../models/to_screen/see_conv_arg.dart';
import '../function_access_param.dart';

class BodyInProgressArtisanConversation extends StatelessWidget {
  const BodyInProgressArtisanConversation({
    super.key,
    required this.searchValue,
  });

  final String? searchValue;

  @override
  Widget build(BuildContext context) {
    return BodyInProgress(
        future: fetchFirstConvArtisan(),
        goToDetail: (uuid) => {
          Navigator.pushNamed(
            context,
            '/artisan/see_conv',
            arguments: SeeConvArg(
              uuid: uuid,
              futureToFetchData: fetchSpecificConvArtisan,
            ),
          )
        },
        searchValue: searchValue,
        returnWorkRequestTitle: getTitleWorkRequest,
        returnDesc: getMessage,
        descSize: 60,
        descStyle: Theme.of(context).textTheme.displaySmall,
        returnThirdText: getDateOfMessage,
        thirdTextSize: 16
    );
  }
}

class BodyInProgressArtisanTiming extends StatelessWidget {
  const BodyInProgressArtisanTiming({
    super.key,
    required this.searchValue,
  });

  final String? searchValue;

  @override
  Widget build(BuildContext context) {
    return BodyInProgress(
      future: fetchTimingsArtisan(),
      goToDetail: (uuid) => {
        Navigator.pushNamed(
          context,
          '/timing/artisan/detail',
          arguments: SeeConvArg(
            uuid: uuid,
            futureToFetchData: fetchTimingDetailArtisan,
          ),
        )
      },
      searchValue: searchValue,
      returnWorkRequestTitle: getTitleAndAddPrefix,
      returnDesc: getDateMeeting,
      descSize: 50,
      descStyle: Theme.of(context).textTheme.displaySmall,
    );
  }
}

class BodyInProgressArtisanEstimate extends StatelessWidget {
  const BodyInProgressArtisanEstimate({
    super.key,
    required this.searchValue,
  });

  final String? searchValue;

  @override
  Widget build(BuildContext context) {
    return BodyInProgress(
      future: fetchAllEstimateArtisan(),
      goToDetail: (uuid) => {
        Navigator.pushNamed(
          context,
          '/estimate/artisan/detail',
          arguments: SeeConvArg(uuid: uuid, futureToFetchData: fetchEstimateDetailArtisan),
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

/*class BodyInProgressArtisanTimingEstimate extends StatelessWidget {
  const BodyInProgressArtisanTimingEstimate({
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
