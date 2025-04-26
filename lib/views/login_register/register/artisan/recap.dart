import 'package:flutter/material.dart';

import '../../../../api_handler/credential.dart';
import '../../../../api_handler/register/register_artisan.dart';
import '../../../../color.dart';
import '../../../../core_value.dart';
import '../../../../models/artisan/createArtisan.dart';
import '../../../../text/fr.dart';
import '../../../../utils/format_string/add_space.dart';
import '../../../../widget/button/elevated_button_opacity.dart';
import '../../../../widget/decoration/decoration_round_main_color.dart';
import '../../../../widget/header/app_bar_back_button.dart';

class RecapArtisanRegister extends StatelessWidget {
  const RecapArtisanRegister({
    super.key,
    required this.createArtisan,
  });

  final CreateArtisan createArtisan;
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
                '${AppText.siretNumber} ${formatAllString(createArtisan.artisan.siretNumber,4) ?? AppText.noSiretNumber}\n\n'
                '${AppText.email} ${createArtisan.email ?? AppText.noEmail} \n'
                    '${AppText.phone} ${formatAllString(createArtisan.artisan.phone,2) ?? AppText.noPhone}\n\n'
              '${AppText.companyName} : ${createArtisan.artisan.companyName ?? AppText.noCompanyName} \n'
                  '${AppText.administratorUnion} ${createArtisan.artisan.firstName ?? AppText.noAdministratorName} ${createArtisan.artisan.lastName ?? AppText.noAdministratorFirstName}',
                style: Theme.of(context).textTheme.displaySmall,
              ),
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
                      '${createArtisan.adress.country}\n'
                          '${createArtisan.adress.region}\n'
                          '${createArtisan.adress.postalCode} ${createArtisan.adress.city}\n'
                          '${createArtisan.adress.street}\n\n'
                          '${AppText.commentary} : ${createArtisan.adress.comment ?? AppText.noCommentary}',
                      style: Theme.of(context).textTheme.displaySmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              Text(
                AppText.recapWarning,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
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
      await registerArtisan(createArtisan);
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }
}
