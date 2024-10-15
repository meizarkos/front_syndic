import 'package:flutter/material.dart';

import '../../../color.dart';
import '../../../core_value.dart';
import '../../../widget/button/elevated_button_opacity.dart';
import '../../../widget/decoration/decoration_round_main_color.dart';

Column columnOfTextButton(String title, String subtitle1,String subtitle2,String textButton,VoidCallback goTo, BuildContext context){
  return Column(
    children: [
      Text(
        title,
        style: Theme.of(context).textTheme.displayMedium,
      ),
      const SizedBox(height: 10),
      Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
        decoration: decorationRoundRedColor(),
        child: Column(
          children: [
            Text(
              subtitle1,
              style: Theme.of(context).textTheme.displaySmall,
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            Text(
              subtitle2,
              style: Theme.of(context).textTheme.displaySmall,
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      const SizedBox(height: 10),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: elevatedButtonOpacity(AppColors.actionButtonColor.withOpacity(AppUIValue.opacityActionButton), textButton, context, goTo),
      ),
    ],
  );
}