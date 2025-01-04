import 'package:flutter/material.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/co_owner/co_owner.dart';
import 'package:front_syndic/models/work_request/create_work_request.dart';
import 'package:front_syndic/utils/date_to_string/date.dart';
import 'package:front_syndic/views/co_owner/co_owner_detail/row_of_text_and_icon.dart';
import 'package:front_syndic/widget/button/elevated_button_opacity.dart';
import 'package:front_syndic/widget/header/app_bar_back_button.dart';

import '../../../color.dart';
import '../../../models/adress/adress.dart';
import '../../../models/timing/timing.dart';
import '../../../models/timing/timing_estimate.dart';
import '../../../models/work_request/work_request.dart';
import '../../../text/fr.dart';
import '../../../utils/string_handler/handle_string.dart';
import '../../../widget/decoration/decoration_round_main_color.dart';
import '../../../widget/text_style/text_style_main_color.dart';

const spaceInsideColumn = 25.0;

class CoOwnerDetail extends StatefulWidget {
  const CoOwnerDetail({
    super.key,
    required this.fetchData,
    required this.uuid,
  });

  final Future<Map<String, dynamic>> Function(String?) fetchData;
  final String? uuid;

  @override
  State<CoOwnerDetail> createState() => _CoOwnerDetailState();
}

class _CoOwnerDetailState extends State<CoOwnerDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBackButton(context, title: AppText.infoCoOwner),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: widget.fetchData(widget.uuid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError || snapshot.data == null) {
              return const Center(child: Text(AppText.apiErrorText));
            } else if (snapshot.data!.isEmpty) {
              return const Center(child: Text(AppText.apiNoResult));
            } else {
              final coOwner = snapshot.data?["co_owner"] as CoOwner?;
              final adress = coOwner?.adress;
              final council = coOwner?.council;
              /*final workRequest = snapshot.data?["work_request"] as WorkRequest?;
              final estimate = snapshot.data?["estimate"] as Estimate?;
              final timingEstimate = snapshot.data?["timing_estimate"] as TimingEstimate?;
              final timing = snapshot.data?["timing"] as Timing?;*/
              return Column(
                children: [
                  const SizedBox(height: 40),
                  Center(
                    child: Card(
                      elevation: AppUIValue.elevation,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        padding:
                            const EdgeInsets.all(AppUIValue.spaceScreenToAny),
                        decoration: decorationRoundMainColor(),
                        child: Column(
                          children: [
                            Text(
                              trimText(
                                  stringNullOrDefaultValue(coOwner?.name,
                                      AppText.noStringNameForCowner),
                                  11),
                              style: getTextStyleMainColor(25.0),
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: spaceInsideColumn),
                            Text(
                              '${adress?.country ?? ''}\n\n${adress?.city ?? ''}, ${adress?.street ?? ''}',
                              style: Theme.of(context).textTheme.displayMedium,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: spaceInsideColumn),
                            rowOfTextAndIcon(
                                'assets/co_owner.svg',
                                coOwner?.lotSize?.toString() ?? '',
                                context
                            ),
                            const SizedBox(height: spaceInsideColumn),
                            Text(
                              '${AppText.infoCouncil}:\n'
                                  '${council?.firstName ?? ''} ${council?.lastName ?? ''}\n\n'
                                  '${AppText.contact}: ${council?.phone ?? AppText.noPhone}',
                              style: Theme.of(context).textTheme.displaySmall,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: spaceInsideColumn),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: elevatedButtonOpacity(
                                  AppColors.mainTextColor.withOpacity(
                                      AppUIValue.opacityActionButton),
                                  AppText.buttonCreateARequest,
                                  context,
                                  ()=>goToCreateWorkRequest(context)
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: elevatedButtonOpacity(
                                  AppColors.mainTextColor.withOpacity(
                                      AppUIValue.opacityActionButton),
                                  AppText.buttonSeeInvoice,
                                  context,
                                  () => goTo(context,'/invoice')),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: elevatedButtonAndTextColor(
                        AppColors.actionButtonColor.withOpacity(AppUIValue.opacityActionButton),
                        AppText.modifyTheseData,
                        context,
                        (){
                          goTo(context,'/union/council_modify', arguments: widget.uuid);
                        },
                        Colors.black,
                    ),
                  ),
                  /*const SizedBox(height: 25),
                  Center(
                    child: columnOfTextButton(
                        AppText.titleNextWorkMeeting,
                        AppText.titleTimingEstimate,
                        stringNullOrDefaultValue(
                            fromStringToDateTimeString("${timingEstimate?.dateStart} ${timingEstimate?.timeStart}"), AppText.noTimingFound),
                        AppText.buttonTextWorkMeeting,
                            () => goTo(context,'/meetings'),
                        context),
                  ),
                  const SizedBox(height: 25),
                  Center(
                    child: columnOfTextButton(
                      AppText.titleNextWork,
                      trimText(stringNullOrDefaultValue(
                          workRequest?.title, AppText.noTitleForWork), 20),
                      AppText.preTextWorkRequest +
                          stringNullOrDefaultValue(listTiming(workRequest?.timings, AppText.noDateForWork), AppText.noDateForWork),
                      AppText.buttonTextWorkRequest,
                      () => goTo(context,'/co_owner/work_requests'),
                      context,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Center(
                    child: columnOfTextButton(
                      AppText.titleNexEstimate,
                      AppText.subtitleEstimate,
                      stringNullOrDefaultValue(listTimingEstimate(estimate?.timingsEstimate,AppText.noDateForWork), AppText.noDateForWork),
                      AppText.buttonTextEstimate,
                          () => goTo(context,'/first_conv_council'),
                      context,
                    ),
                  ),
                  const SizedBox(height: 25),*/
                ],
              );
            }
          },
        ),
      ),
    );
  }

  void goTo(BuildContext context, String path, {Object? arguments}) {
    Navigator.pushNamed(context, path, arguments: arguments);
  }

  String? listTiming(List<Timing>? timings, String defaultValue) {
    final res = handleEmptyList(timings, defaultValue );
    if(res != null){
      return res;
    }
    return fromStringToDateTimeString("${timings?[0].date} ${timings?[0].time}");
  }

  String? listTimingEstimate(List<TimingEstimate>? timingsEstimate, String defaultValue) {
    final res = handleEmptyList(timingsEstimate, defaultValue );
    if(res != null){
      return res;
    }
    return fromStringToDateTimeString("${timingsEstimate?[0].dateStart} ${timingsEstimate?[0].timeStart}");
  }

  void goToCreateWorkRequest(BuildContext context) {
        goTo(context,'union/work_requests/title_and_desc',
            arguments: CreateWorkRequest(
              [],
              WorkRequest(councilId: widget.uuid),
              null,
              Adress(),
            ),
        );
  }
}
