import 'package:flutter/material.dart';
import 'package:front_syndic/text/fr.dart';

import '../../core_value.dart';
import 'chose_modify.dart';


GestureDetector textGo(BuildContext context, String text, String route) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, route);
    },
    child: Container(
      margin: EdgeInsets.only(bottom : AppUIValue.spaceScreenToAny * 3),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

class ChoseModifyTypeArtisan extends StatelessWidget {
  const ChoseModifyTypeArtisan({super.key});

  @override
  Widget build(BuildContext context) {
    return ChoseModifyCategories(
      list: [
        textGo(context, AppText.myData, '/artisan/modify_artisan'),
        textGo(context, AppText.myAdress, '/modify_artisan_address'),
        textGo(context, AppText.myBank, '/modify_artisan_phone'),
        textGo(context,AppText.myLogin, '/modify_artisan_email'),
      ],
    );
  }
}