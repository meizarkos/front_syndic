import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/widget/button/elevated_button_opacity.dart';
import 'package:front_syndic/widget/visibility/error.dart';

import '../../../core_value.dart';
import '../../../models/estimate/estimate.dart';
import '../../../text/fr.dart';
import '../../../widget/decoration/text_field_deco_main.dart';
import '../../../widget/decoration/text_filed_deco_no_counter.dart';
import '../../../widget/header/app_bar_back_button.dart';

class SetPriceAndCommentary extends StatefulWidget {
  const SetPriceAndCommentary({
    super.key,
    required this.estimate,
  });

  final Estimate estimate;

  @override
  State<SetPriceAndCommentary> createState() => _SetPriceAndCommentaryState();
}

class _SetPriceAndCommentaryState extends State<SetPriceAndCommentary> {

  double price = -1;
  String commentary = '';
  TextEditingController? _priceController;
  TextEditingController? _commentaryController;
  bool errorVisibility = false;

  @override
  initState() {
    super.initState();
    price = widget.estimate.price ?? -1;
    _priceController = TextEditingController(
      text: widget.estimate.price != null && widget.estimate.price! >= 0
          ? widget.estimate.price!.toString()
          : '',
    );
    commentary = widget.estimate.commentary ?? '';
    _commentaryController = TextEditingController(
      text: widget.estimate.commentary ?? '',
    );
  }

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
                    controller: _priceController,
                    decoration : roundBorderTextFieldWithoutCounter(AppText.createEstimatePricePlaceHolder),
                    onChanged: (value) {
                      try{
                        price = double.parse(value);
                      }
                      catch(e){
                        price = -1;
                        return;
                      }
                    },
                    maxLength: 10,
                    maxLines: 1,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                  ),
                  const SizedBox(height: AppUIValue.spaceScreenToAny),
                  TextField(
                    controller: _commentaryController,
                    decoration : textFieldMainDeco(AppText.createEstimateCommentaryPlaceHolder),
                    onChanged: (value) {
                      commentary = value;
                    },
                    maxLength: 1280,
                    maxLines: 10,
                  ),
                  const SizedBox(height: AppUIValue.spaceScreenToAny),
                  ErrorVisibility(errorVisibility: errorVisibility, errorText: AppText.createTitleWorkErrorText),
                  const SizedBox(height: AppUIValue.spaceScreenToAny),
                  Center(
                    child: elevatedButtonAndTextColor(
                        AppColors.mainBackgroundColor,
                        AppText.save,
                        context,
                        ()=>_save(),
                        AppColors.mainTextColor
                    ),
                  )
                ],
              ),
          ),
        ),
    );
  }

  void _save(){
    if(price == -1 || price<0){
      setState(() {
        errorVisibility = true;
      });
    } else {
      widget.estimate.price = price;
      widget.estimate.commentary = commentary;
      Navigator.pushNamed(context, '/artisan/create_estimate/recap', arguments: widget.estimate);
    }
  }
}
