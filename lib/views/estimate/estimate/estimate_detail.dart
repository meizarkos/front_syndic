import 'package:flutter/material.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/widget/header/app_bar_back_button.dart';

import '../../../models/estimate/estimate.dart';
import '../../../text/fr.dart';
import '../../../widget/button/row_of_nav_button.dart';
import '../../../widget/text_style/text_style_main_color.dart';

class EstimateDetail extends StatefulWidget {
  const EstimateDetail({
    super.key,
    required this.fetchData,
    required this.uuid,
  });

  final Function(String?) fetchData;
  final String? uuid;

  @override
  State<EstimateDetail> createState() => _EstimateDetailState();
}

class _EstimateDetailState extends State<EstimateDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBackButton(context, title: AppText.estimateDetailTitle),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: widget.fetchData(widget.uuid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError || snapshot.data == null) {
            return const Center(child: Text(AppText.apiErrorText));
            }
            final estimate = snapshot.data! as Estimate;
            return Padding(
                padding: EdgeInsets.all(AppUIValue.spaceScreenToAny),
                child: Column(
                  children: [
                    const SizedBox(height: AppUIValue.spaceScreenToAny),
                    rowOfNavButton(
                      AppText.seeConv,
                      AppText.timingEstimate,
                      context,
                      () {

                      },
                      (){

                      },
                    ),
                    const SizedBox(height: AppUIValue.spaceScreenToAny*2),
                    Text(
                      estimate.workRequest?.title ?? AppText.noTitleForWork,
                      style: getTextStyleMainColor(AppUIValue.sizeFontTitle),
                    ),
                    const SizedBox(height: AppUIValue.spaceScreenToAny),
                    Text(
                      estimate.description ?? AppText.noDescriptionEstimate,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ],
                ),
            );
          }
        )
      ),
    );
  }
}
