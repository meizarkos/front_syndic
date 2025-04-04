import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/widget/button/elevated_button_opacity.dart';
import 'package:front_syndic/widget/header/app_bar_back_button.dart';

import '../../../core_value.dart';
import '../../../models/estimate/estimate.dart';
import '../../../text/fr.dart';
import '../../../widget/decoration/decoration_round_main_color.dart';
import '../../../widget/handle_status/text_based_on_user.dart';
import '../../../widget/text_style/text_style_main_color.dart';

class EstimateDetail extends StatefulWidget {
  const EstimateDetail({
    super.key,
    required this.uuid,
    required this.fetchData,
    required this.role,
    required this.patchStatus,
    required this.refuseEstimate,
    required this.goToBack,
  });

  final String? uuid;
  final Function(String?) fetchData;
  final String role;
  final Function(String?, VoidCallback) patchStatus;
  final Function(String?, VoidCallback) refuseEstimate;
  final VoidCallback goToBack;

  @override
  State<EstimateDetail> createState() => _EstimateDetailState();
}

class _EstimateDetailState extends State<EstimateDetail> {
  Estimate? estimateFromRequest;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    widget.fetchData(widget.uuid).then((value) {
      setState(() {
        isLoading = false;
        estimateFromRequest = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: appBarBackButton(context, title: AppText.estimate),
        body: Center(
          child: CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(AppColors.mainBackgroundColor),
          ),
        ),
      );
    } else if (estimateFromRequest?.uuid == null && !isLoading) {
      return Scaffold(
        appBar: appBarBackButton(context, title: AppText.estimate),
        body: Padding(
          padding: EdgeInsets.all(AppUIValue.spaceScreenToAny),
          child: Center(
            child: Text(
              AppText.noEstimateWaiting,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: widget.goToBack,
        ),
        title: Text(AppText.estimate),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppUIValue.spaceScreenToAny),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  estimateFromRequest?.workRequest?.title ??
                      AppText.noTitleForWork,
                  style: getTextStyleMainColor(AppUIValue.sizeFontTitle),
                ),
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              textEstimateStatusUser(
                estimateFromRequest?.status,
                estimateFromRequest?.statusGoal,
                context,
                widget.role,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              Text(
                AppText.description,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 2),
              Container(
                padding: EdgeInsets.all(AppUIValue.spaceScreenToAny),
                width: double.infinity,
                decoration: decorationRoundMainColor(),
                child: globalText(),
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              Text(
                AppText.commentary,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 2),
              Text(
                estimateFromRequest?.commentary ?? AppText.noCommentary,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              if (handleText() == AppText.validate)
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
              if (handleText() == AppText.estimateAlreadyAccept) // refuse button
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: elevatedButtonAndTextColor(
                      Colors.black,
                      AppText.refuseEstimate,
                      context,
                      () => alertToAccept(AppText.refuseEstimateAlertDialog, () async {
                        await widget.refuseEstimate(estimateFromRequest?.uuid, () async {
                          var estimateStatic = await widget.fetchData(widget.uuid);
                          setState(() {
                            estimateFromRequest?.status = estimateStatic.status;
                          });
                        });
                      }),
                      Colors.white,
                    ),
                  ),
                ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
            ],
          ),
        ),
      ),
    );
  }

  RichText globalText(){
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ), // Use default style as base
        children: [
          TextSpan(
            text: '${AppText.createEstimatePrice}: ',
            style: const TextStyle(
                fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: '${estimateFromRequest?.price} ${AppText.euro}\n\n',
          ),
          TextSpan(
            text: estimateFromRequest?.description ?? AppText.noDescriptionEstimate,
          ),
        ],
      ),
    );
  }

  String handleText() {
    if (estimateFromRequest?.status == estimateFromRequest?.statusGoal) {
      return AppText.estimateAlreadyAccept;
    }
    if (widget.role == RoleBasedText.council &&
        estimateFromRequest?.status == 3) {
      return AppText.estimateAlreadyAccept;
    }
    if (widget.role == RoleBasedText.union &&
        estimateFromRequest?.status == 5) {
      return AppText.estimateAlreadyAccept;
    }
    return AppText.validate;
  }

  VoidCallback handleButton() {
    // ignore the click if the user already validate the estimate
    if (estimateFromRequest?.status == estimateFromRequest?.statusGoal) {
      return () {};
    }
    if (widget.role == RoleBasedText.council &&
        estimateFromRequest?.status == 3) {
      return () {};
    }
    if (widget.role == RoleBasedText.union &&
        estimateFromRequest?.status == 5) {
      return () {};
    }

    return () => alertToAccept(AppText.acceptEstimateAlertDialog, () async {
          widget.patchStatus(estimateFromRequest?.uuid, () async {
            var estimateStatic = await widget.fetchData(widget.uuid);
            setState(() {
              estimateFromRequest?.status = estimateStatic.status;
            });
          });
        });
  }

  Future alertToAccept(String text, Function executeFunction) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(text),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text(AppText.cancel),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context); // Close the dialog
                await executeFunction(); // Execute function asynchronously
              },
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }
}
