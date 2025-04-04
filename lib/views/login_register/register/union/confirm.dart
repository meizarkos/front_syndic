import 'package:flutter/material.dart';
import 'package:front_syndic/api_handler/credential.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/utils/format_string/add_space.dart';
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
                  '${AppText.siretNumber} ${formatAllString(createUnion.union.siretNumber,4) ?? AppText.noSiretNumber}\n\n'
                  '${AppText.email} ${createUnion.email ?? AppText.noEmail} \n'
                  '${AppText.phone} ${formatAllString(createUnion.union.phone,2) ?? AppText.noPhone}\n\n'
                      '${AppText.unionName} : ${createUnion.union.name ?? AppText.noNameUnion} \n'
                      '${AppText.administratorUnion} ${createUnion.union.administratorName ?? AppText.noAdministratorName} ${createUnion.union.administratorFirstName ?? AppText.noAdministratorFirstName}',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: space),
                const SizedBox(height: space),
                Container(
                  padding: EdgeInsets.all(AppUIValue.spaceScreenToAny),
                  width: double.infinity,
                  decoration: decorationRoundMainColor(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                            '${createUnion.adress.street}\n\n'
                            '${AppText.commentary} : ${createUnion.adress.comment ?? AppText.noCommentary}',
                        style: Theme.of(context).textTheme.displaySmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppUIValue.spaceScreenToAny*3),
                Center(
                  child: elevatedButtonAndTextColor(
                    AppColors.actionButtonColor.withOpacity(AppUIValue.opacityActionButton),
                      AppText.confirm,
                      context,
                      ()async=> await _register(context),
                      Colors.black,
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
