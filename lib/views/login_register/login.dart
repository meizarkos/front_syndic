import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/text/fr.dart';
import 'package:front_syndic/views/login_register/show_new_passwd.dart';
import 'package:front_syndic/widget/header/header_for_all.dart';
import 'package:front_syndic/widget/visibility/error.dart';

import '../../api_handler/login/login.dart';
import '../../widget/header/app_bar_size.dart';

class ConnectAll extends StatefulWidget {
  const ConnectAll({super.key});

  @override
  State<ConnectAll> createState() => _ConnectAllState();
}

class _ConnectAllState extends State<ConnectAll> {
  var email = 'council@council.com';
  var password = 'aaa';
  var errorVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: appBarSize(context),
        child: const HeaderForAll(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny), // Add padding around the text
              child: Center(
                child: Text(
                  AppText.loginTitle,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
            ), // Add padding around the text
            Padding(
              padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny), // Add padding around the text
              child: Center(
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      email = value; // Update the email variable
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppUIValue
                          .textInputBorderRadius), // Set corner radius here
                    ),
                    labelText: AppText.loginLabelTextEmail,
                  ),
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny), // Add padding around the text
              child: Center(
                child: TextField(
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      password = value; // Update the email variable
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppUIValue
                          .textInputBorderRadius), // Set corner radius here
                    ),
                    labelText: AppText.loginLabelTextPassword,
                  ),
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
            ),
            ErrorVisibility(
                errorVisibility: errorVisibility,
                errorText: AppText.loginErrorText),
            const SizedBox(height: AppUIValue.spaceScreenToAny),
            Padding(
              padding: const EdgeInsets.all(10), // Add padding around the text
              child: Center(
                child: ElevatedButton(
                  onPressed: () async {
                    var res = await sendConnexionRequest(
                        email, password, () => _handleErrorVisibility());
                    _pushTo(res);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainBackgroundColor,
                    // Background color
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    textStyle: const TextStyle(
                      fontSize: 16,
                    ),
                    elevation: AppUIValue.elevation,
                    shadowColor: Colors.black,
                  ),
                  child: Text(
                    AppText.loginConnectionButtonText,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.mainTextColor,
                      shadows: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 1,
                          spreadRadius: 1,
                          blurStyle: BlurStyle.inner,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppUIValue.spaceScreenToAny),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                // Add padding around the text
                child: Center(
                  child: Text(
                    AppText.loginLinkToRegister,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppUIValue.spaceScreenToAny),
            GestureDetector(
              onTap: () {
                _enterPasswd(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
                // Add padding around the text
                child: Center(
                  child: Text(
                    AppText.forgottenPasswd,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleErrorVisibility() {
    setState(() {
      errorVisibility = true;
    });
  }

  void _pushTo(List<String?> response) {
    if (response[1] == null) {
      return;
    }
    if (response[0] == '0') {
      Navigator.pushNamed(context, response[1]!);
    } else {
      return;
    }
  }

  void _enterPasswd(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => const ShowNewPasswd(),
    );
  }
}
