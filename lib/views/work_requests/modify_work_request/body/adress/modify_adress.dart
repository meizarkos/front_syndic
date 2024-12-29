import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/widget/button/elevated_button_opacity.dart';
import 'package:front_syndic/widget/visibility/error.dart';

import '../../../../../models/adress/adress.dart';
import '../../../../../text/fr.dart';
import '../../../../../widget/decoration/text_filed_deco_no_counter.dart';

class ChoseAdressPatchWorkRequest extends StatefulWidget {
  const ChoseAdressPatchWorkRequest({
    super.key,
    required this.onRegister,
    required this.fetchAdress,
    required this.workRequestUuid,
  });

  final Future<void> Function(String,Adress) onRegister;
  final Future<Adress> Function(String) fetchAdress;
  final String workRequestUuid;

  @override
  State<ChoseAdressPatchWorkRequest> createState() => _ChoseAdressPatchWorkRequestState();
}

class _ChoseAdressPatchWorkRequestState extends State<ChoseAdressPatchWorkRequest> {

  TextEditingController? _cityController, _streetController, _countryController,
      _postalCodeController,_regionController,_commentController;

  bool errorVisibility = false;
  bool successVisibility = false;

  Adress adress = Adress();

  @override
  void initState(){
    super.initState();
    widget.fetchAdress(widget.workRequestUuid).then((adressApi) {
      setState(() {
        adress = adressApi;
        _cityController = TextEditingController(text: adress.city);
        _streetController = TextEditingController(text: adress.street);
        _countryController = TextEditingController(text: adress.country);
        _postalCodeController = TextEditingController(text: adress.postalCode);
        _regionController = TextEditingController(text: adress.region);
        _commentController = TextEditingController(text: adress.comment);
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
          child: Column(
            children: [
              TextField(
                controller: _countryController,
                decoration : roundBorderTextFieldWithoutCounter(AppText.choseCountry),
                onChanged: (value) {
                  adress.country = value;
                },
                maxLength: 50,
                maxLines: 1,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              TextField(
                controller: _regionController,
                decoration : roundBorderTextFieldWithoutCounter(AppText.region),
                onChanged: (value) {
                  adress.region = value;
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
                        adress.postalCode = value;
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
                        adress.city = value;
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
                  adress.street = value;
                },
                maxLength: 50,
                maxLines: 1,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              TextField(
                controller: _commentController,
                decoration : roundBorderTextFieldWithoutCounter(AppText.comment),
                onChanged: (value) {
                  adress.comment = value;
                },
                maxLength: 200,
                maxLines: 3,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              ErrorVisibility(errorVisibility: errorVisibility, errorText: AppText.adressCreationError),
              ErrorVisibility(errorVisibility: successVisibility, errorText: AppText.recapSuccessModifying,color: Colors.green),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              elevatedButtonAndTextColor(
                AppColors.mainBackgroundColor,
                AppText.save,
                context,
                    (){
                  if(_regionController!.text.isEmpty || _countryController!.text.isEmpty || _postalCodeController!.text.isEmpty || _cityController!.text.isEmpty || _streetController!.text.isEmpty){
                    setState(() {
                      successVisibility = false;
                      errorVisibility = true;
                    });
                  }else{
                    if(_commentController!.text.isEmpty){
                      adress.comment = null;
                    }
                    setState(() {
                      errorVisibility = false;
                      successVisibility = true;
                    });
                    widget.onRegister(widget.workRequestUuid,adress);
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

