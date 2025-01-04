import 'package:flutter/material.dart';
import 'package:front_syndic/widget/header/app_bar_back_button.dart';

import '../../../text/fr.dart';
import 'handler_body_council_modif_from_union.dart';
import 'header.dart';

class MainModifyCouncilFromUnion extends StatefulWidget {
  const MainModifyCouncilFromUnion({
    super.key,
    required this.councilId,
  });

  final String? councilId;

  @override
  State<MainModifyCouncilFromUnion> createState() => _MainModifyCouncilFromUnionState();
}

class _MainModifyCouncilFromUnionState extends State<MainModifyCouncilFromUnion> {

  String category = AppText.council;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBackButton(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: HeaderForModifyCouncilFromUnion(
                onCategoryChange: onCategoryChange,
                category: category,
              ),
            ),
            handlerBodyForModifyCouncilFromUnion(category, widget.councilId),
          ],
        ),
      ),
    );
  }

  void onCategoryChange(String category) {
    setState(() {
      this.category = category;
    });
  }
}
