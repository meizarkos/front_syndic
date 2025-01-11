import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/to_screen/see_conv_arg.dart';
import 'package:front_syndic/widget/button/deleteButton.dart';
import 'package:front_syndic/widget/button/elevated_button_opacity.dart';
import 'package:front_syndic/widget/visibility/error.dart';

import '../../../api_handler/conversation/fetch_conversation.dart';
import '../../../api_handler/estimate/delete_estimate.dart';
import '../../../api_handler/estimate/patch_estimate.dart';
import '../../../api_handler/timing_estimate/get_timing_estimate.dart';
import '../../../models/estimate/estimate.dart';
import '../../../text/fr.dart';
import '../../../widget/cell_app_bar_in_progress/createButton.dart';
import '../../../widget/decoration/text_field_deco_main.dart';
import '../../../widget/handle_status/text_to_display_based_on_status.dart';
import '../../../widget/text_style/text_style_main_color.dart';
import '../common_app_bar.dart';

class EstimateDetailArtisan extends StatefulWidget {
  const EstimateDetailArtisan({
    super.key,
    required this.fetchData,
    required this.uuid,
  });

  final Function(String?) fetchData;
  final String? uuid;

  @override
  State<EstimateDetailArtisan> createState() => _EstimateDetailArtisanState();
}

class _EstimateDetailArtisanState extends State<EstimateDetailArtisan> {
  final TextEditingController _controllerDesc = TextEditingController();
  final TextEditingController _controllerPrice = TextEditingController();
  final TextEditingController _controllerCommentary = TextEditingController();
  Estimate estimateFromRequest = Estimate();
  bool errorVisibilityModify = false;
  bool errorVisibility = false;

  late Future<Estimate?>
      _futureEstimate; // Store the Future in a state variable

  @override
  void initState() {
    super.initState();
    _futureEstimate =
        widget.fetchData(widget.uuid); // Initialize the Future once
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: estimateAppBarArtisan(
        context,
        () {
          if (estimateFromRequest.uuid == null) return;
          Navigator.pushNamed(
            context,
            '/artisan/see_conv',
            arguments: SeeConvArg(
              uuid: estimateFromRequest.uuid!,
              futureToFetchData: fetchSpecificConvArtisanFromEstimate,
            ),
          );
        },
        () {
          if (estimateFromRequest.uuid == null) return;
          Navigator.pushNamed(
            context,
            'artisan/timing_estimate',
            arguments: SeeConvArg(
              uuid: estimateFromRequest.uuid!,
              futureToFetchData: fetchTimingEstimateArtisan,
            ),
          );
        },
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
            final estimate = snapshot.data!;
            _controllerCommentary.text = estimate.commentary ?? '';
            _controllerDesc.text = estimate.description ?? '';
            _controllerPrice.text = estimate.price.toString();
            estimateFromRequest = estimate;
            return Padding(
              padding: EdgeInsets.all(AppUIValue.spaceScreenToAny),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: AppUIValue.spaceScreenToAny * 2),
                  Center(
                    child: Text(
                      estimate.workRequest?.title ?? AppText.noTitleForWork,
                      style: getTextStyleMainColor(AppUIValue.sizeFontTitle),
                    ),
                  ),
                  const SizedBox(height: AppUIValue.spaceScreenToAny),
                  textEstimateStatus(estimateFromRequest.status,
                      estimateFromRequest.statusGoal, context),
                  const SizedBox(height: AppUIValue.spaceScreenToAny * 2),
                  TextField(
                    controller: _controllerPrice,
                    decoration: textFieldMainDeco(AppText.createEstimatePrice),
                    onChanged: (value) {
                      try {
                        final price = double.parse(value);
                        estimateFromRequest.price = price;
                      } catch (e) {
                        estimateFromRequest.price = -1;
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
                      estimateFromRequest.description = value;
                    },
                    minLines: 5,
                    maxLines: 13,
                  ),
                  const SizedBox(height: AppUIValue.spaceScreenToAny * 2),
                  TextField(
                    controller: _controllerCommentary,
                    decoration: textFieldMainDeco(AppText.commentary),
                    onChanged: (value) {
                      estimateFromRequest.commentary = value;
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
            );
          },
        ),
      ),
    );
  }

  void _modify() {
    setState(() {
      errorVisibility = false;
      errorVisibilityModify = false;
    });
    if (estimateFromRequest.price == null ||
        estimateFromRequest.price! < 0 ||
        estimateFromRequest.description == '' ||
        estimateFromRequest.description == null) {
      setState(() {
        errorVisibility = true;
      });
      return;
    }
    if (estimateFromRequest.uuid == null) return;
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
                Navigator.of(context)
                    .pop(); // Close the dialog without doing anything
              },
            ),
            TextButton(
              child: Text(AppText.confirm),
              onPressed: () async {
                setState(() {
                  errorVisibilityModify = true;
                });
                await patchEstimateArtisan(estimateFromRequest);
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
                await deleteEstimateArtisan(estimateFromRequest.uuid);
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/in_progress/artisan',
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
