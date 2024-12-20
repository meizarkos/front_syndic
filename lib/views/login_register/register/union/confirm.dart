import 'package:flutter/material.dart';
import 'package:front_syndic/api_handler/credential.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/widget/button/elevated_button_opacity.dart';

import '../../../../api_handler/register/register_union.dart';
import '../../../../models/union/create_union.dart';
import '../../../../text/fr.dart';
import '../../../../widget/decoration/decoration_round_main_color.dart';
import '../../../../widget/header/app_bar_back_button.dart';

class ConfirmUnionCreation extends StatelessWidget {
  const ConfirmUnionCreation({
    super.key,
    required this.createUnion,
  });

  final CreateUnion createUnion;
  static const space = 15.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBackButton(context, title: AppText.confirm),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppUIValue.spaceScreenToAny),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${AppText.siretNumber} ${createUnion.union.siretNumber ?? AppText.noSiretNumber}',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const Divider(color: Colors.black, thickness: 2),
                const SizedBox(height: space),
                Text(
                  AppText.contactMode,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: space),
                Text(
                  '${AppText.email} ${createUnion.email ?? AppText.noEmail} \n\n'
                  '${AppText.phone} ${createUnion.union.phone ?? AppText.noPhone}',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const Divider(color: Colors.black, thickness: 2),
                Container(
                  padding: EdgeInsets.all(AppUIValue.spaceScreenToAny),
                  decoration: decorationRoundMainColor(),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppText.unionInfo,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(height: space),
                      Text(
                        '${AppText.unionName} : ${createUnion.union.name ?? AppText.noNameUnion} \n\n'
                        '${AppText.administratorUnion} ${createUnion.union.administratorName ?? AppText.noAdministratorName} ${createUnion.union.administratorFirstName ?? AppText.noAdministratorFirstName}',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  ),
                ),
                const Divider(color: Colors.black, thickness: 2),
                const SizedBox(height: space),
                Container(
                  padding: EdgeInsets.all(AppUIValue.spaceScreenToAny),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppText.adress,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(height: space),
                      Text(
                        '${createUnion.adress.country}\n'
                            '${createUnion.adress.region}\n'
                            '${createUnion.adress.postalCode} ${createUnion.adress.city}\n'
                            '${createUnion.adress.street}\n'
                            '${AppText.commentary} : ${createUnion.adress.comment ?? AppText.noCommentary}',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppUIValue.spaceScreenToAny*3),
                Center(
                  child: elevatedButtonAndTextColor(
                    AppColors.mainBackgroundColor,
                      AppText.confirm,
                      context,
                      ()async=> await _register(context),
                      AppColors.mainTextColor,
                  ),
                ),
              ],
          ),
        ),
      ),
    );
  }

  Future<void> _register(BuildContext context)async{
    final token = await registerUnion(createUnion);
    if(token != ''){
      Credential.instance.token = token;
      Navigator.pushNamedAndRemoveUntil(context, '/union_main', (route) => false);
    }
  }
}
