import 'package:flutter/material.dart';
import 'package:front_syndic/color.dart';
import 'package:front_syndic/text.dart';
import 'package:front_syndic/widget/header/header_for_all.dart';
import 'package:front_syndic/widget/visibility/error.dart';

import '../../widget/header/app_bar_size.dart';

class ConnectAll extends StatefulWidget {
  const ConnectAll({super.key});

  @override
  State<ConnectAll> createState() => _ConnectAllState();
}

class _ConnectAllState extends State<ConnectAll> {
  var email = 'aaa@aaa.com';
  var password = 'aaa';
  var errorVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: appBarSize(context),
        child: const HeaderForAll(),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0), // Add padding around the text
            child: Center(
              child: Text(
                LoginStrings.seConnecter,
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0), // Add padding around the text
            child: Center(
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    email = value; // Update the email variable
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // Set corner radius here
                  ),
                  labelText: LoginStrings.email,
                ),
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0), // Add padding around the text
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
                    borderRadius:
                        BorderRadius.circular(10.0), // Set corner radius here
                  ),
                  labelText: LoginStrings.password,
                ),
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
          ),
          ErrorVisibility(
              errorVisibility: errorVisibility, errorText: LoginStrings.errorText
          ),
          Padding(
            padding: const EdgeInsets.all(15.0), // Add padding around the text
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    errorVisibility = true;
                  });
                  //sendConnexionRequest(email, password, widget.route,_handleErrorText, _handleErrorVisibility,_pushToConnectSuccess);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainBackgroundColor, // Background color
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 20.0), // Button padding
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ), // Text style
                ),
                child: const Text(
                  LoginStrings.seConnecter,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Text(
                LoginStrings.register,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
