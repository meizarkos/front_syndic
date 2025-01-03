import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/co_owner/co_owner.dart';
import 'package:front_syndic/widget/button/elevated_button_opacity.dart';
import 'package:front_syndic/widget/decoration/text_filed_deco_no_counter.dart';
import 'package:front_syndic/widget/visibility/error.dart';

import '../../../api_handler/co_owner/get_co_owner.dart';
import '../../../api_handler/co_owner/patch_co_owner.dart';
import '../../../text/fr.dart';
import '../../../widget/header/app_bar_back_button.dart';

class ModifyCouncil extends StatefulWidget {
  const ModifyCouncil ({super.key});

  @override
  State<ModifyCouncil > createState() => _ModifyCouncilState();
}

class _ModifyCouncilState extends State<ModifyCouncil > {

  CoOwner coOwnerStatic = CoOwner();

  String errorText = AppText.recapError;
  bool errorVisibility = false;
  bool successVisibility = false;
  bool apiErrorVisibility = false;

  TextEditingController councilNameController = TextEditingController();
  TextEditingController lotSizeController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCoOwner().then((value) {
      if(value == null || value.council == null){
        setState(() {
          apiErrorVisibility = true;
        });
        return;
      }
      setState(() {
        coOwnerStatic = value;
        councilNameController.text = value.name ?? '';
        lotSizeController.text = value.lotSize.toString() ?? '';
        firstNameController.text = value.council?.firstName ?? '';
        lastNameController.text = value.council?.lastName ?? '';
        phoneController.text = value.council?.phone ?? '';
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
                  controller: councilNameController,
                  decoration: roundBorderTextFieldWithoutCounter(AppText.coOwnerName),
                  onChanged: (value) {
                    coOwnerStatic.name = value;
                  },
                  maxLength: 50,
                ),
                const SizedBox(height: AppUIValue.spaceScreenToAny),
                TextField(
                  controller: lotSizeController,
                  decoration: roundBorderTextFieldWithoutCounter(AppText.lotSize),
                  onChanged: (value) {
                    try{
                      coOwnerStatic.lotSize = int.parse(value);
                    }
                    catch(e){
                      coOwnerStatic.lotSize = -1;
                    }
                  },
                  maxLines: 1,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: AppUIValue.spaceScreenToAny),
                TextField(
                  controller: firstNameController,
                  decoration: roundBorderTextFieldWithoutCounter(AppText.firstName),
                  onChanged: (value) {
                    coOwnerStatic.council?.firstName = value;
                  },
                  maxLength: 50,
                ),
                const SizedBox(height: AppUIValue.spaceScreenToAny),
                TextField(
                  controller: lastNameController,
                  decoration: roundBorderTextFieldWithoutCounter(AppText.name),
                  onChanged: (value) {
                    coOwnerStatic.council?.lastName = value;
                  },
                  maxLength: 50,
                ),
                const SizedBox(height: AppUIValue.spaceScreenToAny),
                TextField(
                  controller: phoneController,
                  decoration: roundBorderTextFieldWithoutCounter(AppText.phone),
                  onChanged: (value) {
                    coOwnerStatic.council?.phone = value;
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
    coOwnerStatic.name == null || coOwnerStatic.name == '' ||
        coOwnerStatic.lotSize == null ||
        coOwnerStatic.council?.firstName == null || coOwnerStatic.council?.firstName == '' ||
        coOwnerStatic.council?.lastName == null || coOwnerStatic.council?.lastName == '' ||
        coOwnerStatic.council?.phone == null || coOwnerStatic.council?.phone == ''
    ){
      setState(() {
        errorText = AppText.recapError;
        successVisibility = false;
        errorVisibility = true;
      });
      return;
    }
    else if(coOwnerStatic.lotSize == -1){
      setState(() {
        errorText = AppText.wrongInt;
        successVisibility = false;
        errorVisibility = true;
      });
      return;
    }
    setState(() {
      errorVisibility = false;
      successVisibility = true;
    });
    await patchCoOwner(coOwnerStatic);
  }
}
