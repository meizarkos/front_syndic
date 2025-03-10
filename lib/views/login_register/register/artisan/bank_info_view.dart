import 'package:flutter/material.dart';

import '../../../../color.dart';
import '../../../../core_value.dart';
import '../../../../models/artisan/createArtisan.dart';
import '../../../../text/fr.dart';
import '../../../../widget/button/elevated_button_opacity.dart';
import '../../../../widget/decoration/text_filed_deco_no_counter.dart';
import '../../../../widget/header/app_bar_back_button.dart';
import '../../../../widget/text_format_input_textfield/customSpaceFormatter.dart';
import '../../../../widget/visibility/error.dart';

class BankInfoArtisan extends StatefulWidget {
  const BankInfoArtisan({
    super.key,
    required this.createArtisan,
  });

  final CreateArtisan createArtisan;

  @override
  State<BankInfoArtisan> createState() => _BankInfoArtisanState();
}

class _BankInfoArtisanState extends State<BankInfoArtisan> {
  TextEditingController? _ibanController;
  TextEditingController? _bicController;
  TextEditingController? _bankNameController;

  bool errorVisibility = false;

  @override
  void initState(){
    super.initState();
    _ibanController = TextEditingController(text: widget.createArtisan.bankInfo.iban);
    _bicController = TextEditingController(text: widget.createArtisan.bankInfo.bic);
    _bankNameController = TextEditingController(text: widget.createArtisan.bankInfo.bankName);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBackButton(context,title: AppText.bankData),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppUIValue.spaceScreenToAny),
          child: Column(
            children: [
              TextField(
                controller: _ibanController,
                decoration: roundBorderTextFieldWithoutCounter(AppText.iban),
                inputFormatters: [CustomCharacterSpaceFormatter(interval: 4)],
                onChanged: (value) {
                  widget.createArtisan.bankInfo.iban = value;
                },
                maxLength: 34,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              TextField(
                controller: _bicController,
                decoration: roundBorderTextFieldWithoutCounter(AppText.bic),
                onChanged: (value) {
                  widget.createArtisan.bankInfo.bic = value;
                },
                maxLength: 11,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              TextField(
                controller: _bankNameController,
                decoration: roundBorderTextFieldWithoutCounter(AppText.bankName),
                onChanged: (value) {
                  widget.createArtisan.bankInfo.bankName = value;
                },
                maxLength: 50,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              ErrorVisibility(errorVisibility: errorVisibility, errorText: AppText.createTitleWorkErrorText),
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
      ),
    );
  }

  void save(){
    final bankInfo = widget.createArtisan.bankInfo;
    if(bankInfo.iban == null || bankInfo.iban == ''|| bankInfo.bic == null || bankInfo.bic == '' || bankInfo.bankName == null || bankInfo.bankName == ''){
      setState(() {
        errorVisibility = true;
      });
      return;
    }
    widget.createArtisan.bankInfo.iban = widget.createArtisan.bankInfo.iban?.replaceAll(' ', '');
    setState(() {
      errorVisibility = false;
    });
    Navigator.pushNamed(context, '/artisan/get_adress', arguments: widget.createArtisan);
  }
}
