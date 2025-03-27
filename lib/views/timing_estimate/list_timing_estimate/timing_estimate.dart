import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/models/adress/adress.dart';
import 'package:front_syndic/text/fr.dart';
import 'package:front_syndic/widget/button/elevated_button_opacity.dart';
import 'package:front_syndic/widget/header/app_bar_back_button.dart';
import 'package:front_syndic/widget/text_style/text_style_main_color.dart';

import '../../../core_value.dart';
import '../../../models/timing/timing_estimate.dart';
import '../../../utils/date_to_string/date.dart';
import '../../../widget/button/add_floating_button.dart';
import '../../../widget/decoration/decoration_round_main_color.dart';
import '../../../widget/dialog/show_dialog_text.dart';
import '../../../widget/handle_status/text_based_on_user.dart';

class TimingEstimateView extends StatefulWidget {
  const TimingEstimateView({
    super.key,
    required this.fetchData,
    required this.uuid,
    required this.valueValidateByYou, //all value where the timing is validated by you (length = 3)
    required this.routeToPost,
    required this.onAccept,
    required this.onRefuse,
    required this.role,
    this.apiPaiement,
  });

  final Function(String?) fetchData;
  final String? uuid;
  final List<int> valueValidateByYou;
  final String routeToPost;
  final Function(String?) onAccept;
  final Function(String?) onRefuse;
  final String role;
  final Function(int amount,String currency)? apiPaiement;

  @override
  State<TimingEstimateView> createState() => _TimingEstimateViewState();
}

class _TimingEstimateViewState extends State<TimingEstimateView> {
  TimingEstimate? timingEstimateStatic;
  Adress? adress;

  bool isLoading = true;

  @override
  void initState() {
    widget.fetchData(widget.uuid).then((value) {
      setState(() {
        timingEstimateStatic = value as TimingEstimate;
        adress = timingEstimateStatic?.workRequest?.adress;
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: appBarBackButton(context, title: AppText.timingEstimate),
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (timingEstimateStatic?.uuid == null) {
      return Scaffold(
          appBar: appBarBackButton(context, title: AppText.timingEstimate),
          body: Padding(
            padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
            child: Center(
              child: Text(AppText.noTimingEstimate),
            ),
          ),
          floatingActionButton: addFloatingButton(() {
            final TimingEstimate timingEstimate = TimingEstimate(
              estimateId: widget.uuid,
            );
            Navigator.pushReplacementNamed(context, widget.routeToPost,
                arguments: timingEstimate);
          }));
    }
    return Scaffold(
      appBar: appBarBackButton(context, title: AppText.timingEstimate),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              Center(
                child: Text(
                  timingEstimateStatic?.workRequest?.title ??
                      AppText.noTitleForWork,
                  style: getTextStyleMainColor(18),
                ),
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              Text(
                timingEstimateHandleValidation(
                  timingEstimateStatic?.status,
                  timingEstimateStatic?.statusGoal,
                  widget.role,
                ),
                style: Theme
                    .of(context)
                    .textTheme
                    .displaySmall,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny * 2),
              Text(
                "${AppText.dateStartForTimingOfWorkRequest} :",
                style: Theme
                    .of(context)
                    .textTheme
                    .displayMedium,
              ),
              const SizedBox(height: 10),
              Text(
                (formatStringToApiDate(
                    timingEstimateStatic?.dateStart, 'dd/MM/yyyy') ??
                    AppText.noDateStartForTimingEstimate) +
                    " ${AppText.at} " +
                    formatTimeString(timingEstimateStatic?.timeStart),
                style: Theme
                    .of(context)
                    .textTheme
                    .displaySmall,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              Container(
                decoration: decorationRoundMainColor(),
                width: double.infinity,
                padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
                child: Column(
                  children: [
                    Text(
                      AppText.interventionPlace,
                      style: Theme
                          .of(context)
                          .textTheme
                          .displayMedium,
                    ),
                    const SizedBox(height: AppUIValue.spaceScreenToAny),
                    Text(
                      "${adress?.country ?? ''}\n"
                          "${adress?.city ?? ''}, ${adress?.postalCode ?? ''}\n"
                          "${adress?.street ?? ''}\n"
                          "${adress?.comment ?? ''}",
                      style: Theme
                          .of(context)
                          .textTheme
                          .displaySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              Text(
                "${AppText.dateEndForTimingOfWorkRequest} :",
                style: Theme
                    .of(context)
                    .textTheme
                    .displayMedium,
              ),
              const SizedBox(height: 10),
              Text(
                formatStringToApiDate(
                    timingEstimateStatic?.dateEnd, 'dd/MM/yyyy') ??
                    AppText.noDateEndForTimingEstimate,
                style: Theme
                    .of(context)
                    .textTheme
                    .displaySmall,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny * 2),
              if (!widget.valueValidateByYou
                  .contains(timingEstimateStatic?.status))
                Center(
                  child: SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.5,
                    child: elevatedButtonAndTextColor(
                      AppColors.mainBackgroundColor,
                      AppText.validate,
                      context,
                          () {
                        widget.onAccept(timingEstimateStatic?.uuid);
                      },
                      AppColors.mainTextColor,
                    ),
                  ),
                ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              Center(
                child: SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.5,
                  child: elevatedButtonAndTextColor(
                    AppColors.actionButtonColor
                        .withOpacity(AppUIValue.opacityActionButton),
                    AppText.refuse,
                    context,
                        () =>
                        showMyAlert(
                            context,
                            AppText.refuseTimingEstimate,
                            AppText.refuseTimingEstimateText,
                                () {
                              widget.onRefuse(timingEstimateStatic?.uuid);
                            }
                        ),
                    Colors.black,
                  ),
                ),
              ),
              if (timingEstimateStatic?.status == timingEstimateStatic?.statusGoal && widget.apiPaiement != null) ...[
                const SizedBox(height: AppUIValue.spaceScreenToAny*2),
                Center(
                  child: SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.5,
                    child: elevatedButtonAndTextColor(
                      AppColors.mainBackgroundColor,
                      AppText.payment,
                      context,
                      () {
                        makePayment();
                      },
                      // Ensure it's a function reference
                      AppColors.mainTextColor,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> createPaymentIntent(int amount, String currency) async {
    try {
      return await widget.apiPaiement!(amount, currency);
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> makePayment() async {
    var price = timingEstimateStatic?.estimate?.price;
    if (price == null) {
      return;
    }
    var priceCents = (price * 100).toInt();
    try {
      var paymentIntent = await createPaymentIntent(priceCents, 'EUR'); //API call

      if(paymentIntent == null){
        return;
      }

      await Stripe.instance
          .initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent,
              style: ThemeMode.light,
              merchantDisplayName: 'Ikay')
      );

      //STEP 3: Display Payment sheet
      await displayPaymentSheet();
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    }
    catch (e) {
      print('$e');
    }
  }
}