import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:front_syndic/api_handler/co_owner/get_main_data_co_owner.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/co_owner/co_owner.dart';
import 'package:front_syndic/models/estimate/estimate.dart';

import '../../models/timing/timing.dart';
import '../../models/timing/timing_estimate.dart';
import '../../models/work_request/work_request.dart';
import '../../text/fr.dart';
import '../../utils/string_handler/handle_string.dart';
import '../../widget/decoration/decoration_round_main_color.dart';
import '../../widget/text_style/text_style_main_color.dart';

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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SvgPicture.asset(
                                'assets/co_owner.svg',
                                width: 40.0,
                                height: 40.0,
                              ),
                              const SizedBox(width: 20),
                              Text(
                                trimText(stringNullOrDefaultValue(coOwner?.adress?.city, AppText.noStringNameForCownerSubtitle),20),
                                style: Theme.of(context).textTheme.labelMedium,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          const SizedBox(height: spaceInsideColumn),
                          Text(
                            trimText(stringNullOrDefaultValue(coOwner?.adress?.street, AppText.noStringNameForCownerSubtitle),20),
                            style: Theme.of(context).textTheme.labelMedium,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}