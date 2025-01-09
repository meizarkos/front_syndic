import 'package:flutter/material.dart';

import '../../color.dart';
import '../button/elevated_button_opacity.dart';

SizedBox createButton(BuildContext context, String text, Function() onPressed,{Color color = AppColors.mainBackgroundColor,Color textColor = AppColors.mainTextColor}) {
  return SizedBox(
    height: 47,
    child: elevatedButtonAndTextColor(
      color,
      text,
      context,
      onPressed,
      textColor,
    ),
  );
}