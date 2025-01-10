import 'package:flutter/material.dart';

import '../../core_value.dart';
import '../../text/fr.dart';
import '../../widget/cell_app_bar_in_progress/createButton.dart';

AppBar estimateAppBar(BuildContext context, VoidCallback conv, VoidCallback date) {
  return AppBar(
    toolbarHeight: 80.0,
    leading: IconButton(
      icon: Icon(Icons.arrow_back),
      color: Colors.black,
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    title: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
          padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
          child: Row(
            children: [
              createButton(
                context,
                AppText.timingEstimate,
                date,
              ),
              const SizedBox(width: 10),
              createButton(
                context,
                AppText.seeConversation,
                conv,
              ),
            ],
          )),
    ),
  );
}