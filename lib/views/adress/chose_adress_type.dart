import 'package:flutter/material.dart';
import 'package:front_syndic/models/artisan/createArtisan.dart';
import 'package:front_syndic/models/union/create_union.dart';
import 'package:front_syndic/views/adress/chose_adress.dart';

import '../../api_handler/adress/fetch_prefill_adress.dart';
import '../../models/adress/adress.dart';
import '../../models/council/createCouncil.dart';
import '../../models/work_request/create_work_request.dart';

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

class ChoseAdressRegisterCouncil extends StatelessWidget {
  const ChoseAdressRegisterCouncil({
    super.key,
    required this.createCouncil,
  });

  final CreateCouncil createCouncil;

  @override
  Widget build(BuildContext context) {
    return ChoseAdress(
      onRegister: (Adress address)=>{
        createCouncil.adress = address,
        Navigator.pushNamed(context, 'council/get_passwd', arguments: createCouncil)
      },
      adress: createCouncil.adress,
    );
  }
}

class ChoseAdressRegisterArtisan extends StatelessWidget {
  const ChoseAdressRegisterArtisan({
    super.key,
    required this.createArtisan,
  });

  final CreateArtisan createArtisan;

  @override
  Widget build(BuildContext context) {
    return ChoseAdress(
      onRegister: (Adress address)=>{
        createArtisan.adress = address,
        Navigator.pushNamed(context, '/artisan/get_passwd', arguments: createArtisan)
      },
      adress: createArtisan.adress,
    );
  }
}

class CreateWorkRequestAdressUnion extends StatelessWidget {
  const CreateWorkRequestAdressUnion({
    super.key,
    required this.createWorkRequest,
  });

  final CreateWorkRequest createWorkRequest;

  @override
  Widget build(BuildContext context) {
    return ChoseAdress(
      onRegister: (Adress address)=>{
        createWorkRequest.adress = address,
        Navigator.pushNamed(context, 'union/work_requests/chose_date_time', arguments: createWorkRequest)
      },
      adress: createWorkRequest.adress,
      prefillAdress: ()async{
        return await fetchAdressCouncilFromUnion(createWorkRequest.workRequest.councilId);
      },
    );
  }
}

class CreateWorkRequestAdressCouncil extends StatelessWidget {
  const CreateWorkRequestAdressCouncil({
    super.key,
    required this.createWorkRequest,
  });

  final CreateWorkRequest createWorkRequest;

  @override
  Widget build(BuildContext context) {
    return ChoseAdress(
      onRegister: (Adress address)=>{
        createWorkRequest.adress = address,
        Navigator.pushNamed(context, '/work_requests/chose_date_time', arguments: createWorkRequest)
      },
      adress: createWorkRequest.adress,
      prefillAdress: ()async{
        return await fetchAdressCouncil();
      },
    );
  }
}

