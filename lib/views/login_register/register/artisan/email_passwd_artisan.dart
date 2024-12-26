import 'package:flutter/material.dart';

import '../../../../api_handler/email/check_email_is_unique.dart';
import '../../../../color.dart';
import '../../../../core_value.dart';
import '../../../../models/artisan/createArtisan.dart';
import '../../../../text/fr.dart';
import '../../../../widget/button/elevated_button_opacity.dart';
import '../../../../widget/decoration/text_filed_deco_no_counter.dart';
import '../../../../widget/header/app_bar_back_button.dart';
import '../../../../widget/visibility/error.dart';

class EmailPasswdArtisan extends StatefulWidget {
  const EmailPasswdArtisan({
    super.key,
    required this.createArtisan,
  });

  final CreateArtisan createArtisan;

  @override
  State<EmailPasswdArtisan> createState() => _EmailPasswdArtisanState();
}

class _EmailPasswdArtisanState extends State<EmailPasswdArtisan> {
  TextEditingController? _emailController;
  TextEditingController? _passwdController;
  TextEditingController? _confirmPasswdController;

  bool errorVisibility = false;
  String errorText = AppText.createTitleWorkErrorText;

  @override
  void initState(){
    super.initState();
    _emailController = TextEditingController(text: widget.createArtisan.email);
    _passwdController = TextEditingController(text: widget.createArtisan.password);
    _confirmPasswdController = TextEditingController(text: widget.createArtisan.password);
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
                  widget.createArtisan.email = value;
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
    final instance = widget.createArtisan;
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
      widget.createArtisan.password = _passwdController!.text;
      Navigator.pushNamed(context, '/artisan/recap',arguments: widget.createArtisan);
    }
  }
}
