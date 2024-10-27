import 'package:flutter/material.dart';

import '../../core_value.dart';

InputDecoration textFieldMainDeco(String placeHolder){
  return InputDecoration(
    border: OutlineInputBorder(
      borderRadius:
      BorderRadius.circular(AppUIValue.textInputBorderRadius), // Set corner radius here
    ),
    labelText: placeHolder,
  );
}