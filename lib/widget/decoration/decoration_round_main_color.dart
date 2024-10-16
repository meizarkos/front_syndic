import 'package:flutter/cupertino.dart';

import '../../color.dart';

BoxDecoration decorationRoundMainColor() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(15.0),
    color: AppColors.mainBackgroundColor,
  );
}

BoxDecoration decorationRoundRedColor(){
  return BoxDecoration(
    borderRadius: BorderRadius.circular(25.0),
    color: AppColors.actionButtonColor,
  );
}