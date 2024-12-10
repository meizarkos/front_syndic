import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/widget/button/elevated_button_opacity.dart';
import 'package:front_syndic/widget/header/app_bar_back_button.dart';
import 'package:front_syndic/widget/visibility/error.dart';

import '../../../../models/adress/adress.dart';
import '../../../../text/fr.dart';
import '../../../../widget/decoration/text_filed_deco_no_counter.dart';

class ChoseAdress extends StatefulWidget {
  const ChoseAdress({
    super.key,
    required this.onRegister,
    required this.adress,
  });

  final Function onRegister;
  final Adress adress;

  @override
  State<ChoseAdress> createState() => _ChoseAdressState();
}

class _ChoseAdressState extends State<ChoseAdress> {

  TextEditingController? _cityController, _streetController, _countryController,
      _postalCodeController,_regionController,_commentController;

  bool errorVisibility = false;

  @override
  void initState(){
    super.initState();
    _cityController = TextEditingController(text: widget.adress.city);
    _streetController = TextEditingController(text: widget.adress.street);
    _countryController = TextEditingController(text: widget.adress.country);
    _postalCodeController = TextEditingController(text: widget.adress.postalCode);
    _regionController = TextEditingController(text: widget.adress.region);
    _commentController = TextEditingController(text: widget.adress.comment);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBackButton(context,title: AppText.choseAdress),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
          child: Column(
            children: [
              TextField(
                controller: _countryController,
                decoration : roundBorderTextFieldWithoutCounter(AppText.choseCountry),
                onChanged: (value) {
                  widget.adress.country = value;
                },
                maxLength: 50,
                maxLines: 1,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              TextField(
                controller: _regionController,
                decoration : roundBorderTextFieldWithoutCounter(AppText.region),
                onChanged: (value) {
                  widget.adress.region = value;
                },
                maxLength: 50,
                maxLines: 1,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _postalCodeController,
                      decoration : roundBorderTextFieldWithoutCounter(AppText.postalCode),
                      onChanged: (value) {
                        widget.adress.postalCode = value;
                      },
                      maxLength: 15,
                      maxLines: 1,
                      keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
                    ),
                  ),
                  const SizedBox(width: AppUIValue.spaceScreenToAny),
                  Expanded(
                    child: TextField(
                      controller: _cityController,
                      decoration : roundBorderTextFieldWithoutCounter(AppText.city),
                      onChanged: (value) {
                        widget.adress.city = value;
                      },
                      maxLength: 50,
                      maxLines: 1,
                    ),
                  )
                ],
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              TextField(
                controller: _streetController,
                decoration : roundBorderTextFieldWithoutCounter(AppText.street),
                onChanged: (value) {
                  widget.adress.street = value;
                },
                maxLength: 50,
                maxLines: 1,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              TextField(
                controller: _commentController,
                decoration : roundBorderTextFieldWithoutCounter(AppText.comment),
                onChanged: (value) {
                  widget.adress.comment = value;
                },
                maxLength: 200,
                maxLines: 3,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              ErrorVisibility(errorVisibility: errorVisibility, errorText: AppText.adressCreationError),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              elevatedButtonAndTextColor(
               AppColors.mainBackgroundColor,
                  AppText.save,
                  context,
                  () {
                    if(_regionController!.text.isEmpty || _countryController!.text.isEmpty || _postalCodeController!.text.isEmpty || _cityController!.text.isEmpty || _streetController!.text.isEmpty){
                      setState(() {
                        errorVisibility = true;
                      });
                    }else{
                      widget.onRegister();
                    }
                  },
                  AppColors.mainTextColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

