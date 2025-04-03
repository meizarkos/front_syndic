import 'package:flutter/material.dart';

import '../../api_handler/change_passwd/change_passwd.dart';
import '../../core_value.dart';
import '../../text/fr.dart';
import '../../utils/email/check_email.dart';
import '../../widget/decoration/text_filed_deco_no_counter.dart';
import '../../widget/visibility/error.dart';

class ShowNewPasswd extends StatefulWidget {
  const ShowNewPasswd({super.key});

  @override
  State<ShowNewPasswd> createState() => _ShowNewPasswdState();
}

class _ShowNewPasswdState extends State<ShowNewPasswd> {

  final emailController = TextEditingController();
  var errorVisibilityEmail = false;
  var errorTextEmail = AppText.emailCantBeEmpty;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
          AppText.enterEmail,
          style: Theme.of(context).textTheme.displaySmall,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: roundBorderTextFieldWithoutCounter(AppText.emailWithoutAt),
            style: Theme.of(context).textTheme.displaySmall,
            maxLength: 256,
          ),
          ErrorVisibility(errorVisibility: errorVisibilityEmail, errorText: errorTextEmail),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context)
                .pop(); // Close the dialog without doing anything
          },
          style: TextButton.styleFrom(
            textStyle : Theme.of(context).textTheme.displaySmall,
            foregroundColor: Colors.black,
          ),
          child: Text(AppText.cancel),
        ),
        TextButton(
          onPressed: ()async{
            String email = emailController.text;
            if(email == ''){
              setState(() {
                errorVisibilityEmail = true;
                errorTextEmail = AppText.emailCantBeEmpty;
              });
            }
            else if(!isValidEmail(email)){
              setState(() {
                errorVisibilityEmail = true;
                errorTextEmail = AppText.emailFormatError;
              });
            }
            else{
              await requestNewPasswd(email);
              Navigator.of(context).pop();
            }
          },
          style: TextButton.styleFrom(
            textStyle : Theme.of(context).textTheme.displaySmall,
            foregroundColor: Colors.black,
          ),
          child: Text(AppText.send),
        ),
      ],
    );
  }
}
