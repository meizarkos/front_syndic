import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/widget/button/elevated_button_opacity.dart';
import 'package:front_syndic/widget/visibility/error.dart';

import '../../../models/council/createCouncil.dart';
import '../../../text/fr.dart';
import '../../../widget/decoration/text_filed_deco_no_counter.dart';
import '../../../widget/header/app_bar_back_button.dart';

class ChoseName extends StatefulWidget {
  const ChoseName({
    super.key,
    required this.createCouncil,
  });

  final CreateCouncil createCouncil;

  @override
  State<ChoseName> createState() => _ChoseNameState();
}

class _ChoseNameState extends State<ChoseName> {

  TextEditingController? _nameController;
  TextEditingController? _sizeController;

  bool errorVisibility = false;

  @override
  void initState(){
    super.initState();
    _nameController = TextEditingController(text: widget.createCouncil.coOwner.name);
    if(widget.createCouncil.coOwner.lotSize == null){
      _sizeController = TextEditingController(text: '');
    }
    else{
      _sizeController = TextEditingController(text: widget.createCouncil.coOwner.lotSize.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBackButton(context, title: AppText.infoCoOwner),
      body: Padding(
        padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration : roundBorderTextFieldWithoutCounter(AppText.name),
              onChanged: (value) {
                widget.createCouncil.coOwner.name = value;
              },
              maxLength: 50,
              maxLines: 1,
            ),
            const SizedBox(height: AppUIValue.spaceScreenToAny),
            TextField(
              controller: _sizeController,
              decoration : roundBorderTextFieldWithoutCounter(AppText.lotNumber),
              onChanged: (value) {
                try{
                  widget.createCouncil.coOwner.lotSize = int.parse(value);
                }
                catch(e){
                  widget.createCouncil.coOwner.lotSize = -1;
                }
              },
              maxLength: 10,
              maxLines: 1,
              keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
            ),
            const SizedBox(height: AppUIValue.spaceScreenToAny),
            ErrorVisibility(errorVisibility: errorVisibility, errorText: AppText.adressCreationError),
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

  void save(){
    if(_sizeController?.text == '' || _sizeController?.text == '-1' ||  widget.createCouncil.coOwner.lotSize == null || widget.createCouncil.coOwner.lotSize! < 0){
      setState(() {
        errorVisibility = true;
      });
    }
    else if(_nameController?.text == '' || _nameController?.text == null){
      setState(() {
        errorVisibility = true;
      });
    }
    else{
      setState(() {
        errorVisibility = false;
      });
      Navigator.pushNamed(context, '/union/create_council/contact_info', arguments: widget.createCouncil);
    }
  }
}
