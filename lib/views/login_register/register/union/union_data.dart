import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/union/create_union.dart';
import 'package:front_syndic/text/fr.dart';
import 'package:front_syndic/widget/button/elevated_button_opacity.dart';
import 'package:front_syndic/widget/header/app_bar_back_button.dart';
import 'package:front_syndic/widget/visibility/error.dart';

import '../../../../widget/decoration/text_filed_deco_no_counter.dart';
import '../../../../widget/text_format_input_textfield/customSpaceFormatter.dart';

class UnionData extends StatefulWidget {
  const UnionData({
    super.key,
    required this.createUnion,
  });

  final CreateUnion createUnion;

  @override
  State<UnionData> createState() => _UnionDataState();
}

class _UnionDataState extends State<UnionData> {

  TextEditingController? _unionNameController;
  TextEditingController? _phoneController;
  TextEditingController? _firstNameController;
  TextEditingController? _lastNameController;
  TextEditingController? _siretNumberController;

  bool errorVisibility = false;
  String errorText = AppText.createTitleWorkErrorText;

  @override
  void initState(){
    super.initState();
    _unionNameController = TextEditingController(text: widget.createUnion.union.name);
    _phoneController = TextEditingController(text: widget.createUnion.union.phone);
    _firstNameController = TextEditingController(text: widget.createUnion.union.administratorFirstName);
    _lastNameController = TextEditingController(text: widget.createUnion.union.administratorName);
    _siretNumberController = TextEditingController(text: widget.createUnion.union.siretNumber);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBackButton(context,title: AppText.unionInfo),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(AppUIValue.spaceScreenToAny),
            child: Column(
              children: [
                TextField(
                  controller: _unionNameController,
                  decoration: roundBorderTextFieldWithoutCounter(AppText.unionName),
                  onChanged: (value) {
                    widget.createUnion.union.name = value;
                  },
                  maxLength: 50,
                ),
                const SizedBox(height: AppUIValue.spaceScreenToAny),
                TextField(
                  controller: _firstNameController,
                  decoration: roundBorderTextFieldWithoutCounter(AppText.unionFirstName),
                  onChanged: (value) {
                    widget.createUnion.union.administratorFirstName = value;
                  },
                  maxLength: 50,
                ),
                const SizedBox(height: AppUIValue.spaceScreenToAny),
                TextField(
                  controller: _lastNameController,
                  decoration: roundBorderTextFieldWithoutCounter(AppText.unionLastName),
                  onChanged: (value) {
                    widget.createUnion.union.administratorName = value;
                  },
                  maxLength: 50,
                ),
                const SizedBox(height: AppUIValue.spaceScreenToAny),
                TextField(
                  controller: _phoneController,
                  decoration: roundBorderTextFieldWithoutCounter(AppText.unionPhone),
                  onChanged: (value) {
                    widget.createUnion.union.phone = value;
                  },
                  keyboardType: TextInputType.phone,
                  inputFormatters: [CustomCharacterSpaceFormatter(interval: 2)],
                  maxLength: 50,
                ),
                const SizedBox(height: AppUIValue.spaceScreenToAny),
                TextField(
                  controller: _siretNumberController,
                  decoration: roundBorderTextFieldWithoutCounter(AppText.unionSiret),
                  onChanged: (value) {
                    widget.createUnion.union.siretNumber = value;
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: [CustomCharacterSpaceFormatter(interval: 4)],
                  maxLength: 17,
                ),
                const SizedBox(height: AppUIValue.spaceScreenToAny),
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
      ),
    );
  }

  void save(){
    final union = widget.createUnion.union;
    if(union.name != null && union.administratorFirstName != null && union.administratorName != null && union.phone != null && union.siretNumber != null &&
        union.name != '' && union.administratorFirstName != '' && union.administratorName != ''  && union.phone != ''  && union.siretNumber != '' ){

      union.siretNumber = union.siretNumber!.replaceAll(' ', '');
      union.phone = union.phone!.replaceAll(' ', '');

      if(union.siretNumber!.length != 14){
        setState(() {
          errorText = AppText.siretNumberWrongSize;
          errorVisibility = true;
        });
        return;
      }

      setState(() {
        errorVisibility = false;
      });
      Navigator.pushNamed(context, '/union/get_adress', arguments: widget.createUnion);
    } else {
      setState(() {
        errorText = AppText.createTitleWorkErrorText;
        errorVisibility = true;
      });
    }
  }
}

