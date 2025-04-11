import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/widget/button/elevated_button_opacity.dart';
import 'package:front_syndic/widget/decoration/text_filed_deco_no_counter.dart';
import 'package:front_syndic/widget/visibility/error.dart';

import '../../../../text/fr.dart';
import '../../../../widget/header/app_bar_back_button.dart';
import '../../../models/user/user.dart';
import '../../../widget/text_format_input_textfield/customSpaceFormatter.dart';

class ModifyUser extends StatefulWidget {
  const ModifyUser ({
    super.key,
    required this.fetchData,
    required this.patchData,
    this.userUuid,
    this.showAppBar = true,
  });

  final Future<User?> Function(String?) fetchData;
  final Future<void> Function(String?,User) patchData;
  final String? userUuid;
  final bool showAppBar;

  @override
  State<ModifyUser > createState() => _ModifyUserState();
}

class _ModifyUserState extends State<ModifyUser > {

  User userStatic = User();

  String errorText = AppText.recapError;
  bool errorVisibility = false;
  bool successVisibility = false;
  bool apiErrorVisibility = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.fetchData(widget.userUuid).then((value) {
      if(value == null || value.uuid == null){
        setState(() {
          apiErrorVisibility = true;
        });
        return;
      }
      setState(() {
        userStatic = value;
        nameController.text = userStatic.name ?? '';
        firstNameController.text = userStatic.firstName ?? '';
        phoneController.text = userStatic.phone ?? '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : widget.showAppBar ? appBarBackButton(context, title : AppText.myData) : null,
      body: SingleChildScrollView(
        child: Column(
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
                    controller: nameController,
                    decoration: roundBorderTextFieldWithoutCounter(AppText.name),
                    onChanged: (value) {
                      userStatic.name = value;
                    },
                    maxLength: 50,
                  ),
                  const SizedBox(height: AppUIValue.spaceScreenToAny),
                  TextField(
                    controller: firstNameController,
                    decoration: roundBorderTextFieldWithoutCounter(AppText.firstName),
                    onChanged: (value) {
                      userStatic.firstName = value;
                    },
                    maxLength: 50,
                  ),
                  const SizedBox(height: AppUIValue.spaceScreenToAny),
                  TextField(
                    controller: phoneController,
                    decoration: roundBorderTextFieldWithoutCounter(AppText.phone),
                    inputFormatters: [CustomCharacterSpaceFormatter(interval: 2)],
                    onChanged: (value) {
                      userStatic.phone = value;
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
                            ()async => await updateApartment(),
                        AppColors.mainTextColor
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> updateApartment()async {
    if(
    userStatic.name == null || userStatic.name == '' ||
        userStatic.firstName == null || userStatic.firstName == '' ||
        userStatic.phone == null || userStatic.phone == ''
    ){
      setState(() {
        errorText = AppText.recapError;
        successVisibility = false;
        errorVisibility = true;
      });
      return;
    }
    userStatic.phone = phoneController.text.replaceAll(' ', '');
    setState(() {
      errorVisibility = false;
      successVisibility = true;
    });
    await widget.patchData(widget.userUuid,userStatic);
  }
}
