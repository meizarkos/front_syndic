import 'package:flutter/material.dart';
import 'package:front_syndic/widget/header/app_bar_back_button.dart';

import '../../../text/fr.dart';
import 'handler_body_user_modif_from_union.dart';
import 'header.dart';

class MainModifyUserFromUnion extends StatefulWidget {
  const MainModifyUserFromUnion({
    super.key,
    required this.apartmentUuid,
  });

  final String? apartmentUuid;

  @override
  State<MainModifyUserFromUnion> createState() => _MainModifyUserFromUnionState();
}

class _MainModifyUserFromUnionState extends State<MainModifyUserFromUnion> {

  String category = AppText.council;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBackButton(context),
      body: Column(
        children: [
          SizedBox(
            height: 100,
            child: HeaderForModifyUserFromUnion(
              onCategoryChange: onCategoryChange,
              category: category,
            ),
          ),
          Expanded(child:handlerBodyForModifyUserFromUnion(category, widget.apartmentUuid),)
        ],
      ),
    );
  }

  void onCategoryChange(String category) {
    setState(() {
      this.category = category;
    });
  }
}
