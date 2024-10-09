import 'package:flutter/material.dart';
import '../../color.dart';


TextStyle getTextStyleMainColor(double fontSize){
  return TextStyle(
    fontSize: fontSize,
    fontWeight: FontWeight.bold,
    color: AppColors.mainTextColor,
    shadows: [
      BoxShadow(
        color: Colors.black.withOpacity(0.5),
        blurRadius: 1,
        spreadRadius: 1,
        blurStyle: BlurStyle.inner,
      ),
    ],
  );
}