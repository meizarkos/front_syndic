import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/models/appartment/appartment.dart';
import 'package:front_syndic/widget/header/app_bar_back_button.dart';

import '../../core_value.dart';
import '../../models/adress/adress.dart';
import '../../models/co_owner/co_owner.dart';
import '../../models/council/council.dart';
import '../../models/council/createCouncil.dart';
import '../../models/user/createUser.dart';
import '../../models/user/user.dart';
import '../../text/fr.dart';
import '../../widget/button/elevated_button_opacity.dart';

class ChoseWhichOneCreateUnion extends StatelessWidget {
  const ChoseWhichOneCreateUnion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBackButton(context,title: AppText.createAPlace),
      body: Padding(
        padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
              child: elevatedButtonAndTextColor(
                AppColors.mainBackgroundColor,
                AppText.createACopro,
                context,
                () {
                  final createCouncil = CreateCouncil(adress: Adress(), council: Council(), coOwner: CoOwner());
                  Navigator.pushNamed(context, '/union/create_council/name',arguments: createCouncil);
                },
                AppColors.mainTextColor,
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
              child: elevatedButtonAndTextColor(
                AppColors.mainBackgroundColor,
                AppText.createAnAppartment,
                context,
                    () {
                  final createUser = CreateUser(user: User(), adress: Adress());
                  Navigator.pushNamed(context, '/union/create_user/name',arguments: createUser);
                },
                AppColors.mainTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
