import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/appartment/appartment.dart';
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
    this.apartmentUuid,
    this.showAppBar = true,
  });

  final Future<Apartment?> Function(String?) fetchData;
  final Future<void> Function(String?,User) patchData;
  final String? apartmentUuid;
  final bool showAppBar;

  @override
  State<ModifyUser > createState() => _ModifyUserState();
}

class _ModifyUserState extends State<ModifyUser > {

  Apartment apartmentStatic = Apartment();

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
    widget.fetchData(widget.apartmentUuid).then((value) {
      if(value == null || value.uuid == null){
        setState(() {
          apiErrorVisibility = true;
        });
        return;
      }
      setState(() {
        apartmentStatic = value;
        nameController.text = value.user?.name ?? '';
        firstNameController.text = value.user?.firstName ?? '';
        phoneController.text = value.user?.phone ?? '';
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
                      apartmentStatic.user?.name = value;
                    },
                    maxLength: 50,
                  ),
                  const SizedBox(height: AppUIValue.spaceScreenToAny),
                  TextField(
                    controller: firstNameController,
                    decoration: roundBorderTextFieldWithoutCounter(AppText.firstName),
                    onChanged: (value) {
                      apartmentStatic.user?.firstName = value;
                    },
                    maxLength: 50,
                  ),
                  const SizedBox(height: AppUIValue.spaceScreenToAny),
                  TextField(
                    controller: phoneController,
                    decoration: roundBorderTextFieldWithoutCounter(AppText.phone),
                    inputFormatters: [CustomCharacterSpaceFormatter(interval: 2)],
                    onChanged: (value) {
                      apartmentStatic.user?.phone = value;
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
    apartmentStatic.user?.name == null || apartmentStatic.user?.name == '' ||
        apartmentStatic.user?.firstName == null || apartmentStatic.user?.firstName == '' ||
        apartmentStatic.user?.phone == null || apartmentStatic.user?.phone == ''
    ){
      setState(() {
        errorText = AppText.recapError;
        successVisibility = false;
        errorVisibility = true;
      });
      return;
    }
    apartmentStatic.user?.phone = phoneController.text.replaceAll(' ', '');
    setState(() {
      errorVisibility = false;
      successVisibility = true;
    });
    if(apartmentStatic.user == null){
      return;
    }
    await widget.patchData(widget.apartmentUuid,apartmentStatic.user!);
  }
}
