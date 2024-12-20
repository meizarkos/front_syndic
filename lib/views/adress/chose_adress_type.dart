import 'package:flutter/material.dart';
import 'package:front_syndic/models/union/create_union.dart';
import 'package:front_syndic/views/adress/chose_adress.dart';

import '../../models/adress/adress.dart';
import '../../models/council/createCouncil.dart';

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
          Navigator.pushNamed(context, '/union/create_council/confirm', arguments: createCouncil)
        },
        adress: createCouncil.adress,
    );
  }
}

class ChoseAdressRegisterUnion extends StatelessWidget {
  const ChoseAdressRegisterUnion({
    super.key,
    required this.createUnion,
  });

  final CreateUnion createUnion;

  @override
  Widget build(BuildContext context) {
    return ChoseAdress(
      onRegister: (Adress address)=>{
        createUnion.adress = address,
        Navigator.pushNamed(context, '/union/get_identification', arguments: createUnion)
      },
      adress: createUnion.adress,
    );
  }
}
