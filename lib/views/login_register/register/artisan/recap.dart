import 'package:flutter/material.dart';

import '../../../../api_handler/credential.dart';
import '../../../../api_handler/register/register_artisan.dart';
import '../../../../color.dart';
import '../../../../core_value.dart';
import '../../../../models/artisan/createArtisan.dart';
import '../../../../text/fr.dart';
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
                '${AppText.siretNumber} ${createArtisan.artisan.siretNumber ?? AppText.noSiretNumber}',
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
                '${AppText.email} ${createArtisan.email ?? AppText.noEmail} \n\n'
                    '${AppText.phone} ${createArtisan.artisan.phone ?? AppText.noPhone}',
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
                      '${AppText.unionName} : ${createArtisan.artisan.companyName ?? AppText.noCompanyName} \n\n'
                          '${AppText.administratorUnion} ${createArtisan.artisan.firstName ?? AppText.noAdministratorName} ${createArtisan.artisan.lastName ?? AppText.noAdministratorFirstName}',
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
                      '${createArtisan.adress.country}\n'
                          '${createArtisan.adress.region}\n'
                          '${createArtisan.adress.postalCode} ${createArtisan.adress.city}\n'
                          '${createArtisan.adress.street}\n'
                          '${AppText.commentary} : ${createArtisan.adress.comment ?? AppText.noCommentary}',
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
      final token = await registerArtisan(createArtisan);
      if(token != ''){
        Credential.instance.token = token;
        //Navigator.pushNamedAndRemoveUntil(context, '/artisan_main', (route) => false);
      }
  }
}
