
/*import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/models/artisan/createArtisan.dart';
import 'package:front_syndic/models/union/create_union.dart';
import 'package:front_syndic/models/union/union.dart';
import 'package:front_syndic/text/fr.dart';
import 'package:front_syndic/widget/button/elevated_button_opacity.dart';

import '../../../models/adress/adress.dart';
import '../../../models/artisan/artisan.dart';
import '../../../models/bank_info/bank_info.dart';
import '../../../models/co_owner/co_owner.dart';
import '../../../models/council/council.dart';
import '../../../models/council/createCouncil.dart';
import '../../../widget/header/app_bar_back_button.dart';

class ChoseClass extends StatelessWidget {
  const ChoseClass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBackButton(context,title: AppText.accountTypeTitle),
      body: Padding(
        padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
        child: Column(
          children: [
            _classButton(AppText.artisan, context, (){
              final createArtisan = CreateArtisan(artisan: Artisan(), adress: Adress(), bankInfo: BankInfo());
              Navigator.pushNamed(context, '/artisan/creation_info',arguments : createArtisan);
            }),
            _classButton(AppText.council, context, (){
              final createCouncil = CreateCouncil(council: Council(), adress: Adress(), coOwner: CoOwner());
              Navigator.pushNamed(context, '/council/name',arguments: createCouncil);
            }),
            _classButton(AppText.union, context, (){
              final createUnion = CreateUnion(union: UnionApi(), adress: Adress());
              Navigator.pushNamed(context, '/union/get_info',arguments: createUnion);
            }),
          ],
        ),
      ),
    );
  }

  Container _classButton(String text,BuildContext context, VoidCallback goTo){
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
      child: elevatedButtonAndTextColor(
       AppColors.mainBackgroundColor,
          text,
          context,
          goTo,
          AppColors.mainTextColor,
      ),
    );
  }
}*/
