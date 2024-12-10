import 'package:flutter/material.dart';
import 'package:front_syndic/views/union_side/create_council/adress/chose_adress.dart';

import '../../../../models/adress/adress.dart';
import '../../../../models/council/createCouncil.dart';

class ChoseAdressCreateCouncil extends StatelessWidget {
  const ChoseAdressCreateCouncil({
    super.key,
    required this.createCouncil,
  });

  final CreateCouncil createCouncil;

  @override
  Widget build(BuildContext context) {
    return ChoseAdress(
        onRegister: (Adress address)=>{
          createCouncil.adress = address,
          Navigator.pushNamed(context, '/create_council/confirm', arguments: createCouncil)
        },
        adress: createCouncil.adress,
    );
  }
}
