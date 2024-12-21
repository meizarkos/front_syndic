import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/council/createCouncil.dart';
import 'package:front_syndic/text/fr.dart';
import 'package:front_syndic/widget/button/elevated_button_opacity.dart';
import 'package:front_syndic/widget/header/app_bar_back_button.dart';
import 'package:front_syndic/widget/visibility/error.dart';

import '../../../../widget/decoration/text_filed_deco_no_counter.dart';

class CouncilPasswd extends StatefulWidget {
  const CouncilPasswd({
    super.key,
    required this.createCouncil,
  });

  final CreateCouncil createCouncil;

  @override
  State<CouncilPasswd> createState() => _CouncilPasswdState();
}

class _CouncilPasswdState extends State<CouncilPasswd> {

  TextEditingController? _passwdController;
  TextEditingController? _confirmPasswdController;

  bool errorVisibility = false;
  String errorText = AppText.createTitleWorkErrorText;

  @override
  void initState(){
    super.initState();
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

  Future<void> _onRegister()async{
    if(_passwdController == null || _passwdController!.text == '' || _confirmPasswdController == null || _confirmPasswdController!.text == '' || _passwdController == null || _passwdController!.text == ''){
      setState(() {
        errorText = AppText.createTitleWorkErrorText;
        errorVisibility = true;
      });
    }
    else if(_passwdController!.text != _confirmPasswdController!.text){
      setState(() {
        errorText = AppText.passWdNoMatch;
        errorVisibility = true;
      });
      return;
    }
    else{
      setState(() {
        errorVisibility = false;
      });
      widget.createCouncil.password = _passwdController!.text;
      Navigator.pushNamed(context, 'council/confirm_register',arguments: widget.createCouncil);
    }
  }
}
