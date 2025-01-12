import 'package:flutter/material.dart';

import '../../text/fr.dart';

AlertDialog showDialogText(BuildContext context, String title, String text, VoidCallback onOk) {
  return AlertDialog(
    title: Text(
        title,
        style: Theme.of(context).textTheme.displayMedium,
    ),
    content: Text(
        text,
        style: Theme.of(context).textTheme.displaySmall,
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(
            AppText.cancel,
            style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      TextButton(
        onPressed: () {
          onOk();
          Navigator.of(context).pop();
        },
        child: Text(
          AppText.validate,
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
    ],
  );
}

void showMyAlert(BuildContext context, String title, String text, VoidCallback onOk) {
  showDialog(
    context: context,
    builder: (BuildContext context) => showDialogText(
      context,
      title,
      text,
      onOk,
    ),
  );
}

