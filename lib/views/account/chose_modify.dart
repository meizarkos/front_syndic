import 'package:flutter/material.dart';
import 'package:front_syndic/core_value.dart';
import 'package:front_syndic/widget/header/app_bar_back_button.dart';

import '../../text/fr.dart';

class ChoseModifyCategories extends StatelessWidget {
  const ChoseModifyCategories({
    super.key,
    required this.list,
  });

  final List<GestureDetector> list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBackButton(context,title: AppText.account),
      body: Padding(
          padding: EdgeInsets.all(AppUIValue.spaceScreenToAny),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...list,
            ],
          ),
      ),
    );
  }
}
