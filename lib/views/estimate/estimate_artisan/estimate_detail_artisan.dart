import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/widget/button/deleteButton.dart';
import 'package:front_syndic/widget/button/elevated_button_opacity.dart';
import 'package:front_syndic/widget/visibility/error.dart';

import '../../../api_handler/estimate/delete_estimate.dart';
import '../../../api_handler/estimate/get_estimate_detail.dart';
import '../../../api_handler/estimate/patch_estimate.dart';
import '../../../models/estimate/estimate.dart';
import '../../../text/fr.dart';
import '../../../widget/decoration/text_field_deco_main.dart';
import '../../../widget/handle_status/text_to_display_based_on_status.dart';
import '../../../widget/header/app_bar_back_button.dart';
import '../../../widget/text_style/text_style_main_color.dart';

class EstimateDetailArtisan extends StatefulWidget {
  const EstimateDetailArtisan({
    super.key,
    required this.convUuid,
  });

  final String? convUuid;

  @override
  State<EstimateDetailArtisan> createState() => _EstimateDetailArtisanState();
}

class _EstimateDetailArtisanState extends State<EstimateDetailArtisan> {
  final TextEditingController _controllerDesc = TextEditingController();
  final TextEditingController _controllerPrice = TextEditingController();
  final TextEditingController _controllerCommentary = TextEditingController();

  Estimate? estimateFromRequest;
  bool errorVisibilityModify = false;
  bool errorVisibility = false;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchEstimateDetailArtisanFromConversation(widget.convUuid).then((value) {
      setState(() {
        isLoading = false;
        estimateFromRequest = value;
        _controllerCommentary.text = estimateFromRequest?.commentary ?? '';
        _controllerDesc.text = estimateFromRequest?.description ?? '';
        if(estimateFromRequest?.price != null) {
          _controllerPrice.text = estimateFromRequest!.price.toString();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: appBarBackButton(context, title: AppText.estimate),
        body: const Center(child: CircularProgressIndicator()),
      );
    } else if (estimateFromRequest?.uuid == null && !isLoading) {
      return Scaffold(
        appBar: appBarBackButton(context, title: AppText.estimate),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppText.noEstimate),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              elevatedButtonAndTextColor(
                AppColors.actionButtonColor
                    .withOpacity(AppUIValue.opacityActionButton),
                AppText.createEstimate,
                context,
                () {
                  var estimate = Estimate();
                  estimate.conversationId = widget.convUuid;
                  Navigator.pushNamed(context, '/artisan/create_estimate/description',arguments: estimate);
                },
                Colors.black,
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, '/artisan/see_conv',arguments: widget.convUuid);
          },
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
              const SizedBox(height: AppUIValue.spaceScreenToAny * 2),
              Center(
                child: Text(
                  estimateFromRequest?.workRequest?.title ??
                      AppText.noTitleForWork,
                  style: getTextStyleMainColor(AppUIValue.sizeFontTitle),
                ),
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              textEstimateStatus(estimateFromRequest?.status,
                  estimateFromRequest?.statusGoal, context),
              const SizedBox(height: AppUIValue.spaceScreenToAny * 2),
              TextField(
                controller: _controllerPrice,
                decoration: textFieldMainDeco(AppText.createEstimatePrice),
                onChanged: (value) {
                  try {
                    final price = double.parse(value);
                    estimateFromRequest?.price = price;
                  } catch (e) {
                    estimateFromRequest?.price = -1;
                    return;
                  }
                },
                maxLines: 1,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny * 2),
              TextField(
                controller: _controllerDesc,
                decoration: textFieldMainDeco(AppText.descEstimate),
                onChanged: (value) {
                  estimateFromRequest?.description = value;
                },
                minLines: 5,
                maxLines: 13,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny * 2),
              TextField(
                controller: _controllerCommentary,
                decoration: textFieldMainDeco(AppText.commentary),
                onChanged: (value) {
                  estimateFromRequest?.commentary = value;
                },
                minLines: 5,
                maxLines: 13,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              ErrorVisibility(
                errorVisibility: errorVisibility,
                errorText: AppText.textFieldErrorCreateEstimate,
              ),
              ErrorVisibility(
                errorVisibility: errorVisibilityModify,
                errorText: AppText.textFieldEstimateModify,
                color: Colors.green,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              SizedBox(
                width: double.infinity,
                child: elevatedButtonAndTextColor(
                  AppColors.mainBackgroundColor,
                  AppText.modify,
                  context,
                  () {
                    _modify();
                  },
                  AppColors.mainTextColor,
                ),
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny * 2),
              deleteButton(
                () {
                  _delete();
                },
                context,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _modify() {
    setState(() {
      errorVisibility = false;
      errorVisibilityModify = false;
    });
    if (estimateFromRequest == null || estimateFromRequest?.price == null ||
        estimateFromRequest!.price! < 0 ||
        estimateFromRequest?.description == '' ||
        estimateFromRequest?.description == null) {
      setState(() {
        errorVisibility = true;
      });
      return;
    }
    if (estimateFromRequest?.uuid == null) return;
    showDialog(
      context: context, // Pass the context from your widget
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppText.recapDialogEstimateModify),
          content: Text(AppText.recapDialogEstimateModifyContent),
          actions: [
            TextButton(
              child: Text(AppText.cancel),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text(AppText.confirm),
              onPressed: () async {
                setState(() {
                  errorVisibilityModify = true;
                });
                if(estimateFromRequest == null) return;
                await patchEstimateArtisan(estimateFromRequest!);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _delete() async {
    showDialog(
      context: context, // Pass the context from your widget
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppText.recapDialogTitle),
          content: Text(AppText.recapDialogDelete),
          actions: [
            TextButton(
              child: Text(AppText.cancel),
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Close the dialog without doing anything
              },
            ),
            TextButton(
              child: Text(AppText.confirm),
              onPressed: () async {
                await deleteEstimateArtisan(estimateFromRequest?.uuid);
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/artisan/see_conv',arguments: widget.convUuid);
              },
            ),
          ],
        );
      },
    );
  }
}
