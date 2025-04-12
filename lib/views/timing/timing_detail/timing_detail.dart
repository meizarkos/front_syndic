import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/union/union.dart';
import 'package:front_syndic/widget/header/app_bar_back_button.dart';
import 'package:front_syndic/widget/text_style/text_style_main_color.dart';

import '../../../models/artisan/artisan.dart';
import '../../../models/council/council.dart';
import '../../../models/timing/timing.dart';
import '../../../models/user/user.dart';
import '../../../text/fr.dart';
import '../../../utils/date_to_string/date.dart';
import '../../../widget/button/elevated_button_opacity.dart';
import '../../../widget/decoration/decoration_round_main_color.dart';

class TimingDetail extends StatefulWidget {
  const TimingDetail({
    super.key,
    required this.routeToRefuse,
    required this.routeToCreateMeeting,
    required this.future,
    required this.textContact,
  });

  final Function(String?) routeToRefuse;
  final VoidCallback routeToCreateMeeting;
  final Future<TimingAndCreator?> future;
  final Function(TimingAndCreator) textContact;

  @override
  State<TimingDetail> createState() => _TimingDetailState();
}

class _TimingDetailState extends State<TimingDetail> {

  TimingAndCreator? timingAndCreator;
  Timing? timing;
  Artisan? artisan;
  UnionApi? union;
  Council? council;
  User? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    widget.future.then((value) {
      setState(() {
        isLoading = false;
      });
      if (value?.timing?.uuid != null) {
        setState(() {
          timing = value?.timing;
          artisan = value?.artisan;
          union = value?.union;
          council = value?.council;
          user = value?.user;
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
    if(isLoading == false && timing?.uuid == null) { // create a meeting
      return Scaffold(
        appBar: appBarBackButton(context,title: AppText.timing),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                AppText.noTimingWaiting,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            const SizedBox(height: AppUIValue.spaceScreenToAny * 2),
            Center(
              child: elevatedButtonAndTextColor(
                AppColors.actionButtonColor.withOpacity(AppUIValue.opacityActionButton),
                AppText.createAMeeting,
                context,
                widget.routeToCreateMeeting,
                Colors.black,
              ),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: appBarBackButton(context, title: AppText.timing),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
          child: Column(
            children: [
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              Center(
                child: Text(
                  timing?.workRequest?.title ?? AppText.noTitleForWork,
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
                        '${AppText.meetingEstimateText} ${formatStringToApiDate(timing?.date, 'dd/MM')} ${AppText.at} ${timing?.time?.substring(0, 5).replaceAll(':', 'h') ?? ''}.',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      Text(
                        "\n\n${AppText.interventionPlace}"
                        "\n\n${timing?.workRequest?.adress?.street ?? ''}, ${timing?.workRequest?.adress?.city ?? ''}, ${timing?.workRequest?.adress?.postalCode ?? ''}"
                        "\n${timing?.workRequest?.adress?.country?.toUpperCase() ?? ''} \n",
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
                    widget.textContact(TimingAndCreator(timing, artisan, union, council,user)),
                    style: Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: elevatedButtonAndTextColor(
                  AppColors.actionButtonColor.withOpacity(AppUIValue.opacityActionButton),
                  AppText.refuse,
                  context,
                      () => widget.routeToRefuse(timing?.uuid),
                  Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
