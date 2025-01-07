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
          fontSize: 16,
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
        textGo(context, AppText.myAdress, '/artisan/modify_artisan_address'),
        textGo(context, AppText.myBank, '/modify_artisan_phone'),
        textGo(context,AppText.myLogin, '/artisan/modify_surf'),
      ],
    );
  }
}

class ChoseModifyTypeCouncil extends StatelessWidget {
  const ChoseModifyTypeCouncil({super.key});

  @override
  Widget build(BuildContext context) {
    return ChoseModifyCategories(
      list: [
        textGo(context, AppText.myData, '/council/modify_council'),
        textGo(context, AppText.myAdress, '/council/modify_council_address'),
        textGo(context,AppText.myLogin, '/council/modify_surf'),
      ],
    );
  }
}

class ChoseModifyTypeUnion extends StatelessWidget {
  const ChoseModifyTypeUnion({super.key});

  @override
  Widget build(BuildContext context) {
    return ChoseModifyCategories(
      list: [
        textGo(context, AppText.myData, '/union/modify_account'),
        textGo(context, AppText.myAdress, '/union/modify_union_address'),
        textGo(context,AppText.myLogin, '/union/modify_surf'),
      ],
    );
  }
}
