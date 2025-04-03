import 'package:flutter/material.dart';
import 'package:front_syndic/api_handler/credential.dart';

import '../../../../api_handler/council/post_council.dart';
import '../../../../color.dart';
import '../../../../core_value.dart';
import '../../../../models/council/createCouncil.dart';
import '../../../../text/fr.dart';
import '../../../../widget/button/elevated_button_opacity.dart';
import '../../../../widget/header/app_bar_back_button.dart';

const _heightBetweenText = 5.0;


class CouncilConfirmRegister extends StatefulWidget {
  const CouncilConfirmRegister({
    super.key,
    required this.createCouncil,
  });

  final CreateCouncil createCouncil;

  @override
  State<CouncilConfirmRegister> createState() => _CouncilConfirmRegisterState();
}

class _CouncilConfirmRegisterState extends State<CouncilConfirmRegister> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBackButton(context, title: AppText.createWorkRequestRecap),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppUIValue.spaceScreenToAny),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppText.infoCoOwner,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              Text(
                '${AppText.name} : ${widget.createCouncil.coOwner.name}',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: _heightBetweenText),
              Text(
                '${AppText.lotNumber} : ${widget.createCouncil.coOwner.lotSize}',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              Text(
                AppText.infoCouncil,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              Text(
                '${widget.createCouncil.council.firstName} ${widget.createCouncil.council.lastName}',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: _heightBetweenText),
              Text(
                '${AppText.loginLabelTextEmail} : ${widget.createCouncil.email}',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: _heightBetweenText),
              Text(
                '${AppText.phoneCouncil} : ${widget.createCouncil.council.phone}',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              Text(
                AppText.adress,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              Text(
                '${widget.createCouncil.adress.country}\n'
                    '${widget.createCouncil.adress.region}\n'
                    '${widget.createCouncil.adress.postalCode} ${widget.createCouncil.adress.city}\n'
                    '${widget.createCouncil.adress.street}\n'
                    '${AppText.commentary} : ${widget.createCouncil.adress.comment ?? AppText.noCommentary}',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny*2),
              Center(
                child: elevatedButtonAndTextColor(
                    AppColors.mainBackgroundColor,
                    AppText.save,
                    context,
                        ()async=>await _onRegister(),
                    AppColors.mainTextColor
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onRegister() async{
    final token = await registerCouncil(widget.createCouncil);
    if(token != ''){
      Credential.instance.token = 'Bearer $token';
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/council_main',
            (Route<dynamic> route) => false,
      );
    }
  }
}
