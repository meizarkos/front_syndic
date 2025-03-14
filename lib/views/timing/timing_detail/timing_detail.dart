import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/widget/text_style/text_style_main_color.dart';

import '../../../models/estimate/estimate.dart';
import '../../../models/timing/timing.dart';
import '../../../text/fr.dart';
import '../../../utils/date_to_string/date.dart';
import '../../../utils/string_handler/handle_string.dart';
import '../../../widget/button/elevated_button_opacity.dart';
import '../../../widget/cell_app_bar_in_progress/createButton.dart';
import '../../../widget/decoration/decoration_round_main_color.dart';

class TimingDetail extends StatefulWidget {
  const TimingDetail({
    super.key,
    required this.routeToConv,
    required this.routeToEstimateDetail,
    required this.routeToRefuse,
    required this.future,
    //required this.getClient,
    required this.textContact,
    //this.getUnion,
    this.isArtisan = false,
  });

  final Function(String?) routeToConv;
  final Function(String?) routeToEstimateDetail;
  final Function(String?) routeToRefuse;
  final Future<Timing?> future;

  //final Function(dynamic) getClient;
  //final Function(dynamic)? getUnion;
  final Function(Timing) textContact;
  final bool isArtisan;

  @override
  State<TimingDetail> createState() => _TimingDetailState();
}

class _TimingDetailState extends State<TimingDetail> {
  Timing timing = Timing();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    widget.future.then((value) {
      setState(() {
        isLoading = false;
      });
      if (value?.uuid != null) {
        setState(() {
          timing = value!;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if(isLoading == false && timing.uuid == null) { // create a meeting
      return Scaffold(
        body: Center(
          child: elevatedButtonAndTextColor(
            AppColors.actionButtonColor.withOpacity(AppUIValue.opacityActionButton),
            AppText.createAMeeting,
            context,
            () {
              final timing = Timing();
              timing.workRequestId = 'workRequestId';
              Navigator.pushNamed(
                context,
                '/artisan/create_meeting',
                arguments: timing,
              );
            },
            Colors.black,
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
              padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
              child: Row(
                children: [
                  createButton(
                    context,
                    AppText.seeConversation,
                    () => widget.routeToConv(timing.uuid),
                  ),
                  const SizedBox(width: 10),
                  createButton(
                    context,
                    AppText.seeEstimateDetail,
                    () => widget.routeToEstimateDetail(timing.uuid),
                  ),
                ],
              )),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
          child: Column(
            children: [
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              Center(
                child: Text(
                  timing.workRequest?.title ?? AppText.noTitleForWork,
                  style: getTextStyleMainColor(18),
                ),
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              Card(
                elevation: AppUIValue.elevation,
                child: Container(
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
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  // Define the width to constrain text justification
                  child: Text(
                    widget.textContact(timing),
                    style: Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                  height: 115,
                  child: inArtisanCase(timing),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget inArtisanCase(Timing timing) {
    if (widget.isArtisan == false) {
      return elevatedButtonAndTextColor(
        AppColors.actionButtonColor.withOpacity(AppUIValue.opacityActionButton),
        AppText.refuse,
        context,
        () => widget.routeToRefuse(timing.uuid),
        Colors.black,
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: elevatedButtonAndTextColor(
              AppColors.actionButtonColor
                  .withOpacity(AppUIValue.opacityActionButton),
              AppText.createEstimate,
              context,
              () {
                final estimate = Estimate();
                estimate.workRequestId = timing.workRequest?.uuid;
                Navigator.pushNamed(
                  context,
                  '/artisan/create_estimate/description',
                  arguments: estimate,
                );
              },
              Colors.black,
            ),
          ),
          SizedBox(
            height: AppUIValue.spaceScreenToAny,
          ), // Add spacing between the buttons
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: elevatedButtonAndTextColor(
              Colors.black,
              AppText.refuse,
              context,
              () => widget.routeToRefuse(timing.uuid),
              Colors.white,
            ),
          ),
        ],
      );
    }
  }
}
