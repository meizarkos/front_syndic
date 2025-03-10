import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/text/fr.dart';
import 'package:front_syndic/widget/button/elevated_button_opacity.dart';
import 'package:front_syndic/widget/header/app_bar_back_button.dart';
import 'package:front_syndic/widget/visibility/error.dart';

import '../../../../models/artisan/createArtisan.dart';
import '../../../../widget/decoration/text_filed_deco_no_counter.dart';
import '../../../../widget/text_format_input_textfield/customSpaceFormatter.dart';

class ArtisanInfo extends StatefulWidget {
  const ArtisanInfo({
    super.key,
    required this.createArtisan,
  });

  final CreateArtisan createArtisan;

  @override
  State<ArtisanInfo> createState() => _ArtisanInfoState();
}

class _ArtisanInfoState extends State<ArtisanInfo> {

  TextEditingController? _companyNameController;
  TextEditingController? _phoneController;
  TextEditingController? _firstNameController;
  TextEditingController? _lastNameController;
  TextEditingController? _siretNumberController;

  bool errorVisibility = false;
  String errorText = AppText.createTitleWorkErrorText;

  @override
  void initState(){
    super.initState();
    _companyNameController = TextEditingController(text: widget.createArtisan.artisan.companyName);
    _phoneController = TextEditingController(text: widget.createArtisan.artisan.phone);
    _firstNameController = TextEditingController(text: widget.createArtisan.artisan.firstName);
    _lastNameController = TextEditingController(text: widget.createArtisan.artisan.lastName);
    _siretNumberController = TextEditingController(text: widget.createArtisan.artisan.siretNumber);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBackButton(context,title: AppText.unionInfo),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppUIValue.spaceScreenToAny),
          child: Column(
            children: [
              TextField(
                controller: _companyNameController,
                decoration: roundBorderTextFieldWithoutCounter(AppText.companyName),
                onChanged: (value) {
                  widget.createArtisan.artisan.companyName = value;
                },
                maxLength: 50,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              TextField(
                controller: _firstNameController,
                decoration: roundBorderTextFieldWithoutCounter(AppText.unionFirstName),
                onChanged: (value) {
                  widget.createArtisan.artisan.firstName = value;
                },
                maxLength: 50,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              TextField(
                controller: _lastNameController,
                decoration: roundBorderTextFieldWithoutCounter(AppText.unionLastName),
                onChanged: (value) {
                  widget.createArtisan.artisan.lastName = value;
                },
                maxLength: 50,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              TextField(
                controller: _phoneController,
                decoration: roundBorderTextFieldWithoutCounter(AppText.unionPhone),
                inputFormatters: [CustomCharacterSpaceFormatter(interval: 2)],
                onChanged: (value) {
                  widget.createArtisan.artisan.phone = value;
                },
                maxLength: 50,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              TextField(
                controller: _siretNumberController,
                decoration: roundBorderTextFieldWithoutCounter(AppText.unionSiret),
                inputFormatters: [CustomCharacterSpaceFormatter(interval: 4)],
                onChanged: (value) {
                  widget.createArtisan.artisan.siretNumber = value;
                },
                maxLength: 17,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              ErrorVisibility(errorVisibility: errorVisibility, errorText: errorText),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              elevatedButtonAndTextColor(
                  AppColors.mainBackgroundColor,
                  AppText.save,
                  context,
                  save,
                  AppColors.mainTextColor
              ),
            ],
          ),
        ),
      ),
    );
  }

  void save(){
    final artisan = widget.createArtisan.artisan;

    if(artisan.companyName != null && artisan.firstName != null && artisan.lastName != null && artisan.phone != null && artisan.siretNumber != null &&
        artisan.companyName != '' && artisan.firstName != '' && artisan.lastName != ''  && artisan.phone != ''  && artisan.siretNumber != '' ){

      widget.createArtisan.artisan.siretNumber = artisan.siretNumber!.replaceAll(' ', '');
      widget.createArtisan.artisan.phone = artisan.phone!.replaceAll(' ', '');

      if(artisan.siretNumber!.length != 14){
        setState(() {
          errorText = AppText.siretNumberWrongSize;
          errorVisibility = true;
        });
        return;
      }

      setState(() {
        errorVisibility = false;
      });
      Navigator.pushNamed(context,'/artisan/bank_info', arguments: widget.createArtisan);
    } else {
      setState(() {
        errorText = AppText.createTitleWorkErrorText;
        errorVisibility = true;
      });
    }
  }
}

