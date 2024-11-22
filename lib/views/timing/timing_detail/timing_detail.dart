import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/widget/text_style/text_style_main_color.dart';

import '../../../models/timing/timing.dart';
import '../../../text/fr.dart';
import '../../../utils/date_to_string/date.dart';
import '../../../utils/string_handler/handle_string.dart';
import '../../../widget/button/elevated_button_opacity.dart';
import '../../../widget/button/row_of_nav_button.dart';
import '../../../widget/decoration/decoration_round_main_color.dart';
import '../../../widget/header/app_bar_back_button.dart';

class TimingDetail extends StatefulWidget {
  const TimingDetail({
    super.key,
    required this.routToConv,
    required this.routeToEstimateDetail,
    required this.routeToRefuse,
    required this.future,
    required this.getYou,
    required this.getClient,
    this.getUnion,
  });

  final Function(String?) routToConv;
  final Function(String?) routeToEstimateDetail;
  final Function(String?) routeToRefuse;
  final Future<Timing?> future;
  final Function(dynamic) getYou;
  final Function(dynamic) getClient;
  final Function(dynamic)? getUnion;

  @override
  State<TimingDetail> createState() => _TimingDetailState();
}

class _TimingDetailState extends State<TimingDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBackButton(context, title: AppText.timing),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: widget.future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError || snapshot.data == null) {
              return const Center(child: Text(AppText.apiErrorText));
            }
            final timing = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
              child: Column(
                children: [
                  const SizedBox(height: AppUIValue.spaceScreenToAny),
                  rowOfNavButton(
                    AppText.seeConv,
                    AppText.seeEstimateDetail,
                    context,
                    ()=>widget.routToConv(timing.uuid),
                    ()=>widget.routeToEstimateDetail(timing.uuid),
                  ),
                  const SizedBox(height: 35),
                  Center(
                    child: Text(
                      timing.workRequest?.title ?? AppText.noTitleForWork,
                      style: getTextStyleMainColor(20),
                    ),
                  ),
                  const SizedBox(height: 35),
                  Text(
                    '${AppText.one} ${toLowerFirst(AppText.timing)} ${AppText.create}',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(height: 35),
                  Container(
                    padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
                    decoration: decorationRoundMainColor(),
                    child: Column(
                      children: [
                        Text(
                          '${AppText.meetingEstimateText} ${formatStringToApiDate(timing.date, 'dd/MM')} ${AppText.at} ${timing.time?.substring(0, 5).replaceAll(':', 'h') ?? ''}.',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        Text(
                          "\n\n${AppText.interventionPlace}"
                          "\n\n${timing.workRequest?.adress?.street ?? ''}, ${timing.workRequest?.adress?.city ?? ''}, ${timing.workRequest?.adress?.postalCode ?? ''}"
                          "\n${timing.workRequest?.adress?.country?.toUpperCase() ?? ''} \n",
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 35),
                  Text(
                    'Contact',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    widget.getYou(timing),
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    widget.getClient(timing),
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  if (widget.getUnion != null) ...[
                    const SizedBox(height: 15),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width*0.8, // Define the width to constrain text justification
                        child: Text(
                          widget.getUnion!(timing),
                          style: Theme.of(context).textTheme.displaySmall,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 35),
                  elevatedButtonAndTextColor(
                    AppColors.actionButtonColor.withOpacity(AppUIValue.opacityActionButton),
                    AppText.refuse,
                    context,
                    ()=>widget.routeToRefuse(timing.uuid),
                    Colors.black,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
