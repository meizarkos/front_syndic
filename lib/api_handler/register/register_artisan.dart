import 'dart:convert';


import 'package:front_syndic/api_handler/request_with_body.dart';
import 'package:front_syndic/models/artisan/createArtisan.dart';

import '../../models/adress/adress.dart';

Future<void> registerArtisan(CreateArtisan createArtisan) async{
  //token a stocker dans le storage
  // "/register_union"
  try{
    final body = jsonEncode({
      "surf":{
        "email": createArtisan.email,
      },
      "adress":{
        "country":createArtisan.adress.country,
        "city":createArtisan.adress.city,
        "street":createArtisan.adress.street,
        "postal_code":createArtisan.adress.postalCode,
        "region":createArtisan.adress.region,
        AttributesAdress.comment : createArtisan.adress.comment,
      },
      "artisan":{
        "company_name": createArtisan.artisan.companyName,
        "first_name": createArtisan.artisan.firstName,
        "last_name": createArtisan.artisan.lastName,
        "siret_number": createArtisan.artisan.siretNumber,
        "phone": createArtisan.artisan.phone,
      },
    });
    return;
  }
  catch(e){
    print(e);
    return;
  }
}