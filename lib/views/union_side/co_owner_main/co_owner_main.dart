import 'package:flutter/material.dart';
import 'package:front_syndic/api_handler/co_owner/get_main_data_co_owner.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/co_owner/co_owner.dart';
import 'package:front_syndic/models/estimate/estimate.dart';
import 'package:front_syndic/views/union_side/co_owner_main/row_of_text_and_icon.dart';
import 'package:front_syndic/widget/button/elevated_button_opacity.dart';

import '../../../color.dart';
import '../../../models/timing/timing.dart';
import '../../../models/timing/timing_estimate.dart';
import '../../../models/work_request/work_request.dart';
import '../../../text/fr.dart';
import '../../../utils/string_handler/handle_string.dart';
import '../../../widget/decoration/decoration_round_main_color.dart';
import '../../../widget/text_style/text_style_main_color.dart';
import 'column_of_text_button.dart';

const spaceInsideColumn = 25.0;

class CoOwnerMain extends StatelessWidget {
  const CoOwnerMain({
    super.key,
    required this.uuid,
  });

  final String uuid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchCoOwnerMainData(uuid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || snapshot.data == null) {
            return const Center(child: Text(AppText.apiErrorText));
          } else if (snapshot.data!.isEmpty) {
            return const Center(child: Text(AppText.apiNoResult));
          } else {
            final coOwner = snapshot.data?["co_owner"] as CoOwner?;
            final workRequest = snapshot.data?["work_request"] as WorkRequest?;
            final estimate = snapshot.data?["estimate"] as Estimate?;
            final timingEstimate = snapshot.data?["timing_estimate"] as TimingEstimate?;
            final timing = snapshot.data?["timing"] as Timing?;
            return Column(
              children: [
                const SizedBox(height: 40),
                Center(
                  child: Card(
                    elevation: AppUIValue.elevation,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
                      decoration: decorationRoundMainColor(),
                      child: Column(
                        children: [
                          Text(
                            trimText(stringNullOrDefaultValue(coOwner?.name, AppText.noStringNameForCowner),11),
                            style: getTextStyleMainColor(25.0),
                            maxLines: 1,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: spaceInsideColumn),
                          rowOfTextAndIcon('assets/co_owner.svg',coOwner?.adress?.city, AppText.noStringNameForCownerSubtitle, context),
                          const SizedBox(height: spaceInsideColumn),
                          rowOfTextAndIcon('assets/location.svg',coOwner?.adress?.street, AppText.noStringNameForCownerSubtitle, context),
                          const SizedBox(height: spaceInsideColumn),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: elevatedButtonOpacity(AppColors.mainTextColor.withOpacity(AppUIValue.opacityActionButton), AppText.buttonCreateARequest, context, ()=>goToCreateWorkRequest(context)),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: elevatedButtonOpacity(AppColors.mainTextColor.withOpacity(AppUIValue.opacityActionButton), AppText.buttonSeeInvoice, context, ()=>goToInvoice(context)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Center(
                  child: columnOfTextButton(AppText.titleMeeting,AppText.titleNextMeeting,stringNullOrDefaultValue(timing?.time, AppText.noTimingFound),AppText.seeEstimate, ()=>goToAllMeetingForEstimate(context), context),
                )
              ],
            );
          }
        },
      ),
    );
  }
  void goToCreateWorkRequest(BuildContext context) {
    Navigator.pushNamed(context, '/co_owner_work_request');
  }
  void goToInvoice(BuildContext context) {
    Navigator.pushNamed(context, '/invoice');
  }

  void goToAllMeetingForEstimate(BuildContext context) {
    Navigator.pushNamed(context, '/all_meeting_estimate');
  }
}