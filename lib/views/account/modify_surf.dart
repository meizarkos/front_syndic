import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/widget/button/elevated_button_opacity.dart';
import 'package:front_syndic/widget/header/app_bar_back_button.dart';
import 'package:front_syndic/widget/visibility/error.dart';

import '../../api_handler/email/check_email_is_unique.dart';
import '../../core_value.dart';
import '../../models/surf/surf.dart';
import '../../text/fr.dart';
import '../../widget/decoration/text_filed_deco_no_counter.dart';

class ModifySurf extends StatefulWidget {
  const ModifySurf({
    super.key,
    required this.fetchSurf,
    required this.patchSurf,
  });

  final Future<void> Function(Surf) patchSurf;
  final Future<String?> Function() fetchSurf;


  @override
  State<ModifySurf> createState() => _ModifySurfState();
}

class _ModifySurfState extends State<ModifySurf> {

  Surf surf = Surf(email: '', passwd: '');

  TextEditingController emailController = TextEditingController();
  TextEditingController passwdController = TextEditingController();
  TextEditingController confirmPasswdController = TextEditingController();
  bool errorVisibility = false;
  bool successVisibility = false;
  String errorText = AppText.emailCantBeEmpty;

  @override
  void initState() {
    super.initState();
    widget.fetchSurf().then((value)=>{
      setState(() {
        surf.email = value ?? '';
        emailController.text = value ?? '';
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBackButton(context,title: AppText.myLogin),
      body: Padding(
        padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppUIValue.spaceScreenToAny),
            TextField(
              controller: emailController,
              decoration: roundBorderTextFieldWithoutCounter(AppText.email),
              onChanged: (value) {
                surf.email = value;
              },
              maxLength: 128,
            ),
            const SizedBox(height: AppUIValue.spaceScreenToAny),
            TextField(
              controller: passwdController,
              decoration: roundBorderTextFieldWithoutCounter(AppText.loginLabelTextPassword),
              maxLength: 128,
              obscureText: true,
            ),
            const SizedBox(height: AppUIValue.spaceScreenToAny),
            TextField(
              controller: confirmPasswdController,
              decoration: roundBorderTextFieldWithoutCounter(AppText.confirmPasswd),
              maxLength: 128,
              obscureText: true,
            ),
            const SizedBox(height: AppUIValue.spaceScreenToAny),
            ErrorVisibility(errorVisibility: errorVisibility, errorText: errorText),
            ErrorVisibility(errorVisibility: successVisibility, errorText: errorText, color: Colors.green),
            const SizedBox(height: AppUIValue.spaceScreenToAny),
            Center(
              child: elevatedButtonAndTextColor(
               AppColors.mainBackgroundColor,
                  AppText.save,
                  context,
                  ()async => await onRegister(),
                  AppColors.mainTextColor
              ),
            ),
          ]

        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',);

    return emailRegExp.hasMatch(email);
  }

  Future<void> onRegister()async{
    surf.passwd = passwdController.text;
    if(passwdController.text != '' && confirmPasswdController.text == passwdController.text){
      final email = await widget.fetchSurf();
      if(email == surf.email){
        setState(() {
          errorVisibility = false;
          successVisibility = true;
          errorText = AppText.successfulModify;
        });
        await widget.patchSurf(surf);
        return;
      }
    }

    if(passwdController.text != '' && passwdController.text != confirmPasswdController.text){
      setState(() {
        errorVisibility = true;
        successVisibility = false;
        errorText = AppText.passWdNoMatch;
      });
    }
    else if(surf.email == ''){
      setState(() {
        errorVisibility = true;
        successVisibility = false;
        errorText = AppText.emailCantBeEmpty;
      });

    }
    else if(!isValidEmail(surf.email)){
      setState(() {
        errorVisibility = true;
        successVisibility = false;
        errorText = AppText.emailFormatError;
      });
    }
    else{
      final isUnique = await isEmailUnique(surf.email, (){
        setState(() {
          errorVisibility = true;
          successVisibility = false;
          errorText = AppText.emailAlreadyExist;
        });
      });
      if(!isUnique)return;
      await widget.patchSurf(surf);
      setState(() {
        errorVisibility = false;
        successVisibility = true;
        errorText = AppText.successModify;
      });
    }
  }
}
