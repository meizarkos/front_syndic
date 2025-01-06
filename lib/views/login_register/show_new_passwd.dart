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
      title: Text(AppText.enterEmail),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.2,
        child: Column(
          children: [
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: roundBorderTextFieldWithoutCounter(AppText.email),
              maxLength: 256,
            ),
            const SizedBox(height: AppUIValue.spaceScreenToAny),
            ErrorVisibility(errorVisibility: errorVisibilityEmail, errorText: errorTextEmail),
            const SizedBox(height: AppUIValue.spaceScreenToAny),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context)
                .pop(); // Close the dialog without doing anything
          },
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
          child: Text(AppText.send),
        ),
      ],
    );
  }
}
