import 'package:flutter/material.dart';
import 'package:front_syndic/models/appartment/appartment.dart';
import 'package:front_syndic/models/user/createUser.dart';

import '../../../api_handler/email/check_email_is_unique.dart';
import '../../../color.dart';
import '../../../core_value.dart';
import '../../../text/fr.dart';
import '../../../utils/email/check_email.dart';
import '../../../widget/button/elevated_button_opacity.dart';
import '../../../widget/decoration/text_filed_deco_no_counter.dart';
import '../../../widget/header/app_bar_back_button.dart';
import '../../../widget/text_format_input_textfield/customSpaceFormatter.dart';
import '../../../widget/visibility/error.dart';

class ChoseNameUser extends StatefulWidget {
  const ChoseNameUser({
    super.key,
    required this.createUser,
  });

  final CreateUser createUser;

  @override
  State<ChoseNameUser> createState() => _ChoseNameUserState();
}

class _ChoseNameUserState extends State<ChoseNameUser> {

  TextEditingController? _firstNameController;
  TextEditingController? _nameController;
  TextEditingController? _mailController;
  TextEditingController? _phoneController;

  bool errorVisibility = false;
  String errorText = AppText.adressCreationError;

  @override
  void initState(){
    super.initState();
    _nameController = TextEditingController(text: widget.createUser.user.name ?? '');
    _firstNameController = TextEditingController(text: widget.createUser.user.firstName ?? '');
    _mailController = TextEditingController(text: widget.createUser.email ?? '');
    _phoneController = TextEditingController(text: widget.createUser.user.phone ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBackButton(context, title: AppText.unionClientName),
      body: Padding(
        padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration : roundBorderTextFieldWithoutCounter(AppText.name),
              onChanged: (value) {
                widget.createUser.user.name = value;
              },
              maxLength: 50,
              maxLines: 1,
            ),
            const SizedBox(height: AppUIValue.spaceScreenToAny),
            TextField(
              controller: _firstNameController,
              decoration : roundBorderTextFieldWithoutCounter(AppText.firstName),
              onChanged: (value) {
                widget.createUser.user.firstName = value;
              },
              maxLength: 50,
              maxLines: 1,
            ),
            const SizedBox(height: AppUIValue.spaceScreenToAny),
            TextField(
              controller: _mailController,
              decoration : roundBorderTextFieldWithoutCounter(AppText.email),
              onChanged: (value) {
                widget.createUser.email = value;
              },
              maxLength: 50,
              maxLines: 1,
            ),
            const SizedBox(height: AppUIValue.spaceScreenToAny),
            TextField(
              controller: _phoneController,
              decoration : roundBorderTextFieldWithoutCounter(AppText.phoneCouncil),
              inputFormatters: [CustomCharacterSpaceFormatter(interval: 2)],
              onChanged: (value) {
                widget.createUser.user.phone = value;
              },
              maxLength: 50,
              maxLines: 1,
              keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
            ),
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
    );
  }

  void save()async{
    if(widget.createUser.user.phone == null || widget.createUser.user.phone == '' || widget.createUser.user.firstName == '' || widget.createUser.user.firstName == null ||  widget.createUser.user.name == null || widget.createUser.user.firstName == '' || widget.createUser.email == null || widget.createUser.email == '' || widget.createUser.email == null){
      setState(() {
        errorVisibility = true;
      });
    }
    else if(!isValidEmail(widget.createUser.email!)){
      setState(() {
        errorText = AppText.emailFormatError;
        errorVisibility = true;
      });
      return;
    }
    final emailIsUnique = await isEmailUnique(widget.createUser.email!, (){
      setState(() {
        errorText = AppText.emailAlreadyExist;
        errorVisibility = true;
      });
    });
    if(!emailIsUnique){
      return;
    }
    setState(() {
      errorVisibility = false;
    });
    Navigator.pushNamed(context, '/union/create_user/adress', arguments: widget.createUser);
  }
}
