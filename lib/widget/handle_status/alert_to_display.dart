import 'package:flutter/material.dart';

import '../../text/fr.dart';

void handleStatus(int? status, int? statusGoal, BuildContext context, Function pushToEstimateTiming){
  if(status == statusGoal){
    pushToEstimateTiming();
  }
  else{
    showDialog(
      context: context, // Pass the context from your widget
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(AppText.estimateNotValidateShowDialog,),
          actions: [
            TextButton(
              child: Text(AppText.cancel),
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Close the dialog without doing anything
              },
            ),
          ],
        );
      },
    );
  }
}