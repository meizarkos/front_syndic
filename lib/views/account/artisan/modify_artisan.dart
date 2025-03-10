import 'package:flutter/material.dart';
import 'package:front_syndic/api_handler/artisan/get_artisan.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/artisan/artisan.dart';
import 'package:front_syndic/widget/button/elevated_button_opacity.dart';
import 'package:front_syndic/widget/decoration/text_filed_deco_no_counter.dart';
import 'package:front_syndic/widget/text_format_input_textfield/customSpaceFormatter.dart';
import 'package:front_syndic/widget/visibility/error.dart';

import '../../../api_handler/artisan/update_artisan.dart';
import '../../../text/fr.dart';
import '../../../widget/header/app_bar_back_button.dart';

class ModifyArtisan extends StatefulWidget {
  const ModifyArtisan({super.key});

  @override
  State<ModifyArtisan> createState() => _ModifyArtisanState();
}

class _ModifyArtisanState extends State<ModifyArtisan> {

  Artisan artisanStatic = Artisan();

  String errorText = AppText.recapError;
  bool errorVisibility = false;
  bool successVisibility = false;
  bool apiErrorVisibility = false;

  TextEditingController companyNameController = TextEditingController();
  TextEditingController siretNumberController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getArtisan().then((value) {
      if(value == null){
        setState(() {
          apiErrorVisibility = true;
        });
        return;
      }
      setState(() {
        artisanStatic = value;
        companyNameController.text = value.companyName ?? '';
        siretNumberController.text = value.siretNumber ?? '';
        firstNameController.text = value.firstName ?? '';
        lastNameController.text = value.lastName ?? '';
        phoneController.text = value.phone ?? '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : appBarBackButton(context, title : AppText.myData),
      body: Column(
        children: [
          ErrorVisibility(errorVisibility: apiErrorVisibility, errorText: AppText.apiErrorText),
          Padding(
            padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppUIValue.spaceScreenToAny),
                TextField(
                  controller: companyNameController,
                  decoration: roundBorderTextFieldWithoutCounter(AppText.companyName),
                  onChanged: (value) {
                    artisanStatic.companyName = value;
                  },
                  maxLength: 50,
                ),
                const SizedBox(height: AppUIValue.spaceScreenToAny),
                TextField(
                  controller: siretNumberController,
                  decoration: roundBorderTextFieldWithoutCounter(AppText.siretNumber),
                  onChanged: (value) {
                    artisanStatic.siretNumber = value;
                  },
                  inputFormatters: [
                    CustomCharacterSpaceFormatter(interval: 4),
                  ],
                  maxLength: 17,
                  maxLines: 1,
                ),
                const SizedBox(height: AppUIValue.spaceScreenToAny),
                TextField(
                  controller: firstNameController,
                  decoration: roundBorderTextFieldWithoutCounter(AppText.firstName),
                  onChanged: (value) {
                    artisanStatic.firstName = value;
                  },
                  maxLength: 50,
                ),
                const SizedBox(height: AppUIValue.spaceScreenToAny),
                TextField(
                  controller: lastNameController,
                  decoration: roundBorderTextFieldWithoutCounter(AppText.name),
                  onChanged: (value) {
                    artisanStatic.lastName = value;
                  },
                  maxLength: 50,
                ),
                const SizedBox(height: AppUIValue.spaceScreenToAny),
                TextField(
                  controller: phoneController,
                  decoration: roundBorderTextFieldWithoutCounter(AppText.phone),
                  onChanged: (value) {
                    artisanStatic.phone = value;
                  },
                  maxLength: 20,
                  maxLines: 1,
                ),
                const SizedBox(height: AppUIValue.spaceScreenToAny),
                ErrorVisibility(errorVisibility: errorVisibility, errorText: errorText),
                ErrorVisibility(errorVisibility: successVisibility, errorText: AppText.successfulModify,color: Colors.green,),
                const SizedBox(height: AppUIValue.spaceScreenToAny),
                Center(
                  child: elevatedButtonAndTextColor(
                   AppColors.mainBackgroundColor,
                      AppText.save,
                      context,
                      ()async => await updateArtisan(),
                      AppColors.mainTextColor
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> updateArtisan()async {
    if(
      artisanStatic.companyName == null || artisanStatic.companyName == '' ||
      artisanStatic.siretNumber == null || artisanStatic.siretNumber == '' ||
      artisanStatic.firstName == null || artisanStatic.firstName == '' ||
      artisanStatic.lastName == null || artisanStatic.lastName == '' ||
      artisanStatic.phone == null || artisanStatic.phone == ''
    ){
      setState(() {
        errorText = AppText.recapError;
        successVisibility = false;
        errorVisibility = true;
      });
      return;
    }
    artisanStatic.siretNumber = artisanStatic.siretNumber!.replaceAll(' ', '');
    if(artisanStatic.siretNumber!.length != 14){
      setState(() {
        errorText = AppText.siretNumberWrongSize;
        successVisibility = false;
        errorVisibility = true;
      });
      return;
    }
    setState(() {
      errorVisibility = false;
      successVisibility = true;
    });
    await updateArtisanApi(artisanStatic);
  }
}
