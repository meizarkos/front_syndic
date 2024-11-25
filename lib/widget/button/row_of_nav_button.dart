import 'package:flutter/cupertino.dart';

import '../../color.dart';
import '../../core_value.dart';
import 'elevated_button_opacity.dart';

Row rowOfNavButton(String textUp, String textDown, BuildContext context,
    VoidCallback onPressedUp, VoidCallback onPressedDown) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Expanded(
        child: elevatedButtonAndTextColor(
          AppColors.mainBackgroundColor,
          textUp,
          context,
          onPressedUp,
          AppColors.mainTextColor,
        ),
      ),
      const SizedBox(width: AppUIValue.spaceScreenToAny),
      Expanded(
        child: elevatedButtonAndTextColor(
          AppColors.mainBackgroundColor,
          textDown,
          context,
          onPressedDown,
          AppColors.mainTextColor,
        ),
      ),
    ],
  );
}