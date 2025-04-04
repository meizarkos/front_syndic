import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/text/fr.dart';
import 'package:front_syndic/widget/button/elevated_button_opacity.dart';
import 'package:front_syndic/widget/header/app_bar_back_button.dart';

import '../../../../models/council/createCouncil.dart';
import '../../../../widget/decoration/decoration_round_main_color.dart';

const _heightBetweenText = 5.0;

class ConfirmCreationCouncil extends StatefulWidget {
  const ConfirmCreationCouncil({
    super.key,
    required this.createCouncil,
    required this.onRegister,
  });

  final CreateCouncil createCouncil;
  final Function() onRegister;

  @override
  State<ConfirmCreationCouncil> createState() =>
      _ConfirmCreationCouncilState();
}

class _ConfirmCreationCouncilState
    extends State<ConfirmCreationCouncil> {

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
                '${widget.createCouncil.coOwner.name}',
                style: Theme
                    .of(context)
                    .textTheme
                    .displayMedium,
              ),
              const SizedBox(height: _heightBetweenText),
              Text(
                '${AppText.lotNumber} : ${widget.createCouncil.coOwner
                    .lotSize}',
                style: Theme
                    .of(context)
                    .textTheme
                    .displaySmall,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              Text(
                AppText.infoCouncil,
                style: Theme
                    .of(context)
                    .textTheme
                    .displayMedium,
              ),
              const SizedBox(height: 2),
              Container(
                padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black, // black border
                    width: 1.0, // you can adjust the thickness here
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.createCouncil.council.firstName} ${widget
                          .createCouncil.council.lastName}',
                      style: Theme
                          .of(context)
                          .textTheme
                          .displaySmall,
                    ),
                    const SizedBox(height: _heightBetweenText),
                    Text(
                      '${AppText.loginLabelTextEmail} : ${widget.createCouncil
                          .email}',
                      style: Theme
                          .of(context)
                          .textTheme
                          .displaySmall,
                    ),
                    const SizedBox(height: _heightBetweenText),
                    Text(
                      '${AppText.phone} ${widget.createCouncil.council
                          .phone}',
                      style: Theme
                          .of(context)
                          .textTheme
                          .displaySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              Container(
                padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
                width: double.infinity,
                decoration: decorationRoundMainColor(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppText.adress,
                      style: Theme
                          .of(context)
                          .textTheme
                          .displayMedium,
                    ),
                    const SizedBox(height: AppUIValue.spaceScreenToAny / 2),
                    Text(
                      '${widget.createCouncil.adress.country}\n'
                          '${widget.createCouncil.adress.region}\n'
                          '${widget.createCouncil.adress.postalCode}, ${widget
                          .createCouncil.adress.city}\n'
                          '${widget.createCouncil.adress.street}\n\n'
                          '${AppText.commentary} : ${widget.createCouncil.adress
                          .comment ?? AppText.noCommentary}',
                      style: Theme
                          .of(context)
                          .textTheme
                          .displaySmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny * 2),
              Center(
                child: elevatedButtonAndTextColor(
                  AppColors.actionButtonColor.withOpacity(AppUIValue.opacityActionButton),
                    AppText.save,
                    context,
                    ()async => await widget.onRegister(),
                    Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
