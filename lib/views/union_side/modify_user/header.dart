import 'package:flutter/material.dart';
import 'package:front_syndic/core_value.dart';

import '../../../text/fr.dart';

class HeaderForModifyUserFromUnion extends StatelessWidget {
  const HeaderForModifyUserFromUnion({
    super.key,
    required this.onCategoryChange,
    required this.category,
  });

  final Function(String) onCategoryChange;
  final String category;


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(AppUIValue.spaceScreenToAny),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            buildText(AppText.user),
            SizedBox(width: AppUIValue.spaceScreenToAny*2),
            buildText(AppText.adress),
          ],
        ),
      ),
    );
  }

  GestureDetector buildText(String text){
    return GestureDetector(
      onTap: () {
        onCategoryChange(text);
      },
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: text == category ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
