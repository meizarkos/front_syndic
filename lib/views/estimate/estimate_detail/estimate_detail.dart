import 'package:flutter/material.dart';
import 'package:front_syndic/models/to_screen/see_conv_arg.dart';

import '../../../api_handler/conversation/fetch_conversation.dart';
import '../../../core_value.dart';
import '../../../models/estimate/estimate.dart';
import '../../../text/fr.dart';
import '../../../widget/button/row_of_nav_button.dart';
import '../../../widget/decoration/decoration_round_main_color.dart';
import '../../../widget/handle_status/alert_to_display.dart';
import '../../../widget/handle_status/text_to_display_based_on_status.dart';
import '../../../widget/header/app_bar_back_button.dart';
import '../../../widget/text_style/text_style_main_color.dart';

class EstimateDetail extends StatefulWidget {
  const EstimateDetail({
    super.key,
    required this.fetchData,
    required this.uuid,
  });

  final Function(String?) fetchData;
  final String? uuid;

  @override
  State<EstimateDetail> createState() => _EstimateDetailState();
}

class _EstimateDetailState extends State<EstimateDetail> {

  late Future<Estimate?> _futureEstimate;

  Estimate estimateFromRequest = Estimate();

  @override
  void initState() {
    super.initState();
    _futureEstimate = widget.fetchData(widget.uuid); // Initialize the Future once
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBackButton(context, title: AppText.estimateDetailTitle),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: _futureEstimate,
            builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError || snapshot.data == null) {
                return const Center(child: Text(AppText.apiErrorText));
                }
                final estimate = snapshot.data!;
                estimateFromRequest = estimate;
                return Padding(
                  padding: EdgeInsets.all(AppUIValue.spaceScreenToAny),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: AppUIValue.spaceScreenToAny),
                      rowOfNavButton(
                        AppText.seeConv,
                        AppText.timingEstimate,
                        context,
                            (){
                              if(estimateFromRequest.uuid == null) return;
                              Navigator.pushNamed(context, '/council/see_conv',
                                  arguments: SeeConvArg(uuid: estimateFromRequest.uuid!, futureToFetchData: fetchSpecificConvCouncilFromEstimate));
                            },
                            (){
                              handleStatus(estimateFromRequest.status, estimateFromRequest.statusGoal, context,
                                      () {}
                              );
                            },
                      ),
                      const SizedBox(height: AppUIValue.spaceScreenToAny * 2),
                      Center(
                        child: Text(
                          estimate.workRequest?.title ?? AppText.noTitleForWork,
                          style: getTextStyleMainColor(AppUIValue.sizeFontTitle),
                        ),
                      ),
                      const SizedBox(height: AppUIValue.spaceScreenToAny),
                      textEstimateStatus(estimateFromRequest.status, estimateFromRequest.statusGoal, context),
                      const SizedBox(height: AppUIValue.spaceScreenToAny * 2),
                      Text(
                        estimate.price == null ? AppText.noPriceEstimate : '${AppText.createEstimatePrice}: ${estimate.price} ${AppText.euro}',
                        style : Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(height: AppUIValue.spaceScreenToAny*2),
                      Text(
                        AppText.description,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(height: 2),
                      Container(
                        padding: EdgeInsets.all(AppUIValue.spaceScreenToAny),
                        width: double.infinity,
                        decoration: decorationRoundMainColor(),
                        child: Text(
                          estimateFromRequest.description ?? AppText.noDescriptionEstimate,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                      const SizedBox(height: AppUIValue.spaceScreenToAny * 2),
                      Text(
                        AppText.commentary,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(height: 2),
                      Container(
                        padding: EdgeInsets.all(AppUIValue.spaceScreenToAny),
                        width: double.infinity,
                        decoration: decorationRoundMainColor(),
                        child: Text(
                          estimateFromRequest.commentary ?? AppText.noCommentary,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      )
                    ],
                  ),
                );
            }
        ),
      ),
    );
  }
}
