import 'dart:async';

import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/text/fr.dart';
import 'package:front_syndic/widget/button/elevated_button_opacity.dart';
import 'package:front_syndic/widget/header/app_bar_back_button.dart';
import 'package:front_syndic/widget/visibility/error.dart';

import '../../../api_handler/email/check_email_is_unique.dart';
import '../../../core_value.dart';
import '../../../models/council/createCouncil.dart';
import '../../../widget/decoration/text_filed_deco_no_counter.dart';

class ContactInfoCouncil extends StatefulWidget {
  const ContactInfoCouncil({
    super.key,
    required this.createCouncil
  });

  final CreateCouncil createCouncil;

  @override
  State<ContactInfoCouncil> createState() => _ContactInfoCouncilState();
}

class _ContactInfoCouncilState extends State<ContactInfoCouncil> {

  TextEditingController? _emailController;
  TextEditingController? _phoneController;
  TextEditingController? _firstNameController;
  TextEditingController? _lastNameController;

  bool errorVisibility = false;
  bool isUse = false;
  String errorText = AppText.adressCreationError;

  @override
  void initState(){
    super.initState();
    _emailController = TextEditingController(text: widget.createCouncil.email);
    _phoneController = TextEditingController(text: widget.createCouncil.council.phone);
    _firstNameController = TextEditingController(text: widget.createCouncil.council.firstName);
    _lastNameController = TextEditingController(text: widget.createCouncil.council.lastName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBackButton(context,title: AppText.infoCouncil),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
          child: Column(
            children: [
              TextField(
                controller: _emailController,
                decoration : roundBorderTextFieldWithoutCounter(AppText.loginLabelTextEmail),
                onChanged: (value) {
                  widget.createCouncil.email = value;
                },
                maxLength: 128,
                maxLines: 1,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              TextField(
                controller: _phoneController,
                decoration : roundBorderTextFieldWithoutCounter(AppText.phoneCouncil),
                onChanged: (value) {
                  widget.createCouncil.council.phone = value;
                },
                maxLength: 50,
                maxLines: 1,
                keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              Row(
                children: [
                  Expanded(
                    child : TextField(
                      controller: _firstNameController,
                      decoration : roundBorderTextFieldWithoutCounter(AppText.firstName),
                      onChanged: (value) {
                        widget.createCouncil.council.firstName = value;
                      },
                      maxLength: 50,
                      maxLines: 1,
                    ),
                  ),
                  const SizedBox(width: AppUIValue.spaceScreenToAny),
                  Expanded(
                    child : TextField(
                      controller: _lastNameController,
                      decoration : roundBorderTextFieldWithoutCounter(AppText.name),
                      onChanged: (value) {
                        widget.createCouncil.council.lastName = value;
                      },
                      maxLength: 50,
                      maxLines: 1,
                    ),
                  ),
                ]
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              ErrorVisibility(errorVisibility: errorVisibility, errorText: errorText),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              elevatedButtonFuture(
                  AppColors.mainBackgroundColor,
                  AppText.save,
                  context,
                  ()async =>await save(),
                  AppColors.mainTextColor
              )
            ],
          ),
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',);

    return emailRegExp.hasMatch(email);
  }

  Future<void> save()async{

    if(isUse){
      return;
    }

    setState(() {
      isUse = true;
    });

    Timer(Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          isUse = false;
        });
      }
    });

    if(widget.createCouncil.email == null || widget.createCouncil.email == '' || widget.createCouncil.council.phone == null || widget.createCouncil.council.phone == '' || widget.createCouncil.council.lastName == null || widget.createCouncil.council.lastName == '' || widget.createCouncil.council.firstName == null || widget.createCouncil.council.firstName == ''){
      setState(() {
        errorText = AppText.adressCreationError;
        errorVisibility = true;
      });
      return;
    }
    else if(!isValidEmail(widget.createCouncil.email!)){
      setState(() {
        errorText = AppText.emailFormatError;
        errorVisibility = true;
      });
      return;
    }
    final emailIsUnique = await isEmailUnique(widget.createCouncil.email!, (){
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
    Navigator.pushNamed(context, '/union/create_council/adress',
      arguments: widget.createCouncil
    );
    return;
  }
}
