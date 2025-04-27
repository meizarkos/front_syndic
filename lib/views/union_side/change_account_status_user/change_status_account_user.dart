import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/widget/button/elevated_button_opacity.dart';
import 'package:front_syndic/widget/header/app_bar_back_button.dart';

import '../../../models/appartment/appartment.dart';
import '../../../text/fr.dart';
import '../../../widget/decoration/decoration_round_main_color.dart';

class UserChangeAccount extends StatefulWidget {
  const UserChangeAccount({
    super.key,
    required this.fetchApartment,
    required this.patchUser,
    required this.text,
  });

  final Future<Apartment?> fetchApartment;
  final Future patchUser;
  final String text;

  @override
  State<UserChangeAccount> createState() => _UserChangeAccountState();
}

class _UserChangeAccountState extends State<UserChangeAccount> {

  Apartment? apartment = Apartment();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    widget.fetchApartment.then((value) {
      setState(() {
        isLoading = false;
      });
      if (value?.uuid != null) {
        setState(() {
          apartment = value;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    if(isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if(apartment?.uuid == null) {
      return Scaffold(
        appBar: appBarBackButton(context,title: AppText.validateUser),
        body: Center(
          child: Text(AppText.apiErrorText),
        ),
      );
    }
    return Scaffold(
      appBar: appBarBackButton(context,title: AppText.validateUser),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppText.name,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 5),
              Text(
                '${apartment?.user?.name ?? ''} ${apartment?.user?.firstName ?? ''}',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              Text(
                AppText.phone,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 5),
              Text(
                (apartment?.user?.phone ?? '').replaceAllMapped(RegExp(r".{2}"), (match) => '${match.group(0)} ').trim(),
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
                decoration: decorationRoundMainColor(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppText.adress,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(height: AppUIValue.spaceScreenToAny),
                    Text(
                      '${apartment?.adress?.street ?? ''}\n${apartment?.adress?.postalCode ?? ''},${apartment?.adress?.city ?? ''}\n${apartment?.adress?.country ?? ''}',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppUIValue.spaceScreenToAny),
              Center(
                child: elevatedButtonAndTextColor(
                  AppColors.mainBackgroundColor,
                  widget.text,
                  context,
                      () {
                    showConfirmationDialog(context);
                  },
                  AppColors.mainTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,  // Prevents closing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppText.confirm),
          content: Text(AppText.confirmArtisanPatchAccount),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(AppText.cancel),
            ),
            TextButton(
              onPressed: () async{
                await widget.patchUser;
                goTo();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void goTo(){
    Navigator.pushNamedAndRemoveUntil(context, '/union_main', ( route ) => false);
  }
}
