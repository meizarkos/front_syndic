import 'package:flutter/material.dart';
import 'package:front_syndic/models/user/createUser.dart';

import '../../../api_handler/appartment/post_appartment.dart';
import '../../../color.dart';
import '../../../core_value.dart';
import '../../../text/fr.dart';
import '../../../utils/string_handler/handle_string.dart';
import '../../../widget/button/elevated_button_opacity.dart';
import '../../../widget/decoration/decoration_round_main_color.dart';
import '../../../widget/header/app_bar_back_button.dart';

class RecapUserFromUnion extends StatefulWidget {
  const RecapUserFromUnion({
    super.key,
    required this.createUser,
  });

  final CreateUser createUser;

  @override
  State<RecapUserFromUnion> createState() => _RecapUserFromUnionState();
}

class _RecapUserFromUnionState extends State<RecapUserFromUnion> {
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
              Center(
                child: Text(
                  '${toUpperFirst(widget.createUser.user.name ?? '')}\n'
                      '${toUpperFirst(widget.createUser.user.firstName ?? '')}\n\n'
                      '${widget.createUser.email ?? AppText.noEmail}\n'
                      '${widget.createUser.user.phone ?? AppText.noPhone}',
                  style: Theme
                      .of(context)
                      .textTheme
                      .displaySmall,
                  textAlign: TextAlign.center,
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
                      '${widget.createUser.adress.country}\n'
                          '${widget.createUser.adress.region}\n'
                          '${widget.createUser.adress.postalCode}, ${widget
                          .createUser.adress.city}\n'
                          '${widget.createUser.adress.street}\n\n'
                          '${AppText.commentary} : ${widget.createUser.adress.comment ?? AppText.noCommentary}',
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
                      ()async => await postUserWidget(widget.createUser),
                  Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> postUserWidget(CreateUser createUser) async {
    final response = await postUser(createUser);
    Navigator.pushNamedAndRemoveUntil(context, '/union_main', (Route<dynamic> route) => false);
  }
}
