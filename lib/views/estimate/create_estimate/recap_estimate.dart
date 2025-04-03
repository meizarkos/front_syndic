import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/widget/button/elevated_button_opacity.dart';

import '../../../api_handler/estimate/post_estimate.dart';
import '../../../models/estimate/estimate.dart';
import '../../../text/fr.dart';
import '../../../widget/decoration/decoration_round_main_color.dart';
import '../../../widget/header/app_bar_back_button.dart';

class RecapEstimate extends StatefulWidget {
  const RecapEstimate({
    super.key,
    required this.estimate,
  });

  final Estimate estimate;

  @override
  State<RecapEstimate> createState() => _RecapEstimateState();
}

class _RecapEstimateState extends State<RecapEstimate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBackButton(context,title : AppText.createWorkRequestRecap),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(AppUIValue.spaceScreenToAny),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
                    widget.estimate.description ?? AppText.noDescriptionWorkRequest,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                const SizedBox(height: AppUIValue.spaceScreenToAny * 3),
                Text(
                  '${AppText.createEstimatePrice} : ${widget.estimate.price}',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: AppUIValue.spaceScreenToAny*3),
                Text(
                  AppText.commentary,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 2),
                Container(
                  padding: EdgeInsets.all(AppUIValue.spaceScreenToAny),
                  width: double.infinity,
                  decoration: decorationRoundMainColor(),
                  child: Text(
                    widget.estimate.commentary ?? AppText.noCommentary,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                const SizedBox(height: AppUIValue.spaceScreenToAny*2),
                Center(
                  child: elevatedButtonAndTextColor(
                    AppColors.mainBackgroundColor,
                    AppText.save,
                    context,
                      _save,
                    AppColors.mainTextColor
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }

  void _save() async{
   if(widget.estimate.conversationId == null){
     return;
   }
   await postEstimateArtisan(widget.estimate);
   Navigator.pop(context);
   Navigator.pop(context);
   Navigator.pop(context);
   Navigator.pushReplacementNamed(context,'/estimate/artisan/detail',arguments: widget.estimate.conversationId!);
  }
}
