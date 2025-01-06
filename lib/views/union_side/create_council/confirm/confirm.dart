import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/text/fr.dart';
import 'package:front_syndic/widget/button/elevated_button_opacity.dart';
import 'package:front_syndic/widget/header/app_bar_back_button.dart';
import 'package:front_syndic/widget/visibility/error.dart';

import '../../../../api_handler/council/post_council.dart';
import '../../../../models/council/createCouncil.dart';

const _heightBetweenText = 5.0;

class ConfirmCreationCouncilUnion extends StatefulWidget {
  const ConfirmCreationCouncilUnion({
    super.key,
    required this.createCouncil,
  });

  final CreateCouncil createCouncil;

  @override
  State<ConfirmCreationCouncilUnion> createState() =>
      _ConfirmCreationCouncilUnionState();
}

class _ConfirmCreationCouncilUnionState
    extends State<ConfirmCreationCouncilUnion> {

  bool errorVisibility = false;

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
                  ()async{
                    await postCouncilUnion(widget.createCouncil);
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/union_main',
                      (Route<dynamic> route) => false,
                    );
                  },
                  AppColors.mainTextColor
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
