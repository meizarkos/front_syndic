import 'package:flutter/material.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/widget/header/app_bar_back_button.dart';

import '../../../color.dart';
import '../../../models/estimate/estimate.dart';
import '../../../text/fr.dart';
import '../../../widget/button/row_bottom_bar.dart';
import '../../../widget/button/row_of_nav_button.dart';
import '../../../widget/decoration/text_field_deco_main.dart';
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
  final TextEditingController _controllerDesc = TextEditingController();
  final TextEditingController _controllerPrice = TextEditingController();
  final TextEditingController _controllerCommentary = TextEditingController();

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
            _controllerCommentary.text = estimate.commentary ?? '';
            _controllerDesc.text = estimate.description ?? '';
            _controllerPrice.text = estimate.price.toString();
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
                    () {},
                    () {},
                  ),
                  const SizedBox(height: AppUIValue.spaceScreenToAny * 2),
                  Center(
                    child: Text(
                      estimate.workRequest?.title ?? AppText.noTitleForWork,
                      style: getTextStyleMainColor(AppUIValue.sizeFontTitle),
                    ),
                  ),
                  const SizedBox(height: AppUIValue.spaceScreenToAny * 2),
                  TextField(
                    controller: _controllerPrice,
                    decoration: textFieldMainDeco(AppText.createEstimatePrice),
                    onChanged: (value) {
                      try {
                        final price = double.parse(value);
                        estimate.price = price;
                      } catch (e) {
                        estimate.price = -1;
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
                      estimate.description = value;
                    },
                    minLines: 5,
                    maxLines: 13,
                  ),
                  const SizedBox(height: AppUIValue.spaceScreenToAny * 2),
                  TextField(
                    controller: _controllerCommentary,
                    decoration: textFieldMainDeco(AppText.commentary),
                    onChanged: (value) {
                      estimate.commentary = value;
                    },
                    minLines: 5,
                    maxLines: 13,
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: rowBottomBar(
        context,
        () {},
        () {},
      ),
    );
  }
}
