import 'package:front_syndic/models/appartment/appartment.dart';

import '../../core_value.dart';
import '../request.dart';

Future<List<Apartment>?> getAllApartment(String route)async{
  try{
    final response = await request(url: route, method: "GET");
    final apartments = (response.data as List)
        .map((recordJson) => Apartment.fromJson(recordJson))
        .toList();
    return apartments;
  }catch(e){
    return null;
  }
}

Future<List<Apartment>?> getAllApartmentActive()async{
  return await getAllApartment('${APIValue.union}get_all_appartment');
}

Future<List<Apartment>?> getAllApartmentInactive()async{
  return await getAllApartment('${APIValue.union}get_all_appartment_inactive');
}