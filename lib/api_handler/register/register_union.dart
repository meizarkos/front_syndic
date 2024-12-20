import 'dart:convert';


import 'package:front_syndic/api_handler/request_with_body.dart';
import 'package:front_syndic/models/union/create_union.dart';

Future<String> registerUnion(CreateUnion createUnion) async{
  //token a stocker dans le storage
  // "/register_union"
  try{
    final body = jsonEncode({
      "surf":{
        "password":createUnion.password,
        "email": createUnion.email,
      },
      "adress":{
        "country":createUnion.adress.country,
        "city":createUnion.adress.city,
        "street":createUnion.adress.street,
        "postal_code":createUnion.adress.postalCode,
        "region":createUnion.adress.region,
      },
      "union":{
        "administrator_name": createUnion.union.administratorName,
        "administrator_first_name": createUnion.union.administratorFirstName,
        "name": createUnion.union.name,
        "siret_number": createUnion.union.siretNumber,
        "phone": createUnion.union.phone,
      }
    });
    final response = await requestWithBody(url: 'register_union', method: "POST", body: body);
    if(response.statusCode == 201){
      return 'Bearer ${response.data['token']}';
    }
    return '';
  }
  catch(e){
    print(e);
    return '';
  }
}