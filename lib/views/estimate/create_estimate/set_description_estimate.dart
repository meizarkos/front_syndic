import 'package:flutter/material.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/widget/button/elevated_button_opacity.dart';
import 'package:front_syndic/widget/visibility/error.dart';

import '../../../color.dart';
import '../../../models/estimate/estimate.dart';
import '../../../text/fr.dart';
import '../../../widget/decoration/text_field_deco_main.dart';
import '../../../widget/header/app_bar_back_button.dart';

class SetDescriptionEstimate extends StatefulWidget {
  const SetDescriptionEstimate({
    super.key,
    required this.estimate,
  });

  final Estimate estimate;

  @override
  State<SetDescriptionEstimate> createState() => _SetDescriptionEstimateState();
}

class _SetDescriptionEstimateState extends State<SetDescriptionEstimate> {

  String descriptionValue = '';
  bool errorVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBackButton(context),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(AppUIValue.spaceScreenToAny),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration : textFieldMainDeco(AppText.descEstimatePlaceHolder),
                  onChanged: (value) {
                    descriptionValue = value;
                  },
                  maxLength: 1280,
                  maxLines: 10,
                ),
                const SizedBox(height: 10),
                ErrorVisibility(errorVisibility: errorVisibility, errorText: AppText.createTitleWorkErrorText),
                Center(
                  child: elevatedButtonAndTextColor(
                      AppColors.mainBackgroundColor,
                      AppText.save,
                      context,
                      (){
                        if(descriptionValue.isEmpty){
                          setState(() {
                            errorVisibility = true;
                          });
                        } else {
                          widget.estimate.description = descriptionValue;
                          Navigator.pushNamed(context, '/artisan/create_estimate/price', arguments: widget.estimate);
                        }
                      },
                      AppColors.mainTextColor,
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}
