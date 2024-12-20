import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/text/fr.dart';
import 'package:front_syndic/widget/button/elevated_button_opacity.dart';
import 'package:front_syndic/widget/header/app_bar_back_button.dart';
import 'package:front_syndic/widget/visibility/error.dart';

import '../../../../api_handler/email/check_email_is_unique.dart';
import '../../../../api_handler/register/register_union.dart';
import '../../../../models/union/create_union.dart';
import '../../../../widget/decoration/text_filed_deco_no_counter.dart';

class UnionPasswdEmail extends StatefulWidget {
  const UnionPasswdEmail({
    super.key,
    required this.createUnion,
  });

  final CreateUnion createUnion;

  @override
  State<UnionPasswdEmail> createState() => _UnionPasswdEmailState();
}

class _UnionPasswdEmailState extends State<UnionPasswdEmail> {

  TextEditingController? _emailController;
  TextEditingController? _passwdController;
  TextEditingController? _confirmPasswdController;

  bool errorVisibility = false;
  String errorText = AppText.createTitleWorkErrorText;

  @override
  void initState(){
    super.initState();
    _emailController = TextEditingController(text: widget.createUnion.email);
    _passwdController = TextEditingController(text: '');
    _confirmPasswdController = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBackButton(context, title: AppText.identification),
      body: Padding(
          padding: EdgeInsets.all(AppUIValue.spaceScreenToAny),
          child: Column(
            children: [
              TextField(
                controller: _emailController,
                decoration: roundBorderTextFieldWithoutCounter(AppText.loginLabelTextEmail),
                onChanged: (value) {
                  widget.createUnion.email = value;
                },
                maxLength: 50,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              TextField(
                controller: _passwdController,
                decoration: roundBorderTextFieldWithoutCounter(AppText.loginLabelTextPassword),
                onChanged: (value) {
                  if(_passwdController == null)return;
                  _passwdController!.text = value;
                },
                maxLength: 50,
                obscureText: true,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              TextField(
                controller: _confirmPasswdController,
                decoration: roundBorderTextFieldWithoutCounter(AppText.confirmPasswd),
                onChanged: (value) {
                  if(_confirmPasswdController == null)return;
                  _confirmPasswdController!.text = value;
                },
                maxLength: 50,
                obscureText: true,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              ErrorVisibility(errorVisibility: errorVisibility, errorText: errorText),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              elevatedButtonAndTextColor(
                  AppColors.mainBackgroundColor,
                  AppText.save,
                  context,
                  ()async=>await _onRegister(),
                  AppColors.mainTextColor
              ),
            ],
          )
      ),
    );
  }

  bool isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',);

    return emailRegExp.hasMatch(email);
  }

  Future<void> _onRegister()async{
    final instance = widget.createUnion;
    if(instance.email == null || instance.email == '' || _passwdController == null || _passwdController!.text == '' || _confirmPasswdController == null || _confirmPasswdController!.text == '' || _passwdController == null || _passwdController!.text == ''){
      setState(() {
        errorText = AppText.createTitleWorkErrorText;
        errorVisibility = true;
      });
    }
    else if(!isValidEmail(instance.email!)){
      setState(() {
        errorText = AppText.emailFormatError;
        errorVisibility = true;
      });
      return;
    }
    else if(_passwdController!.text != _confirmPasswdController!.text){
      setState(() {
        errorText = AppText.passWdNoMatch;
        errorVisibility = true;
      });
      return;
    }
    else{
      final isUnique = await isEmailUnique(instance.email!, (){
        setState(() {
          errorVisibility = true;
          errorText = AppText.emailAlreadyExist;
        });
      });
      if(!isUnique)return;
      setState(() {
        errorVisibility = false;
      });
      widget.createUnion.password = _passwdController!.text;
      Navigator.pushNamed(context, '/union/confirm',arguments: widget.createUnion);
    }
  }
}
