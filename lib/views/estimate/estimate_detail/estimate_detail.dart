import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/widget/button/elevated_button_opacity.dart';

import '../../../core_value.dart';
import '../../../models/estimate/estimate.dart';
import '../../../text/fr.dart';
import '../../../widget/decoration/decoration_round_main_color.dart';
import '../../../widget/handle_status/text_based_on_user.dart';
import '../../../widget/text_style/text_style_main_color.dart';
import '../common_app_bar.dart';

class EstimateDetail extends StatefulWidget {
  const EstimateDetail({
    super.key,
    required this.fetchData,
    required this.uuid,
    required this.role,
    required this.patchStatus,
    required this.refuseEstimate,
    required this.goToConv,
    required this.goToTiming,
  });

  final Function(String?) fetchData;
  final String? uuid;
  final String role;
  final Function(String?,VoidCallback) patchStatus;
  final Function(String?,VoidCallback) refuseEstimate;
  final Function(String?) goToConv;
  final Function(String?) goToTiming;

  @override
  State<EstimateDetail> createState() => _EstimateDetailState();
}

class _EstimateDetailState extends State<EstimateDetail> {
  late Future<Estimate?> _futureEstimate;

  Estimate estimateFromRequest = Estimate();
  //String validateEstimateText = '';

  @override
  void initState() {
    super.initState();
    _futureEstimate =
        widget.fetchData(widget.uuid); // Initialize the Future once
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: estimateAppBar(
        context,
        () => widget.goToConv(estimateFromRequest.uuid),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: _futureEstimate,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError || snapshot.data == null) {
                return const Center(child: Text(AppText.apiErrorText));
              }
              estimateFromRequest =  snapshot.data!;
              return Padding(
                padding: EdgeInsets.all(AppUIValue.spaceScreenToAny),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppUIValue.spaceScreenToAny * 2),
                    Center(
                      child: Text(
                        estimateFromRequest.workRequest?.title ?? AppText.noTitleForWork,
                        style: getTextStyleMainColor(AppUIValue.sizeFontTitle),
                      ),
                    ),
                    const SizedBox(height: AppUIValue.spaceScreenToAny),
                    textEstimateStatusUser(
                        estimateFromRequest.status,
                        estimateFromRequest.statusGoal,
                        context,
                        widget.role,
                    ),
                    const SizedBox(height: AppUIValue.spaceScreenToAny * 2),
                    Text(
                      estimateFromRequest.price == null
                          ? AppText.noPriceEstimate
                          : '${AppText.createEstimatePrice}: ${estimateFromRequest.price} ${AppText.euro}',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(height: AppUIValue.spaceScreenToAny * 2),
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
                        estimateFromRequest.description ??
                            AppText.noDescriptionEstimate,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                    const SizedBox(height: AppUIValue.spaceScreenToAny * 2),
                    Text(
                      AppText.commentary,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      estimateFromRequest.commentary ?? AppText.noCommentary,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const SizedBox(height: AppUIValue.spaceScreenToAny * 3),
                    if(handleText() == AppText.validate)
                    Center(
                      child: elevatedButtonAndTextColor(
                        AppColors.mainBackgroundColor,
                        //validateEstimateText == '' ? handleText() :
                        handleText(),
                        context,
                        handleButton(),
                        AppColors.mainTextColor,
                      ),
                    ),
                    const SizedBox(height: AppUIValue.spaceScreenToAny),
                    if(handleText() == AppText.estimateAlreadyAccept)
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: elevatedButtonAndTextColor(
                            AppColors.mainBackgroundColor,
                            AppText.timingEstimate,
                            context,
                                () {
                              widget.goToTiming(estimateFromRequest.uuid);
                            },
                            AppColors.mainTextColor,
                          ),
                        ),
                      ),
                    const SizedBox(height: AppUIValue.spaceScreenToAny*3),
                    if(handleText() == AppText.estimateAlreadyAccept)
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: elevatedButtonAndTextColor(
                                Colors.black,
                                AppText.refuseEstimate,
                                context,
                                (){
                                  widget.refuseEstimate(estimateFromRequest.uuid,()async{
                                    var estimateStatic = await widget.fetchData(widget.uuid);
                                    setState((){
                                      //validateEstimateText = AppText.validate;
                                      estimateFromRequest.status = estimateStatic.status;
                                    });
                                  });
                                },
                                Colors.white,
                            ),
                          ),
                        ),
                    const SizedBox(height: AppUIValue.spaceScreenToAny),
                  ],
                ),
              );
            }),
      ),
    );
  }

  String handleText() {
    if (estimateFromRequest.status == estimateFromRequest.statusGoal) {
      return AppText.estimateAlreadyAccept;
    }
    if (widget.role == RoleBasedText.council &&
        estimateFromRequest.status == 3) {
      return AppText.estimateAlreadyAccept;
    }
    if (widget.role == RoleBasedText.union && estimateFromRequest.status == 5) {
      return AppText.estimateAlreadyAccept;
    }
    return AppText.validate;
  }

  VoidCallback handleButton() {
    // ignore the click if the user already validate the estimate
    if (estimateFromRequest.status == estimateFromRequest.statusGoal) {
      return () {};
    }
    if (widget.role == RoleBasedText.council &&
        estimateFromRequest.status == 3) {
      return () {};
    }
    if (widget.role == RoleBasedText.union && estimateFromRequest.status == 5) {
      return () {};
    }
    return () async {
      widget.patchStatus(estimateFromRequest.uuid,()async{
        var estimateStatic = await widget.fetchData(widget.uuid);
        setState(() {
          //validateEstimateText = AppText.estimateAlreadyAccept;
          estimateFromRequest.status = estimateStatic.status;
        });
      });
    };
  }
}
