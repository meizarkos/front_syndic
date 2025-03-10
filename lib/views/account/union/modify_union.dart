import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/union/union.dart';
import 'package:front_syndic/widget/button/elevated_button_opacity.dart';
import 'package:front_syndic/widget/decoration/text_filed_deco_no_counter.dart';
import 'package:front_syndic/widget/visibility/error.dart';

import '../../../../text/fr.dart';
import '../../../../widget/header/app_bar_back_button.dart';
import '../../../api_handler/union/get_union.dart';
import '../../../api_handler/union/patch_union.dart';
import '../../../widget/text_format_input_textfield/customSpaceFormatter.dart';

class ModifyUnion extends StatefulWidget {
  const ModifyUnion ({
    super.key,
  });

  @override
  State<ModifyUnion > createState() => _ModifyUnionState();
}

class _ModifyUnionState extends State<ModifyUnion > {

  UnionApi unionStatic = UnionApi();
  String siretDefault = '';

  String errorText = AppText.recapError;
  bool errorVisibility = false;
  bool successVisibility = false;
  bool apiErrorVisibility = false;

  TextEditingController unionNameController = TextEditingController();
  TextEditingController siretNumberController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUnion().then((value) {
      setState(() {
        if(value == null){
          apiErrorVisibility = true;
          return;
        }
        unionStatic = value;
        siretDefault = value.siretNumber ?? '';
        unionNameController.text = value.name ?? '';
        siretNumberController.text = value.siretNumber ?? '';
        firstNameController.text = value.administratorFirstName ?? '';
        lastNameController.text = value.administratorName ?? '';
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
                  controller: unionNameController,
                  decoration: roundBorderTextFieldWithoutCounter(AppText.unionName),
                  onChanged: (value) {
                    unionStatic.name = value;
                  },
                  maxLength: 50,
                ),
                const SizedBox(height: AppUIValue.spaceScreenToAny),
                TextField(
                  controller: siretNumberController,
                  decoration: roundBorderTextFieldWithoutCounter(AppText.siretNumber),
                  onChanged: (value) {
                    unionStatic.siretNumber = value;
                  },
                  maxLines: 1,
                  maxLength: 17,
                  inputFormatters: [CustomCharacterSpaceFormatter(interval: 4),],
                ),
                const SizedBox(height: AppUIValue.spaceScreenToAny),
                TextField(
                  controller: firstNameController,
                  decoration: roundBorderTextFieldWithoutCounter(AppText.firstName),
                  onChanged: (value) {
                    unionStatic.administratorFirstName = value;
                  },
                  maxLength: 50,
                ),
                const SizedBox(height: AppUIValue.spaceScreenToAny),
                TextField(
                  controller: lastNameController,
                  decoration: roundBorderTextFieldWithoutCounter(AppText.name),
                  onChanged: (value) {
                    unionStatic.administratorName = value;
                  },
                  maxLength: 50,
                ),
                const SizedBox(height: AppUIValue.spaceScreenToAny),
                TextField(
                  controller: phoneController,
                  decoration: roundBorderTextFieldWithoutCounter(AppText.phone),
                  onChanged: (value) {
                    unionStatic.phone = value;
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
                          ()async => await updateUnion(),
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

  Future<void> updateUnion()async {
    unionStatic.siretNumber = unionStatic.siretNumber?.replaceAll(' ', '');
    if(
    unionStatic.name == null || unionStatic.name == '' ||
        unionStatic.siretNumber == null || unionStatic.siretNumber == '' ||
        unionStatic.administratorName == null || unionStatic.administratorName == '' ||
        unionStatic.administratorFirstName == null || unionStatic.administratorFirstName == '' ||
        unionStatic.phone == null || unionStatic.phone == ''
    ){
      setState(() {
        errorText = AppText.recapError;
        successVisibility = false;
        errorVisibility = true;
      });
      return;
    }
    else if(unionStatic.siretNumber!.length != 14){
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
    await patchUnion(unionStatic);
  }
}
