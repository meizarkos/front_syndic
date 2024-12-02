import 'package:flutter/material.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/to_screen/see_conv_arg.dart';
import 'package:front_syndic/widget/header/app_bar_back_button.dart';
import 'package:front_syndic/widget/visibility/error.dart';

import '../../../api_handler/conversation/fetch_conversation.dart';
import '../../../api_handler/estimate/delete_estimate.dart';
import '../../../api_handler/estimate/get_estimate_detail.dart';
import '../../../api_handler/estimate/patch_estimate.dart';
import '../../../models/estimate/estimate.dart';
import '../../../text/fr.dart';
import '../../../widget/button/row_bottom_bar.dart';
import '../../../widget/button/row_of_nav_button.dart';
import '../../../widget/decoration/text_field_deco_main.dart';
import '../../../widget/handle_status/alert_to_display.dart';
import '../../../widget/handle_status/text_to_display_based_on_status.dart';
import '../../../widget/text_style/text_style_main_color.dart';

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
                  const SizedBox(height: AppUIValue.spaceScreenToAny),
                  rowOfNavButton(
                    AppText.seeConv,
                    AppText.timingEstimate,
                    context,
                    (){
                      if (estimateFromRequest.uuid == null) return;
                      Navigator.pushNamed(
                        context,
                        '/artisan/see_conv',
                        arguments: SeeConvArg(
                            uuid: estimateFromRequest.uuid!,
                            futureToFetchData:
                                fetchSpecificConvArtisanFromEstimate),
                      );
                    },
                    () {
                      handleStatus(estimateFromRequest.status, estimateFromRequest.statusGoal, context,
                          () {print('aaaaaa');}
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
                      errorText: AppText.textFieldErrorCreateEstimate)
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ErrorVisibility(
              errorVisibility: errorVisibilityModify,
              errorText: AppText.textFieldEstimateModify,
              color: Colors.green),
          rowBottomBar(
            context,
            () {
              _modify();
            },
            () {
              _delete();
            },
          ),
        ],
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
    if(estimateFromRequest.uuid == null) return;
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
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/estimate/artisan/detail',
                    arguments: SeeConvArg(uuid: estimateFromRequest.uuid!, futureToFetchData: fetchEstimateDetailArtisan));
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
